@extends('../layout')
@section('title', 'Laporan Tahun Sekarang')

@section('breadcumb')
    <div class="row">
        <div class="col-sm-6"><h3 class="mb-0">Detail bulan {{ $bulan }}</h3></div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-end">
                <li class="breadcrumb-item"><a href="{{ route('tahunsekarang') }}">Home</a></li>
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
                    <h3 class="card-title">Laporan Bulan: {{ $bulan }} </h3>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="bulansekarang-table" class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>No</th>
                                <th>Tanggal</th>
                                <th>Pemasukan</th>
                                <th>Pengeluaran</th>
                                <th>Saldo Bersih</th>
                            </tr>
                            </thead>
                            <tbody>
                            @foreach($formattedReports as $report)
                                <tr>
                                    <td>{{ $loop->iteration }}</td>
                                    <td>
                                        <a href="{{ route('bulansekarang.detail', ['date' => \Carbon\Carbon::parse(convertToEnglishDate($report['day']))->format('Y-m-d')]) }}">
                                            {{ $report['day'] }}
                                        </a>
                                    </td>
                                    <td>Rp {{ number_format($report['income'], 2, ',', '.') }}</td>
                                    <td>Rp {{ number_format($report['expense'], 2, ',', '.') }}</td>
                                    <td>Rp {{ number_format($report['net_balance'], 2, ',', '.') }}</td>
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
            $('#bulansekarang-table').DataTable();
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        const chartData = JSON.parse('{!! json_encode($chartDataPemasukan) !!}');

        const ctx = document.getElementById('incomeChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: chartData.labels,
                datasets: [{
                    label: 'Pemasukan',
                    data: chartData.income,
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
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        const chartDatae = JSON.parse('{!! json_encode($chartDataPengeluaran) !!}');

        const ctxe = document.getElementById('expenseChart').getContext('2d');
        new Chart(ctxe, {
            type: 'line',
            data: {
                labels: chartDatae.labels,
                datasets: [{
                    label: 'Pengeluaran',
                    data: chartDatae.expense,
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
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>

    <script>
        const chartDatar = JSON.parse('{!! json_encode($chartDataRincianPemasukan) !!}');

        const ctxr = document.getElementById('incomePieChart').getContext('2d');
        new Chart(ctxr, {
            type: 'pie',
            data: {
                labels: chartDatar.labels,
                datasets: [{
                    data: chartDatar.data,
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.5)',
                        'rgba(54, 162, 235, 0.5)',
                        'rgba(255, 206, 86, 0.5)',
                        'rgba(255, 99, 132, 0.5)',
                        'rgba(153, 102, 255, 0.5)',
                        'rgba(255, 159, 64, 0.5)'
                    ]
                }]
            },
            options: {
                responsive: true
            }
        });
    </script>

    <script>
        const chartDatare = JSON.parse('{!! json_encode($chartDataRincianPengeluaran) !!}');

        const ctxre = document.getElementById('expensePieChart').getContext('2d');
        new Chart(ctxre, {
            type: 'pie',
            data: {
                labels: chartDatare.labels,
                datasets: [{
                    data: chartDatare.data,
                    backgroundColor: [
                        'rgba(75, 192, 192, 0.5)',
                        'rgba(54, 162, 235, 0.5)',
                        'rgba(255, 206, 86, 0.5)',
                        'rgba(255, 99, 132, 0.5)',
                        'rgba(153, 102, 255, 0.5)',
                        'rgba(255, 159, 64, 0.5)'
                    ]
                }]
            },
            options: {
                responsive: true
            }
        });
    </script>
@endpush