<?php

use App\Http\Controllers\DailyReportController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\TransactionController;
use Illuminate\Support\Facades\Route;

Route::controller(LoginController::class)->group( function() {
    Route::get('/login', 'index')->name('login');
    Route::post('/login', 'login')->name('login.login');
    Route::post('/logout', 'logout')->name('logout');
});

Route::middleware(['auth'])->group(function () {
    Route::get('/', [DashboardController::class, 'index'])->name('dashboard');

    Route::controller(TransactionController::class)->group( function() {
        Route::get('/transaksi', 'index')->name('transaksi');
        Route::get('/transaksi/create', 'create')->name('transaksi.create');
        Route::post('/transaksi', 'store')->name('transaksi.store');

        Route::get('/transaksi/import', 'import')->name('transaksi.import');
        Route::post('/transaksi/import', 'importstore')->name('transaksi.importStore');
    });

    Route::controller(DailyReportController::class)->group( function() {
        Route::get('/bulansekarang', 'sekarang')->name('bulansekarang');
        Route::get('/bulansekarang/{date}', 'detail')->name('bulansekarang.detail');

        Route::get('/tahunsekarang', 'yearlyReport')->name('tahunsekarang');
        Route::get('/tahunsekarang/{month}/{year}', 'yearlyReportDetail')->name('tahunsekarang.detail');
    });
});