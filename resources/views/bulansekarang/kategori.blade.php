@extends('layout')
@section('title', 'Detail Kategori')

@section('breadcumb')
<div class="row mb-3">
  <div class="col-sm-6">
    <h3 class="mb-0">
      Detail Kategori: {{ ucfirst($kategori) }}
      @if($context === 'harian')
        ({{ \Carbon\Carbon::parse($date)->format('d M Y') }})
      @else
        (Bulan Ini)
      @endif
    </h3>
  </div>
  <div class="col-sm-6 text-end">
    @if($context === 'harian')
      <a href="{{ route('bulansekarang.detail', $date) }}" class="btn btn-secondary">Kembali ke Hari</a>
    @else
      <a href="{{ route('bulansekarang') }}" class="btn btn-secondary">Kembali ke Bulan</a>
    @endif
  </div>
</div>
@endsection

@section('content')
<div class="card">
  <div class="card-body">
    <div class="table-responsive">
      <table id="kategori-table" class="table table-bordered table-striped">
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
          @forelse ($transactions as $item)
            <tr>
              <td>{{ $loop->iteration }}</td>
              <td>{{ \Carbon\Carbon::parse($item->created_at)->format('H:i') }} WIB</td>
              <td>{{ $item->type }}</td>
              <td>{{ $item->account->name ?? '-' }}</td>
              <td>{{ $item->category->name ?? '-' }}</td>
              <td>Rp{{ number_format($item->amount, 0, ',', '.') }}</td>
              <td>{{ $item->descriptions ?? '-' }}</td>
            </tr>
          @empty
            <tr>
              <td colspan="7" class="text-center">Tidak ada transaksi</td>
            </tr>
          @endforelse
        </tbody>
      </table>
    </div>
  </div>
</div>
@endsection

@push('scripts')
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script>
  $(document).ready(function() {
      $('#kategori-table').DataTable();
  });
</script>
@endpush
