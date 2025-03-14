@extends('layout')

@section('title', 'Dashboard')

@section('breadcumb')
    <!--begin::Row-->
    <div class="row">
        <div class="col-sm-6"><h3 class="mb-0">Collapsed Sidebar</h3></div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-end">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Collapsed Sidebar</li>
            </ol>
        </div>
    </div>
    <!--end::Row-->
@endsection

@section('content')
    <!--begin::Row-->
    <div class="row">
        <div class="col-4">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Grafik Saldo per Akun</h3>
                </div>
                <div class="card-body">
                    <canvas id="balanceChart"></canvas>
                    <p class="mt-3">Total Saldo: <strong>Rp {{ number_format($totalBalance, 2, ',', '.') }}</strong></p>
                </div>
            </div>
        </div>

        <div class="col-4">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Grafik Rincian Pengeluaran</h3>
                </div>
                <div class="card-body">
                    <canvas id="expenseChart"></canvas>
                </div>
            </div>
        </div>
    </div>
    <!--end::Row-->
@endsection

@push('scripts')
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        const chartData = JSON.parse('{!! $chartData !!}');

        const ctx = document.getElementById('balanceChart').getContext('2d');
        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: chartData.labels,
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
                responsive: true
            }
        });
    </script>

    <script>
        const expenseData = JSON.parse('{!! $chartExpenseData !!}');

        const ctxExpense = document.getElementById('expenseChart').getContext('2d');
        new Chart(ctxExpense, {
            type: 'doughnut',
            data: {
                labels: expenseData.labels,
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
                responsive: true
            }
        });
    </script>
@endpush