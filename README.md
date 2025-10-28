# CP2B  
**Catatan Pemasukan dan Pengeluaran Bulanan**

Aplikasi berbasis **Laravel** untuk mencatat dan memantau alur keuangan pribadi maupun keluarga.  
CP2B membantu mencatat **pemasukan, pengeluaran, dan perpindahan saldo antar akun** secara sederhana namun terstruktur.

---

## Fitur Utama

- **Login dan autentikasi pengguna**
- **Pencatatan transaksi** (pemasukan, pengeluaran, dan pindah saldo)
- **Manajemen akun keuangan** (Cash, BCA, DANA, dll)
- **Kategori transaksi** (otomatis mengelompokkan jenis transaksi)
- **Dashboard interaktif**
  - Grafik saldo per akun  
  - Grafik pemasukan dan pengeluaran per kategori  
  - Ringkasan bulanan otomatis
- **Laporan harian, bulanan, dan per kategori**
- **Seeder dengan data contoh** (100 transaksi acak untuk testing sistem)

---

## Instalasi

### Clone Repository
```bash
git clone https://github.com/irawankilmer/cp2b.git
cd cp2b
````

### Install Dependency

Pastikan kamu sudah menginstal **Composer** dan **Node.js**, kemudian jalankan:

```bash
composer install
npm install
```

### Konfigurasi Environment

Salin file `.env.example` menjadi `.env`:

```bash
cp .env.example .env
```

Lalu ubah konfigurasi database sesuai dengan env kamu:

```
DB_DATABASE=cp2b
DB_USERNAME=root
DB_PASSWORD=
```

### Generate Key

```bash
php artisan key:generate
```

### Migrasi dan Seeder

Untuk membuat tabel dan data contoh:

```bash
php artisan migrate:fresh --seed
```

Seeder akan otomatis membuat:

* 1 akun user:
  **Email:** `irawankillmer@gmail.com`
  **Password:** `admin123`
* 3 akun keuangan: `BCA`, `DANA`, `Cash`
* 12 kategori transaksi (pemasukan, pengeluaran, pindah)
* 100 transaksi acak realistis
* Saldo otomatis terupdate berdasarkan transaksi

---

## Menjalankan Aplikasi

Jalankan server lokal Laravel:

```bash
php artisan serve
```

Lalu buka browser dan akses:

```
http://localhost:8000
```

Masuk menggunakan akun default:

```
Email:    irawankillmer@gmail.com
Password: admin123
```

---

## Cara Update Sistem

Jika ada update (misalnya penambahan fitur atau perubahan struktur database):

1. **Tarik perubahan dari repository:**

   ```bash
   git pull origin main
   ```

2. **Update dependency:**

   ```bash
   composer install
   ```

3. **Jalankan migrasi ulang (jika ada perubahan database):**

   ```bash
   php artisan migrate
   ```

   atau, jika perlu seeding ulang:

   ```bash
   php artisan migrate:fresh --seed
   ```

---

## Cara Menggunakan Sistem

1. **Login** menggunakan akun Anda.
2. Masuk ke **Dashboard** untuk melihat ringkasan saldo dan grafik transaksi.
3. Pilih menu:

   * **Transaksi** → tambah, ubah, atau hapus transaksi.
   * **Akun** → atur rekening, dompet, atau saldo digital.
   * **Kategori** → kelola jenis pemasukan/pengeluaran.
   * **Laporan** → lihat detail berdasarkan tanggal, bulan, akun, atau kategori.
4. Klik bagian grafik pada Dashboard untuk menelusuri **detail per kategori atau akun**.

---

## Struktur Database Singkat

| Tabel          | Keterangan                                       |
| -------------- | ------------------------------------------------ |
| `users`        | Data pengguna sistem                             |
| `accounts`     | Akun keuangan seperti BCA, DANA, Cash            |
| `categories`   | Jenis transaksi (pemasukan, pengeluaran, pindah) |
| `transactions` | Catatan transaksi harian                         |
| `balances`     | Saldo terakhir setiap akun                       |

---

## Teknologi yang Digunakan

* [Laravel 10+](https://laravel.com/)
* [PHP 8.2+](https://www.php.net/)
* [MySQL](https://www.mysql.com/)
* [Bootstrap 5](https://getbootstrap.com/)
* [Chart.js](https://www.chartjs.org/)

---

## Catatan

Jika ingin mengisi data baru dari awal:

```bash
php artisan migrate:fresh --seed
```

Jika ingin menambah transaksi secara manual:

* Masuk ke halaman **Transaksi → Tambah Transaksi**
* Pilih akun, kategori, isi nominal, dan deskripsi
* Sistem otomatis menghitung saldo dan menampilkannya di Dashboard

---

