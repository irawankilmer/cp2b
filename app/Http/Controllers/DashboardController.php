<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Transaction;
use Illuminate\Http\Request;
use Illuminate\View\View;
use App\Models\Balance;

class DashboardController extends Controller
{
    public function index(): View
    {
        $balances = Balance::with('account')->get();

        $chartData = [
            'labels' => $balances->pluck('account.name')->toArray(),
            'data' => $balances->pluck('balance')->toArray(),
            'total' => $balances->sum('balance')
        ];

        $salaryCategoryId = Category::where('name', 'gaji')->value('id');

        $expenses = Transaction::where('type', 'pengeluaran')
            ->where('category_id', '!=', $salaryCategoryId)
            ->with('category')
            ->selectRaw('category_id, SUM(amount) as total')
            ->groupBy('category_id')
            ->get();

        $chartExpenseData = [
            'labels' => $expenses->pluck('category.name')->toArray(),
            'data' => $expenses->pluck('total')->toArray(),
        ];

      $incomes = Transaction::where('type', 'pemasukan')
          ->with('category')
          ->selectRaw('category_id, SUM(amount) as total')
          ->groupBy('category_id')
          ->get();

      $chartIncomeData = [
          'labels' => $incomes->pluck('category.name')->toArray(),
          'data' => $incomes->pluck('total')->toArray(),
      ];

        return view('dashboard', [
            'chartData' => json_encode($chartData),
            'chartExpenseData' => json_encode($chartExpenseData),
            'chartIncomeData' => json_encode($chartIncomeData),
            'totalBalance' => $chartData['total'],
            'totalIncome' => Transaction::where('type', 'pemasukan')->sum('amount'),
            'totalExpense' => Transaction::where('type', 'pengeluaran')->sum('amount'),
        ]);
    }
}
