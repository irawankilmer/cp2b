<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    protected $fillable = [
        'date',
        'type',
        'account_id',
        'category_id',
        'target_account_id',
        'amount',
        'descriptions',
        'user_id',
        'balance_after'
    ];

    // Relasi ke akun asal
    public function account() {
        return $this->belongsTo(Account::class);
    }

    // Relasi ke akun tujuan (untuk perpindahan saldo)
    public function targetAccount() {
        return $this->belongsTo(Account::class, 'target_account_id');
    }

    // Relasi ke kategori
    public function category() {
        return $this->belongsTo(Category::class);
    }

    // Relasi ke pengguna
    public function user() {
        return $this->belongsTo(User::class);
    }

    protected $casts = [
        'date' => 'date'
    ];
}
