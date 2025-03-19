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
use Illuminate\Support\Facades\DB;
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
      $tglSekarang = Carbon::now()->format('Y/m/d');

        $transactions = Transaction::with('account', 'category', 'user')
            ->whereDate('date', today())
            ->orderByDesc('created_at')
            ->get();

      $balances = Balance::with('account')->get();

      $chartData = [
          'labels' => $balances->pluck('account.name')->toArray(),
          'data' => $balances->pluck('balance')->toArray(),
          'total' => $balances->sum('balance')
      ];

      $incomes = Transaction::where('type', 'pemasukan')
          ->whereDate('date', $tglSekarang)
          ->with('category')
          ->selectRaw('category_id, SUM(amount) as total')
          ->groupBy('category_id')
          ->get();

      $chartIncomeData = [
          'labels' => $incomes->pluck('category.name')->toArray(),
          'data' => $incomes->pluck('total')->toArray(),
      ];

      $salaryCategoryId = Category::where('name', 'gaji')->value('id');

      $expenses = Transaction::where('type', 'pengeluaran')
          ->where('category_id', '!=', $salaryCategoryId)
          ->whereDate('date', $tglSekarang)
          ->with('category')
          ->selectRaw('category_id, SUM(amount) as total')
          ->groupBy('category_id')
          ->get();

      $chartExpenseData = [
          'labels' => $expenses->pluck('category.name')->toArray(),
          'data' => $expenses->pluck('total')->toArray(),
      ];

        return view('transaksi.index', [
            'transactions'  => $transactions,
            'hari'          => Carbon::now()->translatedFormat('l, d F Y'),
            'totalBalance' => $chartData['total'],
            'chartData' => json_encode($chartData),
            'chartIncomeData' => json_encode($chartIncomeData),
            'chartExpenseData' => json_encode($chartExpenseData),
            'totalIncome' => Transaction::where('type', 'pemasukan')->whereDate('date', $tglSekarang)->sum('amount'),
            'totalExpense' => Transaction::where('type', 'pengeluaran')->whereDate('date', $tglSekarang)->sum('amount'),
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


  public function update(Request $request, $id): RedirectResponse
  {
    $request->validate([
        'date' => 'required|date',
        'type' => 'required|in:pemasukan,pengeluaran,pindah',
        'account_id' => 'required|exists:accounts,id',
        'category_id' => 'required|exists:categories,id',
        'target_account_id' => 'nullable|exists:accounts,id',
        'amount' => 'required|numeric|min:0',
        'descriptions' => 'nullable|string',
    ]);

    $transaction = Transaction::findOrFail($id);
    $oldAmount = $transaction->amount;
    $oldType = $transaction->type;
    $oldAccount = $transaction->account_id;
    $oldTargetAccount = $transaction->target_account_id;

    DB::transaction(function () use ($request, $transaction, $oldAmount, $oldType, $oldAccount, $oldTargetAccount) {
      // Kembalikan saldo ke keadaan sebelum transaksi lama
      if ($oldType === 'pemasukan') {
        Balance::where('account_id', $oldAccount)->decrement('balance', $oldAmount);
      } elseif ($oldType === 'pengeluaran') {
        Balance::where('account_id', $oldAccount)->increment('balance', $oldAmount);
      } elseif ($oldType === 'pindah') {
        Balance::where('account_id', $oldAccount)->increment('balance', $oldAmount);
        Balance::where('account_id', $oldTargetAccount)->decrement('balance', $oldAmount);
      }

      // Perbarui transaksi dengan data baru
      $transaction->update($request->only(['date', 'type', 'account_id', 'category_id', 'target_account_id', 'amount', 'descriptions']));

      // Perbarui saldo sesuai transaksi baru
      if ($request->type === 'pemasukan') {
        Balance::where('account_id', $request->account_id)->increment('balance', $request->amount);
      } elseif ($request->type === 'pengeluaran') {
        Balance::where('account_id', $request->account_id)->decrement('balance', $request->amount);
      } elseif ($request->type === 'pindah') {
        Balance::where('account_id', $request->account_id)->decrement('balance', $request->amount);
        Balance::where('account_id', $request->target_account_id)->increment('balance', $request->amount);
      }
    });

    return redirect()->route('transaksi')->with('success', 'Transaksi berhasil diperbarui');
  }


  public function destroy($id): RedirectResponse
  {
    $transaction = Transaction::findOrFail($id);
    $accountId = $transaction->account_id;
    $targetAccountId = $transaction->target_account_id;

    $balance = Balance::where('account_id', $accountId)->firstOrFail();

    if ($transaction->type === 'pemasukan') {
      $balance->balance -= $transaction->amount;
    } elseif ($transaction->type === 'pengeluaran' || $transaction->type === 'pindah') {
      $balance->balance += $transaction->amount;
    }

    $balance->save();

    if ($transaction->type === 'pindah' && $targetAccountId) {
      $targetBalance = Balance::where('account_id', $targetAccountId)->first();

      if ($targetBalance) {
        $targetBalance->balance -= $transaction->amount;
        $targetBalance->save();
      }
    }

    $transaction->delete();

    return redirect()->route('transaksi')->with('success', 'Transaksi berhasil dihapus!');
  }
}
