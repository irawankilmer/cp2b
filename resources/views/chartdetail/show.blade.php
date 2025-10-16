@extends('layout')

@section('title', 'Detail Grafik')

@section('breadcumb')
  <div class="row">
    <div class="col-sm-6"><h3 class="mb-0">Detail: {{ ucfirst($type) }} - {{ $name }}</h3></div>
    <div class="col-sm-6">
      <ol class="breadcrumb float-sm-end">
        <li class="breadcrumb-item"><a href="{{ route('dashboard') }}">Dashboard</a></li>
        <li class="breadcrumb-item active" aria-current="page">Detail Grafik</li>
      </ol>
    </div>
  </div>
@endsection

@section('content')
  <div class="card">
    <div class="card-header">
      <h3 class="card-title">Daftar Transaksi</h3>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table id="detailTable" class="table table-bordered table-striped">
          <thead>
          <tr>
            <th>No</th>
            <th>Tanggal</th>
            <th>Jenis</th>
            <th>Akun</th>
            <th>Kategori</th>
            <th>Jumlah</th>
            <th>Deskripsi</th>
          </tr>
          </thead>
          <tbody>
          @foreach($transactions as $i => $trx)
            <tr>
              <td>{{ $i + 1 }}</td>
              <td>{{ $trx->date->format('l, d F Y') }}</td>
              <td>{{ ucfirst($trx->type) }}</td>
              <td>{{ $trx->account->name ?? '-' }}</td>
              <td>{{ $trx->category->name ?? '-' }}</td>
              <td>Rp {{ number_format($trx->amount, 2, ',', '.') }}</td>
              <td>{{ $trx->descriptions }}</td>
            </tr>
          @endforeach
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div class="card mb-3">
    <div class="card-header">
      <h3 class="card-title">Ringkasan</h3>
    </div>
    <div class="card-body">
      <div class="row text-center">
        <div class="col-md-6">
          <h5>Total Pemasukan</h5>
          <p><strong>Rp {{ number_format($totalIncome, 2, ',', '.') }}</strong></p>
        </div>
        <div class="col-md-6">
          <h5>Total Pengeluaran</h5>
          <p><strong>Rp {{ number_format($totalExpense, 2, ',', '.') }}</strong></p>
        </div>
      </div>
    </div>
  </div>

  <div class="card mb-3">
    <div class="card-header">
      <h3 class="card-title">Grafik Transaksi</h3>
    </div>
    <div class="card-body">
      <canvas id="lineChart"></canvas>
    </div>
  </div>
@endsection

@push('scripts')
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script>
    $(document).ready(function() {
      $('#detailTable').DataTable();
    });
  </script>
  <script>
    const chartData = @json($chartData);

    const ctx = document.getElementById('lineChart').getContext('2d');
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: chartData.labels,
        datasets: [
          {
            label: 'Pemasukan',
            data: chartData.income,
            borderColor: 'rgba(75, 192, 192, 1)',
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            tension: 0.3,
            fill: false,
            borderWidth: 2
          },
          {
            label: 'Pengeluaran',
            data: chartData.expense,
            borderColor: 'rgba(255, 99, 132, 1)',
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            tension: 0.3,
            fill: false,
            borderWidth: 2
          }
        ]
      },
      options: {
        responsive: true,
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              callback: function(value) {
                return 'Rp ' + value.toLocaleString('id-ID');
              }
            }
          }
        }
      }
    });
  </script>
@endpush

