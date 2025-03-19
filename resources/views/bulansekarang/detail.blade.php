@extends('../layout')
@section('title', 'Laporan Bulan Sekarang')

@section('breadcumb')
    <div class="row">
        <div class="col-sm-6"><h3 class="mb-0">Detail</h3></div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-end">
                <li class="breadcrumb-item"><a href="{{ route('bulansekarang') }}">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Detail</li>
            </ol>
        </div>
    </div>
@endsection

@section('content')
    <div class="row">
        <div class="col-12">
            <!-- Default box -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3 class="card-title">Laporan Hari Ini: {{ $hari }}</h3>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="transactions-table" class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>No</th>
                                <th>Jam</th>
                                <th>Jenis</th>
                                <th>Akun</th>
                                <th>Kategori</th>
                                <th>Jumlah</th>
                                <th>Deskripsi</th>
                            </tr>
                            </thead>
                            <tbody>
                            @foreach($transactions as $transaction)
                                <tr>
                                    <td>{{ $loop->iteration }}</td>
                                    <td>{{ $transaction->created_at->format('H:i') . ' WIB' }}</td>
                                    <td>{{ $transaction->type }}</td>
                                    <td>{{ $transaction->account->name }}</td>
                                    <td>{{ $transaction->category->name }}</td>
                                    <td>{{ 'Rp ' . number_format($transaction->amount, 2, ',', '.') }}</td>
                                    <td>{{ $transaction->descriptions }}</td>
                                </tr>
                            @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- /.card -->
        </div>
    </div>

    <div class="row mt-3">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Total Pemasukan: Rp {{ number_format($totalIncome, 2, ',', '.') }}</h3>
                </div>
                <div class="card-body">
                    <canvas id="incomeChart"></canvas>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Total Pengeluaran: Rp {{ number_format($totalExpense, 2, ',', '.') }}</h3>
                </div>
                <div class="card-body">
                    <canvas id="expenseChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-3">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <canvas id="incomePieChart"></canvas>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <canvas id="expensePieChart"></canvas>
                </div>
            </div>
        </div>
    </div>

@endsection

@push('styles')
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
@endpush

@push('scripts')
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#transactions-table').DataTable();
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        const incomePieData = JSON.parse('{!! $chartpiedatapemasukan !!}');
        const expensePieData = JSON.parse('{!! $chartpiedatapengeluaran !!}');

        const incomePieCtx = document.getElementById('incomePieChart').getContext('2d');
        new Chart(incomePieCtx, {
            type: 'pie',
            data: {
                labels: Object.keys(incomePieData),
                datasets: [{
                    data: Object.values(incomePieData),
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.5)',
                        'rgba(54, 162, 235, 0.5)',
                        'rgba(255, 206, 86, 0.5)',
                        'rgba(255, 99, 132, 0.5)'
                    ]
                }]
            }
        });

        const expensePieCtx = document.getElementById('expensePieChart').getContext('2d');
        new Chart(expensePieCtx, {
            type: 'pie',
            data: {
                labels: Object.keys(expensePieData),
                datasets: [{
                    data: Object.values(expensePieData),
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.5)',
                        'rgba(255, 159, 64, 0.5)',
                        'rgba(255, 205, 86, 0.5)',
                        'rgba(75, 192, 192, 0.5)'
                    ]
                }]
            }
        });
    </script>

    <script>
        const incomeChartData = JSON.parse('{!! json_encode($incomeChart) !!}');
        const expenseChartData = JSON.parse('{!! json_encode($expenseChart) !!}');

        const incomeCtx = document.getElementById('incomeChart').getContext('2d');
        new Chart(incomeCtx, {
            type: 'line',
            data: {
                labels: incomeChartData.labels,
                datasets: [{
                    label: 'Pemasukan',
                    data: incomeChartData.data,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 2,
                    fill: true,
                    tension: 0.3
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });

        const expenseCtx = document.getElementById('expenseChart').getContext('2d');
        new Chart(expenseCtx, {
            type: 'line',
            data: {
                labels: expenseChartData.labels,
                datasets: [{
                    label: 'Pengeluaran',
                    data: expenseChartData.data,
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 2,
                    fill: true,
                    tension: 0.3
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });
    </script>
@endpush