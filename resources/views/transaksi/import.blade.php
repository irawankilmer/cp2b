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
        <div class="col-4">
            <!-- Default box -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Title</h3>
                </div>
                <div class="card-body">
                    <form action="{{ route('transaksi.importStore') }}" method="POST" enctype="multipart/form-data">
                        @csrf
                        <input type="file" name="file" id="file">
                        <button type="submit">upload</button>
                    </form>

                </div>
                <!-- /.card-body -->
                <div class="card-footer">Footer</div>
                <!-- /.card-footer-->
            </div>
            <!-- /.card -->
        </div>

        <div class="col-6">
            <div class="card">
                <div class="card-header">
                    <p id="error-message" class="text-danger"></p>
                    <button id="upload-btn" class="btn btn-primary" disabled>Upload</button>
                </div>

                <div class="card-body">

                </div>
            </div>
        </div>
    </div>
@endsection

@push('styles')
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.css">
@endpush

@push('scripts')

@endpush