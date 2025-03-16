@extends('../layout')
@section('title', 'Penyimpanan - Create')

@section('breadcumb')
    <div class="row">
        <div class="col-sm-6"><h3 class="mb-0">Penyimpanan</h3></div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-end">
                <li class="breadcrumb-item"><a href="{{ route('account') }}">Home</a></li>
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
                    <h3 class="card-title">Tambah Data Penyimpanan</h3>
                </div>
                <div class="card-body">

                    <form method="POST" action="{{ route('account.store') }}">
                        @csrf
                        @error('name')
                        <span class="badge bg-danger">{{ $message }}</span>
                        @enderror
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" class="form-control" id="name" name="name" value="{{ old('name') }}">
                        </div>

                        @error('descriptions')
                        <span class="badge bg-danger">{{ $message }}</span>
                        @enderror
                        <div class="mb-3">
                            <label for="descriptions" class="form-label">Deskripsi</label>
                            <input type="text" class="form-control" id="descriptions" name="descriptions" value="{{ old('descriptions') }}">
                        </div>

                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-floppy"></i>
                            Simpan Data
                        </button>
                    </form>
                </div>
            </div>
            <!-- /.card -->
        </div>
    </div>
@endsection