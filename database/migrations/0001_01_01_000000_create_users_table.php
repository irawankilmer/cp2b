<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Carbon\Carbon;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $userId = DB::table('users')->insertGetId([
            'name'       => 'Irawan Kilmer',
            'email'      => 'irawankillmer@gmail.com',
            'password'   => Hash::make('admin123'),
            'created_at' => now(),
            'updated_at' => now()
        ]);

        $accounts = [
            ['name' => 'BCA', 'descriptions' => 'Semua yang ada di rekening BCA'],
            ['name' => 'DANA', 'descriptions' => 'Semua yang ada di rekening DANA'],
            ['name' => 'Cash', 'descriptions' => 'Semua yang ada di Cash'],
        ];

        $accountIds = [];
        foreach ($accounts as $account) {
            $accountIds[] = DB::table('accounts')->insertGetId([
                'name'          => $account['name'],
                'descriptions'  => $account['descriptions'],
                'created_at'    => now(),
                'updated_at'    => now()
            ]);
        }

        $categories = [
            ["name" => "Kebutuhan Rumah Tangga", "type" => "pengeluaran", "descriptions" => "Baju, alat elektronik, barang lainnya"],
            ["name" => "Dapur", "type" => "pengeluaran", "descriptions" => "Kebutuhan dapur dan alat-alatnya"],
            ["name" => "Jajan Barudak", "type" => "pengeluaran", "descriptions" => "Jajan anak-anak dan ibunya"],
            ["name" => "Transportasi", "type" => "pengeluaran", "descriptions" => "Bensin dan biaya bepergian"],
            ["name" => "Tagihan Bulanan", "type" => "pengeluaran", "descriptions" => "Listrik, pulsa, dan langganan"],
            ["name" => "Istri", "type" => "pengeluaran", "descriptions" => "Pengeluaran istri seperti jajan, skincare, dll"],
            ["name" => "Suami", "type" => "pengeluaran", "descriptions" => "Pengeluaran suami seperti rokok, kopi, makan kerja"],
            ["name" => "Gaji", "type" => "pemasukan", "descriptions" => "Pemasukan rutin bulanan"],
            ["name" => "Luar Gaji", "type" => "pemasukan", "descriptions" => "Pendapatan di luar gaji tetap"],
            ["name" => "Pendidikan", "type" => "pengeluaran", "descriptions" => "Biaya sekolah anak, buku, dan les"],
            ["name" => "Pindah", "type" => "pindah", "descriptions" => "Perpindahan uang antar akun"],
            ["name" => "Lainnya", "type" => "pengeluaran", "descriptions" => "Pengeluaran tidak terduga"],
        ];

        $categoryIds = [];
        foreach ($categories as $category) {
            $categoryIds[$category['type']][] = DB::table('categories')->insertGetId([
                'name'          => $category['name'],
                'type'          => $category['type'],
                'descriptions'  => $category['descriptions'],
                'created_at'    => now(),
                'updated_at'    => now()
            ]);
        }

        foreach ($accountIds as $accId) {
            DB::table('balances')->insert([
                'account_id' => $accId,
                'balance' => 0,
                'created_at' => now(),
                'updated_at' => now()
            ]);
        }

        $faker = \Faker\Factory::create('id_ID');
        $transactions = [];

        for ($i = 0; $i < 100; $i++) {
            $typeChance = rand(1, 100);

            if ($typeChance <= 50) {
                $type = 'pengeluaran';
                $catId = $faker->randomElement($categoryIds['pengeluaran']);
                $amount = $faker->numberBetween(20000, 500000);
            } elseif ($typeChance <= 85) {
                $type = 'pemasukan';
                $catId = $faker->randomElement($categoryIds['pemasukan']);
                $amount = $faker->numberBetween(300000, 2000000);
            } else {
                $type = 'pindah';
                $catId = $faker->randomElement($categoryIds['pindah']);
                $amount = $faker->numberBetween(50000, 500000);
            }

            $account = $faker->randomElement($accountIds);
            $target = ($type == 'pindah')
                ? $faker->randomElement(array_diff($accountIds, [$account]))
                : null;

            $transactions[] = [
                'date'           => Carbon::now()->subDays(rand(0, 90)),
                'type'           => $type,
                'account_id'     => $account,
                'category_id'    => $catId,
                'target_account_id' => $target,
                'amount'         => $amount,
                'descriptions'   => $faker->sentence(),
                'user_id'        => $userId,
                'balance_after'  => $amount,
                'created_at'     => now(),
                'updated_at'     => now()
            ];
        }

        DB::table('transactions')->insert($transactions);

        foreach ($accountIds as $accId) {
            $totalIncome = DB::table('transactions')->where('account_id', $accId)->where('type', 'pemasukan')->sum('amount');
            $totalExpense = DB::table('transactions')->where('account_id', $accId)->where('type', 'pengeluaran')->sum('amount');
            $totalMoveIn = DB::table('transactions')->where('target_account_id', $accId)->where('type', 'pindah')->sum('amount');
            $totalMoveOut = DB::table('transactions')->where('account_id', $accId)->where('type', 'pindah')->sum('amount');

            $balance = $totalIncome + $totalMoveIn - $totalExpense - $totalMoveOut;

            DB::table('balances')->where('account_id', $accId)->update([
                'balance' => $balance,
                'updated_at' => now()
            ]);
        }
    }
}
