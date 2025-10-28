@extends('layout')
@section('title', 'Kategori - ' . ucfirst($kategori))

@section('breadcumb')
<div class="row mb-3">
  <div class="col-sm-6">
    <h3 class="mb-0">{{ ucfirst($kategori) }} ({{ $monthName }} {{ $year }})</h3>
  </div>
  <div class="col-sm-6">
    <ol class="breadcrumb float-sm-end">
      <li class="breadcrumb-item"><a href="{{ route('tahunsekarang') }}">Tahun Sekarang</a></li>
      <li class="breadcrumb-item active">{{ ucfirst($kategori) }}</li>
    </ol>
  </div>
</div>
@endsection

@section('content')
<div class="card">
  <div class="card-body">
    <h5 class="mb-3">
      Total {{ $type ? ucfirst($type) : 'Transaksi' }}: 
      <strong>Rp{{ number_format($total, 0, ',', '.') }}</strong>
    </h5>

    <div class="table-responsive">
      <table id="datatable" class="table table-bordered table-striped">
        <thead>
          <tr>
            <th>Hari & Tanggal</th>
            <th>Kategori</th>
            <th>Akun</th>
            <th>Jumlah</th>
            <th>Keterangan</th>
          </tr>
        </thead>
        <tbody>
          @forelse($transactions as $t)
            <tr>
              <td>{{ \Carbon\Carbon::parse($t->date)->locale('id')->translatedFormat('l, d F Y') }}</td>
              <td>{{ $t->category->name ?? '-' }}</td>
              <td>{{ $t->account->name ?? '-' }}</td>
              <td>
                Rp{{ number_format($t->amount, 0, ',', '.') }}
              </td>
              <td>{{ $t->descriptions ?? '-' }}</td>
            </tr>
          @empty
            <tr>
              <td colspan="5" class="text-center">Tidak ada transaksi untuk kategori ini.</td>
            </tr>
          @endforelse
        </tbody>
      </table>
    </div>
  </div>
</div>
@endsection

@push('styles')
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
@endpush

@push('scripts')
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

  <script>
    $(document).ready(function() {
        $('#datatable').DataTable({
            language: {
                url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/id.json"
            },
            order: [[0, 'desc']],
            pageLength: 10,
            responsive: true
        });
    });
  </script>
@endpush
