<?php

namespace App\Http\Controllers;

use App\Models\Transaction;
use App\Models\Account;
use App\Models\Category;
use Illuminate\Http\Request;

class ChartDetailController extends Controller
{
    public function show($type, $id, Request $request)
    {
        $scope = $request->query('scope');
        $name = '';
        $transactions = collect();

        if ($scope === 'account') {
            $account = Account::find($id);
            $name = $account->name ?? '-';
            $transactions = Transaction::where('account_id', $id)->get();

        } elseif ($scope === 'income') {
            $category = Category::find($id);
            $name = $category->name ?? '-';
            $transactions = Transaction::where('category_id', $id)
                ->where('type', 'pemasukan')
                ->get();

        } elseif ($scope === 'expense') {
            $category = Category::find($id);
            $name = $category->name ?? '-';
            $transactions = Transaction::where('category_id', $id)
                ->where('type', 'pengeluaran')
                ->get();
        }

        $totalIncome = $transactions->where('type', 'pemasukan')->sum('amount');
        $totalExpense = $transactions->where('type', 'pengeluaran')->sum('amount');

        $chartData = [
            'labels' => $transactions->pluck('date')->map(fn($d) => $d->format('d M'))->toArray(),
            'income' => $transactions->where('type', 'pemasukan')->pluck('amount')->toArray(),
            'expense' => $transactions->where('type', 'pengeluaran')->pluck('amount')->toArray(),
        ];

        return view('chartdetail.show', compact('transactions', 'totalIncome', 'totalExpense', 'chartData', 'type', 'name'));
    }
}
