<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->rememberToken();
            $table->timestamps();
        });

        Schema::create('password_reset_tokens', function (Blueprint $table) {
            $table->string('email')->primary();
            $table->string('token');
            $table->timestamp('created_at')->nullable();
        });

        Schema::create('sessions', function (Blueprint $table) {
            $table->string('id')->primary();
            $table->foreignId('user_id')->nullable()->index();
            $table->string('ip_address', 45)->nullable();
            $table->text('user_agent')->nullable();
            $table->longText('payload');
            $table->integer('last_activity')->index();
        });

        Schema::create('accounts', function (Blueprint $table) {
            $table->id();
            $table->string('name')->unique();
            $table->text('descriptions')->nullable();
            $table->timestamps();
        });

        Schema::create('categories', function (Blueprint $table) {
            $table->id();
            $table->string('name')->unique();
            $table->enum('type', ['pemasukan', 'pengeluaran', 'pindah'])->default('pengeluaran');
            $table->text('descriptions')->nullable();
            $table->timestamps();
        });

        Schema::create('transactions', function (Blueprint $table) {
            $table->id();
            $table->date('date');
            $table->enum('type', ['pemasukan', 'pengeluaran', 'pindah'])->default('pengeluaran');
            $table->foreignId('account_id')->constrained()->onDelete('cascade')->onUpdate('cascade');
            $table->foreignId('category_id')->constrained()->onDelete('cascade')->onUpdate('cascade');
            $table->foreignId('target_account_id')->nullable()->constrained('accounts')->onDelete('cascade')->onUpdate('cascade');
            $table->decimal('amount', 15, 2);
            $table->string('descriptions')->nullable();
            $table->foreignId('user_id')->constrained()->onDelete('cascade')->onUpdate('cascade');
            $table->decimal('balance_after', 15, 2);
            $table->timestamps();
        });

        Schema::create('balances', function (Blueprint $table) {
            $table->id();
            $table->foreignId('account_id')->constrained()->onDelete('cascade')->onUpdate('cascade');
            $table->decimal('balance', 15, 2);
            $table->timestamps();
        });

        Schema::create('daily_reports', function (Blueprint $table) {
            $table->id();
            $table->date('date');
            $table->decimal('total_income', 15, 2);
            $table->decimal('total_expense', 15, 2);
            $table->decimal('net_balance', 15, 2);
            $table->json('details');
            $table->timestamps();
        });

        Schema::create('monthly_reports', function (Blueprint $table) {
            $table->id();
            $table->string('month');
            $table->year('year');
            $table->decimal('total_income', 15, 2);
            $table->decimal('total_expense', 15, 2);
            $table->decimal('net_balance', 15, 2);
            $table->json('details');
            $table->timestamps();
        });

        Schema::create('yearly_reports', function (Blueprint $table) {
            $table->id();
            $table->year('year');
            $table->decimal('total_income', 15, 2);
            $table->decimal('total_expense', 15, 2);
            $table->decimal('net_balance', 15, 2);
            $table->json('details');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
        Schema::dropIfExists('password_reset_tokens');
        Schema::dropIfExists('sessions');
        Schema::dropIfExists('accounts');
        Schema::dropIfExists('categories');
        Schema::dropIfExists('transactions');
        Schema::dropIfExists('balances');
        Schema::dropIfExists('yearly_reports');
        Schema::dropIfExists('monthly_reports');
        Schema::dropIfExists('daily_reports');
    }
};
