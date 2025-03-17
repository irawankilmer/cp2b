<?php

namespace App\Http\Controllers;

use App\Imports\TransactionImport;
use App\Models\Account;
use App\Models\Balance;
use App\Models\Category;
use App\Models\Transaction;
use Carbon\Carbon;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Maatwebsite\Excel\Facades\Excel;

class TransactionController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): View
    {
        setlocale(LC_TIME, 'id_ID');
        Carbon::setLocale('id');

        $transactions = Transaction::with('account', 'category', 'user')
            ->whereDate('date', today())
            ->orderByDesc('created_at')
            ->get();

        return view('transaksi.index', [
            'transactions'  => $transactions,
            'hari'          => Carbon::now()->translatedFormat('l, d F Y'),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(): View
    {
        $accounts = Account::all();
        $categories = Category::all();

        return view('transaksi.create', [
            'accounts'      => $accounts,
            'categories'    => $categories
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request): RedirectResponse
    {
        $validatedData = $request->validate([
            'date' => 'required|date',
            'type' => 'required|in:pemasukan,pengeluaran,pindah',
            'account_id' => 'required|exists:accounts,id',
            'target_account_id' => 'nullable|exists:accounts,id|required_if:type,pindah',
            'category_id' => 'required|exists:categories,id',
            'amount' => 'required|numeric|min:0.01',
            'descriptions' => 'nullable|string',
        ]);

        // Ambil saldo akun asal
        $balance = Balance::firstOrCreate(
            ['account_id' => $validatedData['account_id']],
            ['balance' => 0]
        );

        // Hitung saldo setelah transaksi
        $newBalance = match ($validatedData['type']) {
            'pemasukan' => $balance->balance + $validatedData['amount'],
            'pengeluaran' => $balance->balance - $validatedData['amount'],
            'pindah' => $balance->balance - $validatedData['amount'],
        };

        // Simpan transaksi
        $transaction = Transaction::create(array_merge($validatedData, [
            'user_id' => auth()->id(),
            'balance_after' => $newBalance,
        ]));

        // Update saldo akun asal
        $balance->update(['balance' => $newBalance]);

        // Update saldo akun tujuan jika pindah saldo
        if ($validatedData['type'] === 'pindah') {
            $targetBalance = Balance::firstOrCreate(
                ['account_id' => $validatedData['target_account_id']],
                ['balance' => 0]
            );
            $targetBalance->update(['balance' => $targetBalance->balance + $validatedData['amount']]);
        }

        return redirect()->route('transaksi')->with('success', 'Transaksi berhasil disimpan!');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id): View
    {
      $transaction = Transaction::find($id);
      $accounts = Account::all();
      $categories = Category::all();
      return view('transaksi.edit', compact(
          'transaction',
          'accounts',
          'categories'
      ));
    }

    /**
     * Update the specified resource in storage.
     */
  public function update(Request $request, $id): RedirectResponse
  {
    $validatedData = $request->validate([
        'date' => 'required|date',
        'type' => 'required|in:pemasukan,pengeluaran,pindah',
        'account_id' => 'required|exists:accounts,id',
        'target_account_id' => 'nullable|exists:accounts,id|required_if:type,pindah',
        'category_id' => 'required|exists:categories,id',
        'amount' => 'required|numeric|min:0.01',
        'descriptions' => 'nullable|string',
    ]);

    $transaction = Transaction::findOrFail($id);
    $oldAmount = $transaction->amount;
    $oldType = $transaction->type;
    $oldAccountId = $transaction->account_id;
    $oldTargetAccountId = $transaction->target_account_id;

    // Hitung selisih perubahan jumlah
    $amountDifference = $validatedData['amount'] - $oldAmount;

    // Update saldo akun asal
    $balance = Balance::where('account_id', $transaction->account_id)->firstOrFail();

    if ($oldType === 'pemasukan') {
      $balance->balance -= $oldAmount; // Revert saldo sebelum update
    } elseif ($oldType === 'pengeluaran' || $oldType === 'pindah') {
      $balance->balance += $oldAmount;
    }

    // Simpan transaksi yang diperbarui
    $transaction->update(array_merge($validatedData, [
        'user_id' => auth()->id(),
    ]));

    // Hitung saldo baru berdasarkan jenis transaksi yang diupdate
    if ($validatedData['type'] === 'pemasukan') {
      $balance->balance += $validatedData['amount'];
    } elseif ($validatedData['type'] === 'pengeluaran' || $validatedData['type'] === 'pindah') {
      $balance->balance -= $validatedData['amount'];
    }

    $balance->save();

    // Jika transaksi pindah saldo, update saldo akun tujuan
    if ($oldType === 'pindah' && $oldTargetAccountId) {
      $oldTargetBalance = Balance::where('account_id', $oldTargetAccountId)->first();
      $oldTargetBalance->balance -= $oldAmount; // Revert saldo tujuan sebelum update
      $oldTargetBalance->save();
    }

    if ($validatedData['type'] === 'pindah' && $validatedData['target_account_id']) {
      $targetBalance = Balance::firstOrCreate(
          ['account_id' => $validatedData['target_account_id']],
          ['balance' => 0]
      );
      $targetBalance->balance += $validatedData['amount'];
      $targetBalance->save();
    }

    // Recalculate saldo untuk semua transaksi berikutnya
    $this->recalculateBalances($transaction->account_id);

    return redirect()->route('transaksi')->with('success', 'Transaksi berhasil diperbarui!');
  }

  private function recalculateBalances($accountId, $deletedTransactionDate)
  {
    $previousTransaction = Transaction::where('account_id', $accountId)
        ->where('date', '<', $deletedTransactionDate)
        ->orderBy('date', 'desc')
        ->orderBy('created_at', 'desc')
        ->first();

    $startingBalance = $previousTransaction ? $previousTransaction->balance_after : 0;

    $transactions = Transaction::where('account_id', $accountId)
        ->where('date', '>=', $deletedTransactionDate)
        ->orderBy('date')
        ->orderBy('created_at')
        ->get();

    $balance = $startingBalance;

    foreach ($transactions as $trx) {
      if ($trx->type === 'pemasukan') {
        $balance += $trx->amount;
      } elseif ($trx->type === 'pengeluaran' || $trx->type === 'pindah') {
        $balance -= $trx->amount;
      }

      $trx->update(['balance_after' => $balance]);
    }

    Balance::where('account_id', $accountId)->update(['balance' => $balance]);
  }



  /**
     * Remove the specified resource from storage.
     */
  public function destroy($id): RedirectResponse
  {
    $transaction = Transaction::findOrFail($id);
    $accountId = $transaction->account_id;
    $transactionDate = $transaction->date;

    $balance = Balance::where('account_id', $accountId)->firstOrFail();

    if ($transaction->type === 'pemasukan') {
      $balance->balance -= $transaction->amount;
    } elseif ($transaction->type === 'pengeluaran' || $transaction->type === 'pindah') {
      $balance->balance += $transaction->amount;
    }

    $balance->save();

    $transaction->delete();

    $this->recalculateBalances($accountId, $transactionDate);

    return redirect()->route('transaksi')->with('success', 'Transaksi berhasil dihapus!');
  }



  public function import(): View
    {
        return view('transaksi.import');
    }

    public function importstore(Request $request): RedirectResponse
    {
        Excel::import(new TransactionImport, $request->file('file'));

        return redirect()->route('transaksi')->with('success', 'Data berhasil diimport!');
    }
}
