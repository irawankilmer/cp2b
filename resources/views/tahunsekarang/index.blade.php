@extends('../layout')
@section('title', 'Laporan Tahun Sekarang')

@section('breadcumb')
    <div class="row">
        <div class="col-sm-6"><h3 class="mb-0">Laporan Tahun Sekarang</h3></div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-end">
                <li class="breadcrumb-item"><a href="{{ route('tahunsekarang') }}">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Laporan Tahun Sekarang</li>
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
                    <h3 class="card-title">Laporan Tahun: {{ $year }}</h3>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="bulansekarang-table" class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>No</th>
                                <th>Bulan</th>
                                <th>Pemasukan</th>
                                <th>Pengeluaran</th>
                                <th>Saldo Bersih</th>
                            </tr>
                            </thead>
                            <tbody>
                            @foreach($report as $rr)
                                <tr>
                                    <td>{{ $loop->iteration }}</td>
                                    <td>
                                        <a href="{{ route('tahunsekarang.detail',
                                            ['month' => \Carbon\Carbon::parse(convertToEnglishDate($rr['month']))->format('n'),
                                            'year' => \Carbon\Carbon::parse(convertToEnglishDate($rr['month']))->format('Y')
                                            ]) }}">
                                            {{ $rr['month'] }}
                                        </a>
                                    </td>
                                    <td>Rp {{ number_format($rr['income'], 2, ',', '.') }}</td>
                                    <td>Rp {{ number_format($rr['expense'], 2, ',', '.') }}</td>
                                    <td>Rp {{ number_format($rr['net_balance'], 2, ',', '.') }}</td>
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
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <canvas id="monthlyChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-3">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Total Pemasukan: Rp {{ number_format($totalIncome, 0, ',', '.') }}</h3>
                </div>
                <div class="card-body">
                    <canvas id="incomePieChart"></canvas>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Total Pemasukan: Rp {{ number_format($totalExpense, 0, ',', '.') }}</h3>
                </div>
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#bulansekarang-table').DataTable();
        });
    </script>

    <script>
        const incomeData = @json(array_values($incomeData));
        const expenseData = @json(array_values($expenseData));

        const months = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];

        const incomeCategories = @json($incomeCategories->pluck('total'));
        const incomeLabels = @json($incomeCategories->pluck('category'));

        const expenseCategories = @json($expenseCategories->pluck('total'));
        const expenseLabels = @json($expenseCategories->pluck('category'));

        new Chart(document.getElementById('monthlyChart'), {
            type: 'bar',
            data: {
                labels: months,
                datasets: [
                    { label: 'Pemasukan', data: incomeData, backgroundColor: 'rgba(75, 192, 192, 0.2)', borderColor: 'rgba(75, 192, 192, 1)', borderWidth: 1 },
                    { label: 'Pengeluaran', data: expenseData, backgroundColor: 'rgba(255, 99, 132, 0.2)', borderColor: 'rgba(255, 99, 132, 1)', borderWidth: 1 }
                ]
            },
            options: { responsive: true, scales: { y: { beginAtZero: true } } }
        });

        new Chart(document.getElementById('incomePieChart'), {
            type: 'pie',
            data: { labels: incomeLabels, datasets: [{ data: incomeCategories, backgroundColor: ['#36A2EB', '#FFCE56', '#FF6384', '#4BC0C0', '#9966FF', '#FF9F40'] }] },
            options: { responsive: true }
        });

        new Chart(document.getElementById('expensePieChart'), {
            type: 'pie',
            data: { labels: expenseLabels, datasets: [{ data: expenseCategories, backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40'] }] },
            options: { responsive: true }
        });
    </script>

@endpush