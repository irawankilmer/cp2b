@extends('../layout')
@section('title', 'Kategori')

@section('breadcumb')
    <div class="row">
        <div class="col-sm-6"><h3 class="mb-0">Kategori</h3></div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-end">
                <li class="breadcrumb-item"><a href="{{ route('category') }}">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Kategori</li>
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
                            <h3 class="card-title">Data Kategori</h3>
                        </div>
                        <div class="col-12 col-md-6 text-md-end">
                            <a href="{{ route('category.create') }}" class="btn btn-info btn-sm">
                                <i class="bi bi-folder-plus"></i> Tambah
                            </a>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="bulansekarang-table" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Nama</th>
                                    <th>Deskripsi</th>
                                    <th>Tindakan</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach($categories as $ac)
                                    <tr>
                                        <td>{{ $loop->iteration }}</td>
                                        <td>{{ $ac['name'] }}</td>
                                        <td>{{ $ac['descriptions'] }}</td>
                                        <td>
                                            <a href="{{ route('category.edit', $ac['id']) }}" class="btn text-bg-dark btn-sm">
                                                <i class="bi bi-pencil-square"></i>
                                                Edit
                                            </a>

                                            <form id="delete-form-{{ $ac->id }}" action="{{ route('category.destroy', $ac->id) }}" method="POST" class="d-inline-block">
                                                @csrf
                                                @method('DELETE')
                                                <a href="#" class="btn btn-rounded btn-danger btn-sm" onclick="confirmDelete({{ $ac->id }})">
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
    </div>
@endsection

@push('styles')
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
@endpush

@push('scripts')
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#bulansekarang-table').DataTable();
        });
    </script>

    <script>
        function confirmDelete(accountId) {
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
                    document.getElementById('delete-form-' + accountId).submit();
                }
            });
        }
    </script>
@endpush