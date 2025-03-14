<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class YearlyReport extends Model
{
    use HasFactory;

    protected $fillable = [
        'year',
        'total_income',
        'total_expense',
        'net_balance',
        'details'
    ];

    protected $casts = [
        'details' => 'array'
    ];
}
