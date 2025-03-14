<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        DB::table('users')->insert([
            'name'          => 'Irawan Kilmer',
            'email'         => 'irawankillmer@gmail.com',
            'password'      => Hash::make('admin123'),
            'created_at'    => now(),
            'updated_at'    => now()
        ]);

        $accounts = [
            ['name' => 'BCA', 'descriptions' => 'Semua yang ada di rekening BCA'],
            ['name' => 'DANA', 'descriptions' => 'Semua yang ada di rekening DANA'],
            ['name' => 'Cash', 'descriptions' => 'Semua yang ada di Cash'],
        ];

        foreach ($accounts as $account) {
            DB::table('accounts')->insert([
                'name'          => $account['name'],
                'descriptions'  => $account['descriptions'],
                'created_at'    => now(),
                'updated_at'    => now()
            ]);
        }

        $categories = array(
            array(
                "name" => "Kebutuhan Rumah Tangga",
                "type" => "pengeluaran",
                "descriptions" => "Semua keperluan seperti baju, alat elektornik dan barang - barang lainnya"),
            array(
                "name" => "Dapur",
                "type" => "pengeluaran",
                "descriptions" => "Semua kebutuhan dapur termasuk alat - alatnya"),
            array(
                "name" => "Jajan Barudak",
                "type" => "pengeluaran",
                "descriptions" => "Semua jajan barudak termasuk ibunya, kecuali jajan disekolah sekolah(Bekel sakola tidak termasuk)"),
            array(
                "name" => "Transfortasi",
                "type" => "pengeluaran",
                "descriptions" => "Bensin dan biaya bepergian lainnya"),
            array(
                "name" => "Tagihan Bulanan",
                "type" => "pengeluaran",
                "descriptions" => "Listrik, pulsa dan tagihan yang bersipat bulanan lainnya"),
            array(
                "name" => "Istri",
                "type" => "pengeluaran",
                "descriptions" => "Semua pengeluaran istri, jajan dan lain sebagainya"),
            array(
                "name" => "Suami",
                "type" => "pengeluaran",
                "descriptions" => "Semua pengeluaran termasuk rokok, kopi, makan diluarketika kerja dan pengeluaran - pengeluaran lainnya"),
            array(
                "name" => "Gaji",
                "type" => "pemasukan",
                "descriptions" => "Pemasukan rutin yang tiap bulan atau gaji tetap"),
            array(
                "name" => "Luar Gaji",
                "type" => "pemasukan",
                "descriptions" => "Pendapatan diluar gaji apapun itu"),
            array(
                "name" => "Pendidikan",
                "type" => "pengeluaran",
                "descriptions" => "Biaya pendidikan anak - anak, termasuk pembayaran sekolah, uang jajan dan lain sebagainya"),
            array(
                "name" => "Pindah",
                "type" => "pindah",
                "descriptions" => "Perpindahan uang dari cash ke debit atau sebaliknya"),
            array(
                "name" => "Lainnya",
                "type" => "pengeluaran",
                "descriptions" => "Segala pengeluaran yang tidak terduga")
        );

        foreach ($categories as $category) {
            DB::table('categories')->insert([
                'name'          => $category['name'],
                'type'          => $category['type'],
                'descriptions'  => $category['descriptions'],
                'created_at'    => now(),
                'updated_at'    => now()
            ]);
        }
    }
}
