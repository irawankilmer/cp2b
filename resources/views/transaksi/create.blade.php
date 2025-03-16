@extends('../layout')
@section('title', 'Transaki - Create')

@section('breadcumb')
    <div class="row">
        <div class="col-sm-6"><h3 class="mb-0">Transaksi</h3></div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-end">
                <li class="breadcrumb-item"><a href="{{ route('transaksi') }}">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Create</li>
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
                    <h3 class="card-title">Buat Transaksi Baru</h3>
                </div>
                <div class="card-body">

                    <form method="POST" action="{{ route('transaksi.store') }}" onsubmit="disableSubmitButton()">
                        @csrf
                        <div class="mb-3">
                            <label for="date" class="form-label">Tanggal</label>
                            <input type="date" class="form-control" id="date" name="date" required>
                        </div>

                        <div class="mb-3">
                            <label for="type" class="form-label">Jenis Transaksi</label>
                            <select class="form-control" id="type" name="type" required>
                                <option value="pemasukan">Pemasukan</option>
                                <option value="pengeluaran">Pengeluaran</option>
                                <option value="pindah">Pindah Saldo</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="account_id" class="form-label">Akun Asal</label>
                            <select class="form-control" id="account_id" name="account_id" required>
                                @foreach($accounts as $account)
                                    <option value="{{ $account->id }}">{{ $account->name }}</option>
                                @endforeach
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="target_account_id" class="form-label">Akun Tujuan (Untuk Pindah Saldo)</label>
                            <select class="form-control" id="target_account_id" name="target_account_id">
                                <option value="">Pilih Akun</option>
                                @foreach($accounts as $account)
                                    <option value="{{ $account->id }}">{{ $account->name }}</option>
                                @endforeach
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="category_id" class="form-label">Kategori</label>
                            <select class="form-control" id="category_id" name="category_id" required>
                                @foreach($categories as $category)
                                    <option value="{{ $category->id }}">{{ $category->name }}</option>
                                @endforeach
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="amount" class="form-label">Jumlah</label>
                            <input type="number" class="form-control" id="amount" name="amount" step="0.01" min="0.01" required>
                        </div>

                        <div class="mb-3">
                            <label for="descriptions" class="form-label">Deskripsi (Opsional)</label>
                            <input type="text" class="form-control" id="descriptions" name="descriptions">
                        </div>

                        <button type="submit" class="btn btn-primary" id="submit-btn">
                            <i class="bi bi-floppy"></i>
                            <span id="button-text">Simpan Transaksi</span>
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

            submitButton.disabled = true;  // Nonaktifkan tombol
            spinner.style.display = 'inline-block';  // Tampilkan spinner
            buttonText.textContent = 'Menyimpan...';  // Ubah teks tombol
        }
    </script>
@endpush