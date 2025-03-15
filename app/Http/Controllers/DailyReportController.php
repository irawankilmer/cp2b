<?php

namespace App\Http\Controllers;

use App\Models\Transaction;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\View\View;

class DailyReportController extends Controller
{
    public function sekarang(): View
    {
        // data tabel
        $currentMonth = Carbon::now()->month;
        $currentYear = Carbon::now()->year;

        $transactions = Transaction::whereMonth('date', $currentMonth)
            ->whereYear('date', $currentYear)
            ->selectRaw('DATE(date) as day, 
                     SUM(CASE WHEN type = "pemasukan" THEN amount ELSE 0 END) as total_income,
                     SUM(CASE WHEN type = "pengeluaran" THEN amount ELSE 0 END) as total_expense')
            ->groupBy('day')
            ->orderBy('day', 'asc')
            ->get();

        $totalIncome = $transactions->sum('total_income');
        $totalExpense = $transactions->sum('total_expense');

        $formattedReports = $transactions->map(function ($report) {
            return [
                'day' => Carbon::parse($report->day)->translatedFormat('l, d F Y'),
                'income' => $report->total_income,
                'expense' => $report->total_expense,
                'net_balance' => $report->total_income - $report->total_expense
            ];
        });

        // Data untuk grafik pemasukan
        $chartDataPemasukan = [
            'labels' => $transactions->pluck('day')->map(fn($date) => Carbon::parse($date)->format('d M'))->toArray(),
            'income' => $transactions->pluck('total_income')->toArray()
        ];

        // Data untuk grafik pengeluaran
        $chartDataPengeluaran = [
            'labels' => $transactions->pluck('day')->map(fn($date) => Carbon::parse($date)->format('d M'))->toArray(),
            'expense' => $transactions->pluck('total_expense')->toArray()
        ];

        $incomeData = Transaction::where('type', 'pemasukan')
            ->whereMonth('date', $currentMonth)
            ->whereYear('date', $currentYear)
            ->with('category')
            ->selectRaw('category_id, SUM(amount) as total')
            ->groupBy('category_id')
            ->get();

        $chartDataRincianPemasukan = [
            'labels' => $incomeData->pluck('category.name'),
            'data' => $incomeData->pluck('total')
        ];

        $expenseData = Transaction::where('type', 'pengeluaran')
            ->whereMonth('date', $currentMonth)
            ->whereYear('date', $currentYear)
            ->with('category')
            ->selectRaw('category_id, SUM(amount) as total')
            ->groupBy('category_id')
            ->get();

        $chartDataRincianPengeluaran = [
            'labels' => $expenseData->pluck('category.name'),
            'data' => $expenseData->pluck('total')
        ];

        return view('bulansekarang.index', [
            'month' => Carbon::now()->translatedFormat('F Y'),
            'formattedReports'  => $formattedReports,
            'chardatapemasukan' => $chartDataPemasukan,
            'chardatapengeluaran' => $chartDataPengeluaran,
            'chartdatarincianpemasukan' => $chartDataRincianPemasukan,
            'chartdatarincianpengeluaran' => $chartDataRincianPengeluaran,
            'totalincome'   => $totalIncome,
            'totalexpense' => $totalExpense,
        ]);
    }

    public function detail($date): View
    {
        $transactions = Transaction::with('account', 'category', 'user')
            ->whereDate('date', $date)
            ->orderByDesc('created_at')
            ->get();

        $piechartdata = Transaction::whereDate('date', $date)
            ->selectRaw('category_id, type, SUM(amount) as total_amount')
            ->groupBy('category_id', 'type')
            ->with('category')
            ->get();

        $chartPieDataPemasukan = $piechartdata->where('type', 'pemasukan')->pluck('total_amount', 'category.name');
        $chartPieDataPengeluaran = $piechartdata->where('type', 'pengeluaran')->pluck('total_amount', 'category.name');


        return view('bulansekarang.detail', [
            'transactions'  => $transactions,
            'hari'          => Carbon::parse($date)->translatedFormat('l, d F Y'),
            'chartpiedatapemasukan' => $chartPieDataPemasukan,
            'chartpiedatapengeluaran' => $chartPieDataPengeluaran
        ]);
    }

}
