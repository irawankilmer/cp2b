<?php

namespace App\Observers;

use App\Models\Transaction;
use App\Models\DailyReport;
use App\Models\MonthlyReport;
use App\Models\YearlyReport;
use Illuminate\Support\Facades\DB;

class TransactionObserver
{
    public function created(Transaction $transaction)
    {
        $this->updateReports($transaction);
    }

    public function updated(Transaction $transaction)
    {
        $this->updateReports($transaction);
    }

    public function deleted(Transaction $transaction)
    {
        $this->updateReports($transaction);
    }

    private function updateReports($transaction)
    {
        // Update Daily Report
        $daily = Transaction::whereDate('date', $transaction->date)
            ->selectRaw('
                SUM(CASE WHEN type = 1 THEN amount ELSE 0 END) as total_income,
                SUM(CASE WHEN type = 2 THEN amount ELSE 0 END) as total_expense
            ')
            ->first();

        DailyReport::updateOrCreate(
            ['date' => $transaction->date],
            [
                'total_income' => $daily->total_income,
                'total_expense' => $daily->total_expense,
                'net_balance' => $daily->total_income - $daily->total_expense,
                'details' => json_encode(Transaction::whereDate('date', $transaction->date)->get())
            ]
        );

        // Update Monthly Report
        $monthly = Transaction::whereMonth('date', $transaction->date)
            ->whereYear('date', $transaction->date)
            ->selectRaw('
                SUM(CASE WHEN type = 1 THEN amount ELSE 0 END) as total_income,
                SUM(CASE WHEN type = 2 THEN amount ELSE 0 END) as total_expense
            ')
            ->first();

        MonthlyReport::updateOrCreate(
            [
                'month' => $transaction->date->format('m'),
                'year' => $transaction->date->format('Y')
            ],
            [
                'total_income' => $monthly->total_income,
                'total_expense' => $monthly->total_expense,
                'net_balance' => $monthly->total_income - $monthly->total_expense,
                'details' => json_encode(Transaction::whereMonth('date', $transaction->date)->whereYear('date', $transaction->date)->get())
            ]
        );

        // Update Yearly Report
        $yearly = Transaction::whereYear('date', $transaction->date)
            ->selectRaw('
                SUM(CASE WHEN type = 1 THEN amount ELSE 0 END) as total_income,
                SUM(CASE WHEN type = 2 THEN amount ELSE 0 END) as total_expense
            ')
            ->first();

        YearlyReport::updateOrCreate(
            ['year' => $transaction->date->format('Y')],
            [
                'total_income' => $yearly->total_income,
                'total_expense' => $yearly->total_expense,
                'net_balance' => $yearly->total_income - $yearly->total_expense,
                'details' => json_encode(Transaction::whereYear('date', $transaction->date)->get())
            ]
        );
    }
}
