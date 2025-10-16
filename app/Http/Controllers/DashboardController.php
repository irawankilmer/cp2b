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
    // 1️⃣ Data saldo akun
    $balances = Balance::with('account')->get();

    $chartData = [
      'labels' => $balances->pluck('account.name')->toArray(),
      'data' => $balances->pluck('balance')->toArray(),
      'ids' => $balances->pluck('account.id')->toArray(),
      'total' => $balances->sum('balance'),
    ];

    // 2️⃣ Data pengeluaran
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
      'ids' => $expenses->pluck('category.id')->toArray(),
    ];

    // 3️⃣ Data pemasukan
    $incomes = Transaction::where('type', 'pemasukan')
      ->with('category')
      ->selectRaw('category_id, SUM(amount) as total')
      ->groupBy('category_id')
      ->get();

    $chartIncomeData = [
      'labels' => $incomes->pluck('category.name')->toArray(),
      'data' => $incomes->pluck('total')->toArray(),
      'ids' => $incomes->pluck('category.id')->toArray(),
    ];

    // 4️⃣ Kirim langsung tanpa json_encode
    return view('dashboard', [
      'chartData' => $chartData,
      'chartExpenseData' => $chartExpenseData,
      'chartIncomeData' => $chartIncomeData,
      'totalBalance' => $chartData['total'],
      'totalIncome' => Transaction::where('type', 'pemasukan')->sum('amount'),
      'totalExpense' => Transaction::where('type', 'pengeluaran')->sum('amount'),
    ]);
  }
}
