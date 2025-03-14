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

        return view('dashboard', [
            'chartData' => json_encode($chartData),
            'totalBalance' => $chartData['total'],
            'chartExpenseData' => json_encode($chartExpenseData),
        ]);
    }
}
