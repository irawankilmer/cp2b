<?php

use App\Http\Controllers\AccountController;
use App\Http\Controllers\CategoryController;
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
        Route::get('/transaksi/{id}/edit', 'edit')->name('transaksi.edit');
        Route::patch('/transaksi/{id}', 'update')->name('transaksi.update');
        Route::delete('/transaksi/{id}', 'destroy')->name('transaksi.destroy');

        Route::get('/transaksi/import', 'import')->name('transaksi.import');
        Route::post('/transaksi/import', 'importstore')->name('transaksi.importStore');
    });

    Route::controller(DailyReportController::class)->group( function() {
        Route::get('/bulansekarang', 'sekarang')->name('bulansekarang');
        Route::get('/bulansekarang/{date}', 'detail')->name('bulansekarang.detail');

        Route::get('/tahunsekarang', 'yearlyReport')->name('tahunsekarang');
        Route::get('/tahunsekarang/{month}/{year}', 'yearlyReportDetail')->name('tahunsekarang.detail');

        Route::get('/tahunan', 'yearlySummary')->name('tahunan');
        Route::get('/tahunan/{year}', 'yearlySummaryDetail')->name('tahunan.detail');
    });

    Route::controller(AccountController::class)->group( function() {
        Route::get('/account', 'index')->name('account');
        Route::get('/account/create', 'create')->name('account.create');
        Route::post('/account', 'store')->name('account.store');
        Route::get('/account/{id}/edit', 'edit')->name('account.edit');
        Route::patch('/account/{id}', 'update')->name('account.update');
        Route::delete('/account/{id}', 'destroy')->name('account.destroy');
    });

    Route::controller(CategoryController::class)->group( function() {
      Route::get('/category', 'index')->name('category');
      Route::get('/category/create', 'create')->name('category.create');
      Route::post('/category', 'store')->name('category.store');
      Route::get('/category/{id}/edit', 'edit')->name('category.edit');
      Route::patch('/category/{id}', 'update')->name('category.update');
      Route::delete('/category/{id}', 'destroy')->name('category.destroy');
    });
});