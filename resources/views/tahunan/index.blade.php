@extends('../layout')
@section('title', 'Laporan Tahun Sekarang')

@section('breadcumb')
    <div class="row">
        <div class="col-sm-6"><h3 class="mb-0">Laporan Tahunan</h3></div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-end">
                <li class="breadcrumb-item"><a href="{{ route('tahunan') }}">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Laporan Tahunan</li>
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
                    <h3 class="card-title">Laporan Tahunan</h3>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="bulansekarang-table" class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>No</th>
                                <th>Tahun</th>
                                <th>Total Pemasukan</th>
                                <th>Total Pengeluaran</th>
                                <th>Saldo Bersih</th>
                            </tr>
                            </thead>
                            <tbody>
                            @foreach($report as $rr)
                                <tr>
                                    <td>{{ $loop->iteration }}</td>
                                    <td>
                                        <a href="{{ route('tahunan.detail', $rr['year']) }}">
                                            {{ $rr['year'] }}
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
@endpush