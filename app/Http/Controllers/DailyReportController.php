<?php

namespace App\Http\Controllers;

use App\Models\Transaction;
use App\Models\Category;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\View\View;

class DailyReportController extends Controller
{
    public function sekarang(): View
    {
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

        $chartDataPemasukan = [
            'labels' => $transactions->pluck('day')->map(fn($date) => Carbon::parse($date)->format('d M'))->toArray(),
            'income' => $transactions->pluck('total_income')->toArray()
        ];

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

        $incomeData = Transaction::whereDate('date', $date)
            ->where('type', 'pemasukan')
            ->selectRaw('HOUR(created_at) as hour, SUM(amount) as total')
            ->groupBy('hour')
            ->orderBy('hour', 'asc')
            ->get();

        $expenseData = Transaction::whereDate('date', $date)
            ->where('type', 'pengeluaran')
            ->selectRaw('HOUR(created_at) as hour, SUM(amount) as total')
            ->groupBy('hour')
            ->orderBy('hour', 'asc')
            ->get();

        $totalIncome = $incomeData->sum('total');
        $totalExpense = $expenseData->sum('total');

        $incomeChart = [
            'labels' => $incomeData->pluck('hour')->map(fn($h) => $h . ':00')->toArray(),
            'data' => $incomeData->pluck('total')->toArray()
        ];

        $expenseChart = [
            'labels' => $expenseData->pluck('hour')->map(fn($h) => $h . ':00')->toArray(),
            'data' => $expenseData->pluck('total')->toArray()
        ];


        return view('bulansekarang.detail', [
            'transactions'  => $transactions,
            'hari'          => Carbon::parse($date)->translatedFormat('l, d F Y'),
            'chartpiedatapemasukan' => $chartPieDataPemasukan,
            'chartpiedatapengeluaran' => $chartPieDataPengeluaran,
            'incomeChart'   => $incomeChart,
            'expenseChart'  => $expenseChart,
            'totalIncome'   => $totalIncome,
            'totalExpense'  => $totalExpense,
        ]);
    }

    public function kategoriBulan(Request $request, $kategori)
    {
        $type = $request->query('type', null);

        if ($type === 'expense') $type = 'pengeluaran';
        elseif ($type === 'income') $type = 'pemasukan';
        elseif ($type === 'transfer') $type = 'pindah';

        $currentMonth = Carbon::now()->month;
        $currentYear = Carbon::now()->year;

        $transactions = Transaction::with(['account', 'category', 'user'])
            ->whereMonth('date', $currentMonth)
            ->whereYear('date', $currentYear)
            ->whereHas('category', function ($q) use ($kategori) {
                $q->whereRaw('LOWER(name) = ?', [strtolower($kategori)]);
            })
            ->when($type, fn($q) => $q->where('type', $type))
            ->orderBy('date', 'asc')
            ->orderBy('created_at', 'asc')
            ->get();

        $total = $transactions->sum('amount');

        return view('bulansekarang.kategori', [
            'kategori' => $kategori,
            'transactions' => $transactions,
            'type' => $type,
            'total' => $total,
            'month' => Carbon::now()->translatedFormat('F Y'),
            'context' => 'bulanan',
        ]);
    }

    public function kategoriHarian(Request $request, $date, $kategori)
    {
        $type = $request->query('type', null);

        $kategoriExist = Category::pluck('name')->map(fn($n) => strtolower($n));
        if (!$kategoriExist->contains(strtolower($kategori))) {
            dd([
                'debug' => 'Kategori tidak ditemukan',
                'url_kategori' => $kategori,
                'kategori_yang_ada' => $kategoriExist,
            ]);
        }

        $query = Transaction::with(['account', 'category', 'user'])
            ->whereDate('date', $date)
            ->whereHas('category', fn($q) => $q->where('name', $kategori));

        if ($type) {
            $query->where('type', $type);
        }

        $transactions = $query->orderBy('created_at', 'asc')->get();
        $total = $transactions->sum('amount');

        return view('bulansekarang.kategori', [
            'kategori' => $kategori,
            'transactions' => $transactions,
            'type' => $type,
            'total' => $total,
            'date' => $date,
            'context' => 'harian',
        ]);
    }


