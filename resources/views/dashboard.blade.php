@extends('layout')

@section('title', 'Dashboard')

@section('breadcumb')
    <div class="row">
        <div class="col-sm-6"><h3 class="mb-0">Dashboard</h3></div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-end">
                <li class="breadcrumb-item"><a href="{{ route('dashboard') }}">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
            </ol>
        </div>
    </div>
@endsection

@section('content')
    <div class="row">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Data All Time</h3>
            </div>
            <div class="card-body">
                <div class="row text-center">
                    <div class="col-md-4">
                        <p class="my-3">Total Saldo: <strong>Rp {{ number_format($totalBalance, 2, ',', '.') }}</strong></p>
                        <canvas id="balanceChart"></canvas>
                    </div>
                    <div class="col-md-4">
                        <p class="my-3">
                            Total Pemasukan: <strong>Rp {{ number_format($totalIncome, 2, ',', '.') }}</strong>
                        </p>
                        <canvas id="incomeChart"></canvas>
                    </div>
                    <div class="col-md-4">
                        <p class="my-3">
                            Total Pengeluaran: <strong>Rp {{ number_format($totalExpense, 2, ',', '.') }}</strong>
                        </p>
                        <canvas id="expenseChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('scripts')
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    {{-- =======================
         1️⃣ CHART SALDO (ACCOUNT)
    ======================== --}}
    <script>
        const chartData = @json($chartData);

        const ctx = document.getElementById('balanceChart').getContext('2d');
        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: chartData.labels,
                ids: chartData.ids, // <— agar klik tahu ID akun
                datasets: [{
                    data: chartData.data,
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(153, 102, 255, 0.2)'
                    ],
                    borderColor: [
                        'rgba(75, 192, 192, 1)',
                        'rgba(255, 99, 132, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(153, 102, 255, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                onClick: function (evt, activeEls) {
                    if (activeEls.length > 0) {
                        const index = activeEls[0].index;
                        const id = this.data.ids[index];
                        const label = this.data.labels[index];
                        if (id) {
                            window.location.href = "{{ url('chart-detail') }}/account/" + id + "?scope=all";
                        } else {
                            Swal.fire('Informasi', `Akun: ${label}`, 'info');
                        }
                    }
                }
            }
        });
    </script>

    {{-- =======================
         2️⃣ CHART PEMASUKAN (INCOME)
    ======================== --}}
    <script>
        const incomeData = @json($chartIncomeData);

        const ctxIncome = document.getElementById('incomeChart').getContext('2d');
        new Chart(ctxIncome, {
            type: 'doughnut',
            data: {
                labels: incomeData.labels,
                ids: incomeData.ids, // <— agar klik tahu ID kategori pemasukan
                datasets: [{
                    data: incomeData.data,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(255, 159, 64, 0.2)',
                        'rgba(255, 205, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(201, 203, 207, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(255, 159, 64, 1)',
                        'rgba(255, 205, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(201, 203, 207, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                onClick: function (evt, activeEls) {
                    if (activeEls.length > 0) {
                        const index = activeEls[0].index;
                        const id = this.data.ids[index];
                        const label = this.data.labels[index];
                        if (id) {
                            window.location.href = "{{ url('chart-detail') }}/category/" + id + "?scope=all";
                        } else {
                            Swal.fire('Informasi', `Kategori: ${label}`, 'info');
                        }
                    }
                }
            }
        });
    </script>

    {{-- =======================
         3️⃣ CHART PENGELUARAN (EXPENSE)
    ======================== --}}
    <script>
        const expenseData = @json($chartExpenseData);

        const ctxExpense = document.getElementById('expenseChart').getContext('2d');
        new Chart(ctxExpense, {
            type: 'doughnut',
            data: {
                labels: expenseData.labels,
                ids: expenseData.ids, // <— agar klik tahu ID kategori pengeluaran
                datasets: [{
                    data: expenseData.data,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(255, 159, 64, 0.2)',
                        'rgba(255, 205, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(201, 203, 207, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(255, 159, 64, 1)',
                        'rgba(255, 205, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(201, 203, 207, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                onClick: function (evt, activeEls) {
                    if (activeEls.length > 0) {
                        const index = activeEls[0].index;
                        const id = this.data.ids[index];
                        const label = this.data.labels[index];
                        if (id) {
                            window.location.href = "{{ url('chart-detail') }}/category/" + id + "?scope=all";
                        } else {
                            Swal.fire('Informasi', `Kategori: ${label}`, 'info');
                        }
                    }
                }
            }
        });
    </script>
@endpush
