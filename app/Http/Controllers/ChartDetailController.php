<?php

namespace App\Http\Controllers;

use App\Models\Transaction;
use App\Models\Category;
use App\Models\Account;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;

class ChartDetailController extends Controller
{
  public function show($type, $id)
  {
    if ($type === 'category') {
      $model = Category::findOrFail($id);
      $transactions = Transaction::where('category_id', $id)
        ->orderBy('date', 'asc')
        ->get();
    } elseif ($type === 'account') {
      $model = Account::findOrFail($id);
      $transactions = Transaction::where('account_id', $id)
        ->orderBy('date', 'asc')
        ->get();
    } else {
      abort(404);
    }

    // Hitung total pemasukan & pengeluaran
    $totalIncome = $transactions->where('type', 'pemasukan')->sum('amount');
    $totalExpense = $transactions->where('type', 'pengeluaran')->sum('amount');

    // 🔹 Siapkan data line chart
    // Dikelompokkan berdasarkan tanggal
    $grouped = $transactions->groupBy(function ($trx) {
      return $trx->date->format('Y-m-d');
    });

    $labels = [];
    $dataIncome = [];
    $dataExpense = [];

    foreach ($grouped as $date => $trxList) {
      $labels[] = Carbon::parse($date)->format('d M');
      $dataIncome[] = (float) $trxList->where('type', 'pemasukan')->sum('amount');
      $dataExpense[] = (float) $trxList->where('type', 'pengeluaran')->sum('amount');
    }

    $chartData = [
      'labels' => $labels,
      'income' => $dataIncome,
      'expense' => $dataExpense,
    ];

    return view('chartdetail.show', [
      'name' => $model->name,
      'type' => $type,
      'transactions' => $transactions,
      'totalIncome' => $totalIncome,
      'totalExpense' => $totalExpense,
      'chartData' => $chartData,
    ]);
  }
}