    public function yearlyReport(): View
    {
        $year = Carbon::now()->year;

        $months = [
            1 => 'Januari', 2 => 'Februari', 3 => 'Maret', 4 => 'April',
            5 => 'Mei', 6 => 'Juni', 7 => 'Juli', 8 => 'Agustus',
            9 => 'September', 10 => 'Oktober', 11 => 'November', 12 => 'Desember'
        ];
        
        $transactions = Transaction::whereYear('date', $year)
            ->selectRaw('
                MONTH(date) as month,
                SUM(CASE WHEN type = "pemasukan" THEN amount ELSE 0 END) as total_income,
                SUM(CASE WHEN type = "pengeluaran" THEN amount ELSE 0 END) as total_expense
            ')
            ->groupBy('month')
            ->orderBy('month')
            ->get()
            ->keyBy('month');
        
        $report = [];
        
        foreach ($months as $monthNumber => $monthName) {
            $transaction = $transactions[$monthNumber] ?? (object) ['total_income' => 0, 'total_expense' => 0];
        
            $report[] = [
                'month' => $monthName . ' ' . $year,
                'income' => $transaction->total_income,
                'expense' => $transaction->total_expense,
                'net_balance' => $transaction->total_income - $transaction->total_expense
            ];
        }

        $months = range(1, 12);

        $transactionsGrafic = Transaction::whereYear('date', $year)
            ->selectRaw('
                            MONTH(date) as month,
                            SUM(CASE WHEN type = "pemasukan" THEN amount ELSE 0 END) as total_income,
                            SUM(CASE WHEN type = "pengeluaran" THEN amount ELSE 0 END) as total_expense
                        ')
            ->groupBy('month')
            ->orderBy('month')
            ->get()
            ->keyBy('month');

        $incomeData = [];
        $expenseData = [];

        foreach ($months as $month) {
            $incomeData[] = $transactionsGrafic[$month]->total_income ?? 0;
            $expenseData[] = $transactionsGrafic[$month]->total_expense ?? 0;
        }

        $incomeCategories = Transaction::whereYear('transactions.date', $year)
            ->where('transactions.type', 'pemasukan')
            ->join('categories', 'transactions.category_id', '=', 'categories.id')
            ->selectRaw('categories.name as category, SUM(transactions.amount) as total')
            ->groupBy('categories.name')
            ->get();

        $expenseCategories = Transaction::whereYear('transactions.date', $year)
            ->where('transactions.type', 'pengeluaran')
            ->join('categories', 'transactions.category_id', '=', 'categories.id')
            ->selectRaw('categories.name as category, SUM(transactions.amount) as total')
            ->groupBy('categories.name')
            ->get();

        $totals = Transaction::whereYear('date', $year)
            ->selectRaw('
                        SUM(CASE WHEN type = "pemasukan" THEN amount ELSE 0 END) as total_income,
                        SUM(CASE WHEN type = "pengeluaran" THEN amount ELSE 0 END) as total_expense
                    ')
            ->first();

        $totalIncome = $totals->total_income ?? 0;
        $totalExpense = $totals->total_expense ?? 0;

        return view('tahunsekarang.index', compact(
            'report',
            'year',
            'incomeData',
            'expenseData',
            'incomeCategories',
            'expenseCategories',
            'totalIncome',
            'totalExpense'
        ));
    }

    public function yearlyReportDetail($month, $year): View
    {
        $currentMonth = $month;
        $currentYear = $year;

        $bulan = Carbon::create($currentYear, $currentMonth, 1)->translatedFormat('F Y');

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

        return view('tahunsekarang.detail', compact(
            'bulan',
            'formattedReports',
            'chartDataPemasukan',
            'chartDataPengeluaran',
            'chartDataRincianPemasukan',
            'chartDataRincianPengeluaran',
            'totalIncome',
            'totalExpense',
        ));
    }

    public function yearlySummary(): View
    {
        $transactions = Transaction::selectRaw('
                YEAR(date) as year,
                SUM(CASE WHEN type = "pemasukan" THEN amount ELSE 0 END) as total_income,
                SUM(CASE WHEN type = "pengeluaran" THEN amount ELSE 0 END) as total_expense
            ')
            ->groupBy('year')
            ->orderByDesc('year')
            ->get();

        $report = [];

        foreach ($transactions as $transaction) {
            $report[] = [
                'year' => $transaction->year,
                'income' => $transaction->total_income,
                'expense' => $transaction->total_expense,
                'net_balance' => $transaction->total_income - $transaction->total_expense
            ];
        }

        return view('tahunan.index', compact('report'));
    }

    public function yearlySummaryDetail($year): View
    {
        $months = [
            1 => 'Januari', 2 => 'Februari', 3 => 'Maret', 4 => 'April',
            5 => 'Mei', 6 => 'Juni', 7 => 'Juli', 8 => 'Agustus',
            9 => 'September', 10 => 'Oktober', 11 => 'November', 12 => 'Desember'
        ];
        
        $transactions = Transaction::whereYear('date', $year)
            ->selectRaw('
                MONTH(date) as month,
                SUM(CASE WHEN type = "pemasukan" THEN amount ELSE 0 END) as total_income,
                SUM(CASE WHEN type = "pengeluaran" THEN amount ELSE 0 END) as total_expense
            ')
            ->groupBy('month')
            ->orderBy('month')
            ->get()
            ->keyBy('month');
        
        $report = [];
        
        foreach ($months as $monthNumber => $monthName) {
            $transaction = $transactions[$monthNumber] ?? (object) ['total_income' => 0, 'total_expense' => 0];
        
            $report[] = [
                'month' => $monthName . ' ' . $year,
                'income' => $transaction->total_income,
                'expense' => $transaction->total_expense,
                'net_balance' => $transaction->total_income - $transaction->total_expense
            ];
        }

        $months = range(1, 12);

        $transactionsGrafic = Transaction::whereYear('date', $year)
            ->selectRaw('
                            MONTH(date) as month,
                            SUM(CASE WHEN type = "pemasukan" THEN amount ELSE 0 END) as total_income,
                            SUM(CASE WHEN type = "pengeluaran" THEN amount ELSE 0 END) as total_expense
                        ')
            ->groupBy('month')
            ->orderBy('month')
            ->get()
            ->keyBy('month');

        $incomeData = [];
        $expenseData = [];

        foreach ($months as $month) {
            $incomeData[] = $transactionsGrafic[$month]->total_income ?? 0;
            $expenseData[] = $transactionsGrafic[$month]->total_expense ?? 0;
        }

        $incomeCategories = Transaction::whereYear('transactions.date', $year)
            ->where('transactions.type', 'pemasukan')
            ->join('categories', 'transactions.category_id', '=', 'categories.id')
            ->selectRaw('categories.name as category, SUM(transactions.amount) as total')
            ->groupBy('categories.name')
            ->get();

        $expenseCategories = Transaction::whereYear('transactions.date', $year)
            ->where('transactions.type', 'pengeluaran')
            ->join('categories', 'transactions.category_id', '=', 'categories.id')
            ->selectRaw('categories.name as category, SUM(transactions.amount) as total')
            ->groupBy('categories.name')
            ->get();

        $totals = Transaction::whereYear('date', $year)
            ->selectRaw('
                        SUM(CASE WHEN type = "pemasukan" THEN amount ELSE 0 END) as total_income,
                        SUM(CASE WHEN type = "pengeluaran" THEN amount ELSE 0 END) as total_expense
                    ')
            ->first();

        $totalIncome = $totals->total_income ?? 0;
        $totalExpense = $totals->total_expense ?? 0;

        return view('tahunsekarang.index', compact(
            'report',
            'year',
            'incomeData',
            'expenseData',
            'incomeCategories',
            'expenseCategories',
            'totalIncome',
            'totalExpense'
        ));
    }
}
