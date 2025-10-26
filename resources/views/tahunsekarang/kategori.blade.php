@extends('layout')
@section('title', 'Kategori - ' . ucfirst($kategori))

@section('breadcumb')
<div class="row">
  <div class="col-sm-6"><h3 class="mb-0">{{ ucfirst($kategori) }} ({{ $year }})</h3></div>
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
      <table id="kategoriTable" class="table table-bordered table-striped">
        <thead>
          <tr>
            <th>Tanggal</th>
            <th>Kategori</th>
            <th>Akun</th>
            <th>Jumlah</th>
            <th>Keterangan</th>
          </tr>
        </thead>
        <tbody>
          @forelse($transactions as $t)
            <tr>
              <td>{{ \Carbon\Carbon::parse($t->date)->translatedFormat('d F Y') }}</td>
              <td>{{ $t->category->name ?? '-' }}</td>
              <td>{{ $t->account->name ?? '-' }}</td>
              <td>Rp{{ number_format($t->amount, 0, ',', '.') }}</td>
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

@push('scripts')
  {{-- jQuery dulu --}}
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  {{-- DataTables --}}
  <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
  <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>

  <script>
    $(document).ready(function() {
      $('#kategoriTable').DataTable({
        language: {
          search: "Cari:",
          lengthMenu: "Tampilkan _MENU_ data",
          info: "Menampilkan _START_ sampai _END_ dari _TOTAL_ data",
          infoEmpty: "Tidak ada data tersedia",
          zeroRecords: "Tidak ditemukan hasil yang cocok",
          paginate: {
            first: "Pertama",
            last: "Terakhir",
            next: "›",
            previous: "‹"
          },
        },
        order: [[0, 'desc']],
        pageLength: 10,
      });
    });
  </script>
@endpush

