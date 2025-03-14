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
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
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
