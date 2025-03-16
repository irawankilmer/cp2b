@extends('../layout')
@section('title', 'Transaksi - Edit')

@section('breadcumb')
  <div class="row">
    <div class="col-sm-6"><h3 class="mb-0">Transaksi</h3></div>
    <div class="col-sm-6">
      <ol class="breadcrumb float-sm-end">
        <li class="breadcrumb-item"><a href="{{ route('transaksi') }}">Home</a></li>
        <li class="breadcrumb-item active" aria-current="page">Edit</li>
      </ol>
    </div>
  </div>
@endsection

@section('content')
  <div class="row">
    <div class="col-md-6">
      <!-- Default box -->
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">Edit Transaksi</h3>
        </div>
        <div class="card-body">

          <form method="POST" action="{{ route('transaksi.update', $transaction->id) }}" onsubmit="disableSubmitButton()">
            @csrf
            @method('PATCH')

            <div class="mb-3">
              <label for="date" class="form-label">Tanggal</label>
              <input type="date" class="form-control" id="date" name="date" value="{{ old('date', $transaction->date ? $transaction->date->format('Y-m-d') : '') }}" required>
            </div>


            <div class="mb-3">
              <label for="type" class="form-label">Jenis Transaksi</label>
              <select class="form-control" id="type" name="type" required>
                <option value="pemasukan" {{ $transaction->type === 'pemasukan' ? 'selected' : '' }}>Pemasukan</option>
                <option value="pengeluaran" {{ $transaction->type === 'pengeluaran' ? 'selected' : '' }}>Pengeluaran</option>
                <option value="pindah" {{ $transaction->type === 'pindah' ? 'selected' : '' }}>Pindah Saldo</option>
              </select>
            </div>

            <div class="mb-3">
              <label for="account_id" class="form-label">Akun Asal</label>
              <select class="form-control" id="account_id" name="account_id" required>
                @foreach($accounts as $account)
                  <option value="{{ $account->id }}" {{ $transaction->account_id == $account->id ? 'selected' : '' }}>
                    {{ $account->name }}
                  </option>
                @endforeach
              </select>
            </div>

            <div class="mb-3">
              <label for="target_account_id" class="form-label">Akun Tujuan (Untuk Pindah Saldo)</label>
              <select class="form-control" id="target_account_id" name="target_account_id">
                <option value="">Pilih Akun</option>
                @foreach($accounts as $account)
                  <option value="{{ $account->id }}" {{ $transaction->target_account_id == $account->id ? 'selected' : '' }}>
                    {{ $account->name }}
                  </option>
                @endforeach
              </select>
            </div>

            <div class="mb-3">
              <label for="category_id" class="form-label">Kategori</label>
              <select class="form-control" id="category_id" name="category_id" required>
                @foreach($categories as $category)
                  <option value="{{ $category->id }}" {{ $transaction->category_id == $category->id ? 'selected' : '' }}>
                    {{ $category->name }}
                  </option>
                @endforeach
              </select>
            </div>

            <div class="mb-3">
              <label for="amount" class="form-label">Jumlah</label>
              <input type="number" class="form-control" id="amount" name="amount" step="0.01" min="0.01" value="{{ old('amount', $transaction->amount) }}" required>
            </div>

            <div class="mb-3">
              <label for="descriptions" class="form-label">Deskripsi (Opsional)</label>
              <input type="text" class="form-control" id="descriptions" name="descriptions" value="{{ old('descriptions', $transaction->descriptions) }}">
            </div>

            <button type="submit" class="btn btn-primary" id="submit-btn">
              <i class="bi bi-pencil-square"></i>
              <span id="button-text">Edit Transaksi</span>
              <span id="loading-spinner" class="spinner-border spinner-border-sm" role="status" aria-hidden="true" style="display: none;"></span>
            </button>
          </form>

        </div>
      </div>
      <!-- /.card -->
    </div>
  </div>
@endsection

@push('scripts')
  <script>
    function disableSubmitButton() {
      const submitButton = document.getElementById('submit-btn');
      const spinner = document.getElementById('loading-spinner');
      const buttonText = document.getElementById('button-text');

      submitButton.disabled = true;
      spinner.style.display = 'inline-block';
      buttonText.textContent = 'Update...';
    }
  </script>
@endpush
