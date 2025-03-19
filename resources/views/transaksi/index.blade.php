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
                                <td>{{ $transaction->created_at->format('H:i') . ' WIB' }}</td>
                                <td>{{ $transaction->type }}</td>
                                <td>{{ $transaction->account->name }}</td>
                                <td>{{ $transaction->category->name }}</td>
                                <td>{{ 'Rp ' . number_format($transaction->amount, 2, ',', '.') }}</td>
                                <td>{{ $transaction->descriptions }}</td>
                                <td>
                                  <a href="{{ route('transaksi.edit', $transaction['id']) }}" class="btn text-bg-dark btn-sm">
                                    <i class="bi bi-pencil-square"></i>
                                    Edit
                                  </a>

                                  <form id="delete-form-{{ $transaction->id }}" action="{{ route('transaksi.destroy', $transaction->id) }}" method="POST" class="d-inline-block">
                                    @csrf
                                    @method('DELETE')
                                    <a href="#" class="btn btn-rounded btn-danger btn-sm" onclick="confirmDelete({{ $transaction->id }})">
                                      <i class="bi bi-trash"></i>
                                      Hapus
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
            <!-- /.card -->
        </div>

      <div class="col-md-12 mt-3">
        <div class="card">
          <div class="card-header">
            <h3 class="card-title">Rekap data hari ini: {{ $hari }}</h3>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-md-4">
                <p class="my-3 text-center">Total Saldo: <strong>Rp {{ number_format($totalBalance, 2, ',', '.') }}</strong></p>
                <canvas id="balanceChart"></canvas>
              </div>
              <div class="col-md-4">
                <p class="my-3 text-center">
                  Total Pemasukan: <strong> Rp {{ number_format($totalIncome, 2, ',', '.') }}</strong>
                </p>
                <canvas id="incomeChart"></canvas>
              </div>
              <div class="col-md-4">
                <p class="my-3 text-center">
                  Total Pengeluaran: <strong> Rp {{ number_format($totalExpense, 2, ',', '.') }}</strong>
                </p>
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
    <script>
        $(document).ready(function() {
            $('#transactions-table').DataTable();
        });
    </script>
    <script>
      function confirmDelete(transactionID) {
        Swal.fire({
          title: "Apakah Anda yakin?",
          text: "Data yang dihapus tidak bisa dikembalikan! Termasuk semua data transaksi yang terhubung",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#d33",
          cancelButtonColor: "#3085d6",
          confirmButtonText: "Ya, hapus!",
          cancelButtonText: "Batal"
        }).then((result) => {
          if (result.isConfirmed) {
            document.getElementById('delete-form-' + transactionID).submit();
          }
        });
      }
    </script>

    <script>
      const chartData = JSON.parse('{!! $chartData !!}');

      const ctx = document.getElementById('balanceChart').getContext('2d');
      new Chart(ctx, {
        type: 'pie',
        data: {
          labels: chartData.labels,
          datasets: [{
            data: chartData.data,
            backgroundColor: [
              'rgba(75, 192, 192, 0.2)',
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 206, 86, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(153, 102, 255, 0.2)'
            ],
            borderColor: [
              'rgba(75, 192, 192, 1)',
              'rgba(255, 99, 132, 1)',
              'rgba(255, 206, 86, 1)',
              'rgba(54, 162, 235, 1)',
              'rgba(153, 102, 255, 1)'
            ],
            borderWidth: 1
          }]
        },
        options: {
          responsive: true
        }
      });
    </script>

    <script>
      const incomeData = JSON.parse('{!! $chartIncomeData !!}');

      const ctxIncome = document.getElementById('incomeChart').getContext('2d');
      new Chart(ctxIncome, {
        type: 'doughnut',
        data: {
          labels: incomeData.labels,
          datasets: [{
            data: incomeData.data,
            backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 159, 64, 0.2)',
              'rgba(255, 205, 86, 0.2)',
              'rgba(75, 192, 192, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(153, 102, 255, 0.2)',
              'rgba(201, 203, 207, 0.2)'
            ],
            borderColor: [
              'rgba(255, 99, 132, 1)',
              'rgba(255, 159, 64, 1)',
              'rgba(255, 205, 86, 1)',
              'rgba(75, 192, 192, 1)',
              'rgba(54, 162, 235, 1)',
              'rgba(153, 102, 255, 1)',
              'rgba(201, 203, 207, 1)'
            ],
            borderWidth: 1
          }]
        },
        options: {
          responsive: true
        }
      });
    </script>

    <script>
      const expenseData = JSON.parse('{!! $chartExpenseData !!}');

      const ctxExpense = document.getElementById('expenseChart').getContext('2d');
      new Chart(ctxExpense, {
        type: 'doughnut',
        data: {
          labels: expenseData.labels,
          datasets: [{
            data: expenseData.data,
            backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(255, 159, 64, 0.2)',
              'rgba(255, 205, 86, 0.2)',
              'rgba(75, 192, 192, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(153, 102, 255, 0.2)',
              'rgba(201, 203, 207, 0.2)'
            ],
            borderColor: [
              'rgba(255, 99, 132, 1)',
              'rgba(255, 159, 64, 1)',
              'rgba(255, 205, 86, 1)',
              'rgba(75, 192, 192, 1)',
              'rgba(54, 162, 235, 1)',
              'rgba(153, 102, 255, 1)',
              'rgba(201, 203, 207, 1)'
            ],
            borderWidth: 1
          }]
        },
        options: {
          responsive: true
        }
      });
    </script>
@endpush