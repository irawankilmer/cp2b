@extends('../layout')
@section('title', 'Transaksi')

@section('breadcumb')
<div class="row">
  <div class="col-sm-6"><h3 class="mb-0">Transaksi</h3></div>
  <div class="col-sm-6">
    <ol class="breadcrumb float-sm-end">
      <li class="breadcrumb-item"><a href="{{ route('dashboard') }}">Home</a></li>
      <li class="breadcrumb-item active" aria-current="page">Transaksi</li>
    </ol>
  </div>
</div>
@endsection

@section('content')
<div class="row">
  <div class="col-12">
    <div class="card">
      <div class="card-header">
        <div class="row align-items-center">
          <div class="col-12 col-md-6 mb-3 mb-md-0">
            <h3 class="card-title">
              Transaksi Hari Ini: {{ $hari }}
              @if($kategoriDipilih)
                <span class="badge bg-info ms-2">Kategori: {{ ucfirst($kategoriDipilih) }}</span>
              @endif
            </h3>
          </div>
          <div class="col-12 col-md-6 text-md-end">
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
                <td>{{ $transaction->created_at->format('H:i') }} WIB</td>
                <td>{{ ucfirst($transaction->type) }}</td>
                <td>{{ $transaction->account->name }}</td>
                <td>{{ $transaction->category->name }}</td>
                <td>Rp {{ number_format($transaction->amount, 2, ',', '.') }}</td>
                <td>{{ $transaction->descriptions }}</td>
                <td>
                  <a href="{{ route('transaksi.edit', $transaction->id) }}" class="btn btn-dark btn-sm">
                    <i class="bi bi-pencil-square"></i> Edit
                  </a>
                  <form id="delete-form-{{ $transaction->id }}" action="{{ route('transaksi.destroy', $transaction->id) }}" method="POST" class="d-inline-block">
                    @csrf
                    @method('DELETE')
                    <a href="#" class="btn btn-danger btn-sm" onclick="confirmDelete({{ $transaction->id }})">
                      <i class="bi bi-trash"></i> Hapus
                    </a>
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

  <div class="col-md-12 mt-3">
    <div class="card">
      <div class="card-header">
        <h3 class="card-title">Rekap Data Hari Ini: {{ $hari }}</h3>
      </div>

      <div class="card-body">
        <div class="row">
          <div class="col-md-4 text-center">
            <p>Total Saldo: <strong>Rp {{ number_format($totalBalance, 2, ',', '.') }}</strong></p>
            <canvas id="balanceChart"></canvas>
          </div>
          <div class="col-md-4 text-center">
            <p>Total Pemasukan: <strong>Rp {{ number_format($totalIncome, 2, ',', '.') }}</strong></p>
            <canvas id="incomeChart"></canvas>
          </div>
          <div class="col-md-4 text-center">
            <p>Total Pengeluaran: <strong>Rp {{ number_format($totalExpense, 2, ',', '.') }}</strong></p>
            <canvas id="expenseChart"></canvas>
          </div>
        </div>
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
$(document).ready(function() {
  $('#transactions-table').DataTable();
});

function confirmDelete(id) {
  Swal.fire({
    title: "Apakah Anda yakin?",
    text: "Data yang dihapus tidak bisa dikembalikan!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#d33",
    cancelButtonColor: "#3085d6",
    confirmButtonText: "Ya, hapus!",
    cancelButtonText: "Batal"
  }).then((result) => {
    if (result.isConfirmed) {
      document.getElementById('delete-form-' + id).submit();
    }
  });
}
</script>

<script>
const chartData = @json($chartData);
const incomeData = @json($chartIncomeData);
const expenseData = @json($chartExpenseData);

function makeClickableChart(ctx, data, type) {
  return new Chart(ctx, {
    type: type,
    data: {
      labels: data.labels,
      datasets: [{
        data: data.data,
        backgroundColor: [
          'rgba(75,192,192,0.4)',
          'rgba(255,99,132,0.4)',
          'rgba(255,206,86,0.4)',
          'rgba(54,162,235,0.4)',
          'rgba(153,102,255,0.4)',
          'rgba(255,159,64,0.4)',
          'rgba(201,203,207,0.4)'
        ],
        borderColor: [
          'rgba(75,192,192,1)',
          'rgba(255,99,132,1)',
          'rgba(255,206,86,1)',
          'rgba(54,162,235,1)',
          'rgba(153,102,255,1)',
          'rgba(255,159,64,1)',
          'rgba(201,203,207,1)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      responsive: true,
      onClick: function(evt, elements) {
        if (elements.length > 0) {
          const chart = elements[0].element.$context.chart;
          const index = elements[0].index;
          const label = chart.data.labels[index];
          const baseUrl = "{{ url('transaksi') }}";
          window.location.href = `${baseUrl}?kategori=${encodeURIComponent(label)}`;
        }
      }
    }
  });
}

makeClickableChart(document.getElementById('balanceChart').getContext('2d'), chartData, 'pie');
makeClickableChart(document.getElementById('incomeChart').getContext('2d'), incomeData, 'doughnut');
makeClickableChart(document.getElementById('expenseChart').getContext('2d'), expenseData, 'doughnut');
</script>
@endpush
