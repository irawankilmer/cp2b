<?php

namespace App\Imports;

use App\Models\Balance;
use App\Models\Transaction;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class TransactionImport implements ToModel, WithHeadingRow
{
    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */
    public function model(array $row)
    {
        $balance = Balance::firstOrCreate(
            ['account_id' => $row['account_id']],
            ['balance' => 0]
        );

        $newBalance = match ($row['type']) {
            1 => $balance->balance + $row['amount'], // Pemasukan
            2 => $balance->balance - $row['amount'], // Pengeluaran
            3 => $balance->balance - $row['amount'] // Pindah saldo (tambahkan logika untuk akun tujuan)
        };

        $balance->update(['balance' => $newBalance]);

        return new Transaction([
            'date' => $row['date'],
            'type' => $row['type'],
            'account_id' => (int)$row['account_id'],
            'category_id' => (int)$row['category_id'],
            'amount' => $row['amount'],
            'descriptions' => $row['descriptions'],
            'user_id' => auth()->id(),
            'balance_after' => $newBalance
        ]);
    }
}
