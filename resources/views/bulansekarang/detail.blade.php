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
                <th>Tindakan</th>
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
                <td>
                  <a href="{{ route('transaksi.edit', $transaction->id) }}" class="btn btn-sm btn-dark">
                    <i class="bi bi-pencil-square"></i> Edit
                  </a>

                  <form id="delete-form-{{ $transaction->id }}" 
                        action="{{ route('transaksi.destroy', $transaction->id) }}" 
                        method="POST" 
                        class="d-inline">
                    @csrf
                    @method('DELETE')
                    <button type="button" class="btn btn-sm btn-danger" onclick="confirmDelete({{ $transaction->id }})">
                      <i class="bi bi-trash"></i> Hapus
                    </button>
                  </form>
                </td>
              </tr>
              @endforeach
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="row mt-3">
  <div class="col-md-6">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Total Pemasukan: Rp {{ number_format($totalIncome, 2, ',', '.') }}</h3>
      </div>
      <div class="card-body">
        <canvas id="incomePieChart"></canvas>
      </div>
    </div>
  </div>

  <div class="col-md-6">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Total Pengeluaran: Rp {{ number_format($totalExpense, 2, ',', '.') }}</h3>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
  $(document).ready(() => $('#transactions-table').DataTable());

  function confirmDelete(id) {
    Swal.fire({
      title: 'Apakah Anda yakin?',
      text: "Transaksi yang dihapus tidak bisa dikembalikan!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#3085d6',
      confirmButtonText: 'Ya, hapus!'
    }).then((result) => {
      if (result.isConfirmed) {
        document.getElementById('delete-form-' + id).submit();
      }
    });
  }

  const incomePieData = JSON.parse('{!! $chartpiedatapemasukan !!}');
  const expensePieData = JSON.parse('{!! $chartpiedatapengeluaran !!}');
  const currentDate = "{{ $date ?? request()->route('date') }}";

  const incomePieCtx = document.getElementById('incomePieChart').getContext('2d');
  const incomePieChart = new Chart(incomePieCtx, {
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
  const expensePieChart = new Chart(expensePieCtx, {
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

  function handlePieClick(evt, chart, type) {
    const activePoints = chart.getElementsAtEventForMode(evt, 'nearest', { intersect: true }, true);
    if (activePoints.length) {
      const index = activePoints[0].index;
      const label = chart.data.labels[index];
      const encodedLabel = encodeURIComponent(label);

      const url = `{{ url('/bulansekarang') }}/${currentDate}/kategori/${encodedLabel}?type=${type}`;

      window.location.href = url;
    }
  }

  document.getElementById('incomePieChart').onclick = (evt) => handlePieClick(evt, incomePieChart, 'pemasukan');
  document.getElementById('expensePieChart').onclick = (evt) => handlePieClick(evt, expensePieChart, 'pengeluaran');
</script>
@endpush
