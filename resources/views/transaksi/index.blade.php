@extends('../layout')
@section('title', 'Transaki')

@section('breadcumb')
    <div class="row">
        <div class="col-sm-6"><h3 class="mb-0">Transaksi</h3></div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-end">
                <li class="breadcrumb-item"><a href="{{ route('transaksi') }}">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Transaksi</li>
            </ol>
        </div>
    </div>
@endsection

@section('content')
    <div class="row">
        <div class="col-12">
            <!-- Default box -->
            <div class="card">
                <div class="card-header">
                    <div class="row align-items-center">
                      <div class="col-12 col-md-6 mb-3 mb-md-0">
                        <h3 class="card-title">Transaksi Hari Ini: {{ $hari }}</h3>
                      </div>
                      <div class="col-12 col-md-6 text-md-end">
                        <a href="{{ route('transaksi.import') }}" class="btn btn-primary btn-sm me-2 mb-2 mb-md-0">
                          <i class="bi bi-upload"></i> Import
                        </a>
                        <button class="btn btn-success btn-sm me-2 mb-2 mb-md-0">
                          <i class="bi bi-download"></i> Export
                        </button>
                        <a href="{{ route('transaksi.create') }}" class="btn btn-info btn-sm">
                          <i class="bi bi-folder-plus"></i> Tambah
                        </a>
                      </div>
                    </div>
                  </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="transactions-table" class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>No</th>
                                <th>Jenis</th>
                                <th>Akun</th>
                                <th>Kategori</th>
                                <th>Jumlah</th>
                                <th>Deskripsi</th>
                                <th>Saldo Setelah</th>
                            </tr>
                            </thead>
                            <tbody>
                            @foreach($transactions as $transaction)
                                <tr>
                                    <td>{{ $loop->iteration }}</td>
                                    <td>{{ $transaction->type }}</td>
                                    <td>{{ $transaction->account->name }}</td>
                                    <td>{{ $transaction->category->name }}</td>
                                    <td>{{ 'Rp ' . number_format($transaction->amount, 2, ',', '.') }}</td>
                                    <td>{{ $transaction->descriptions }}</td>
                                    <td>{{ 'Rp ' . number_format($transaction->balance_after, 2, ',', '.') }}</td>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#transactions-table').DataTable();
        });
    </script>
@endpush