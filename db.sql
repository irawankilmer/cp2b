-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 28 Apr 2025 pada 08.14
-- Versi server: 10.11.11-MariaDB-cll-lve
-- Versi PHP: 8.3.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `n1582806_cp2b`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `accounts`
--

CREATE TABLE `accounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `descriptions` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `descriptions`, `created_at`, `updated_at`) VALUES
(1, 'BCA', 'Semua yang ada di rekening BCA', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(2, 'DANA', 'Semua yang ada di rekening DANA', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(3, 'Cash', 'Semua yang ada di Cash', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(4, 'Dompet AA', 'Yang Ada di dompet Aa', '2025-03-17 07:28:32', '2025-03-17 07:28:32'),
(5, 'Shopee Pay', 'Semu dana di shopee pay', '2025-04-26 10:44:38', '2025-04-26 10:44:38');

-- --------------------------------------------------------

--
-- Struktur dari tabel `balances`
--

CREATE TABLE `balances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `balance` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `balances`
--

INSERT INTO `balances` (`id`, `account_id`, `balance`, `created_at`, `updated_at`) VALUES
(1, 3, 275500.00, '2025-03-15 15:18:02', '2025-04-27 23:33:48'),
(2, 1, 351465.00, '2025-03-15 15:39:05', '2025-04-23 03:51:05'),
(3, 4, 98500.00, '2025-03-17 07:29:52', '2025-04-26 03:26:58'),
(4, 5, 63000.00, '2025-04-26 10:45:44', '2025-04-26 10:45:44');

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('pemasukan','pengeluaran','pindah') NOT NULL DEFAULT 'pengeluaran',
  `descriptions` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `categories`
--

INSERT INTO `categories` (`id`, `name`, `type`, `descriptions`, `created_at`, `updated_at`) VALUES
(1, 'Kebutuhan Rumah Tangga', 'pengeluaran', 'Semua keperluan seperti baju, alat elektornik dan barang - barang lainnya', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(2, 'Dapur', 'pengeluaran', 'Semua kebutuhan dapur termasuk alat - alatnya', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(3, 'Jajan Barudak', 'pengeluaran', 'Semua jajan barudak termasuk ibunya, kecuali jajan disekolah sekolah(Bekel sakola tidak termasuk)', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(4, 'Transfortasi', 'pengeluaran', 'Bensin dan biaya bepergian lainnya', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(5, 'Tagihan Bulanan', 'pengeluaran', 'Listrik, pulsa dan tagihan yang bersipat bulanan lainnya', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(6, 'Istri', 'pengeluaran', 'Semua pengeluaran istri, jajan dan lain sebagainya', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(7, 'Suami', 'pengeluaran', 'Semua pengeluaran termasuk rokok, kopi, makan diluarketika kerja dan pengeluaran - pengeluaran lainnya', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(8, 'Gaji', 'pemasukan', 'Pemasukan rutin yang tiap bulan atau gaji tetap', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(9, 'Luar Gaji', 'pemasukan', 'Pendapatan diluar gaji apapun itu', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(10, 'Pendidikan', 'pengeluaran', 'Biaya pendidikan anak - anak, termasuk pembayaran sekolah, uang jajan dan lain sebagainya', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(11, 'Pindah', 'pindah', 'Perpindahan uang dari cash ke debit atau sebaliknya', '2025-03-15 15:01:27', '2025-03-15 15:01:27'),
(12, 'Lainnya', 'pengeluaran', 'Segala pengeluaran yang tidak terduga', '2025-03-15 15:01:27', '2025-03-15 15:01:27');

-- --------------------------------------------------------

--
-- Struktur dari tabel `daily_reports`
--

CREATE TABLE `daily_reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `total_income` decimal(15,2) NOT NULL,
  `total_expense` decimal(15,2) NOT NULL,
  `net_balance` decimal(15,2) NOT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`details`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_03_19_125314_drop_column_from_transactions', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `monthly_reports`
--

CREATE TABLE `monthly_reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `month` varchar(255) NOT NULL,
  `year` year(4) NOT NULL,
  `total_income` decimal(15,2) NOT NULL,
  `total_expense` decimal(15,2) NOT NULL,
  `net_balance` decimal(15,2) NOT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`details`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('4fNgzPcQI6n4x4AHBfDpMUCHVRzx49ja5t7c61o9', 1, '114.122.84.203', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiZDBMM25NRDN0VFVmQm1LYUdOdGI1WjEzSkpTRDdJU2tScXg3N3c3QyI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM2OiJodHRwczovL2NwMmIua29yYW5nYXJ1dC5ibG9nL2FjY291bnQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1745640751),
('4R9DIfNJIECRr13K0apJ7CKjxdGggr0vi0KbGuyw', NULL, '64.233.173.69', 'Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRk11ajRLOWJhemNqakdCNXhkWFdNWWRWUVZmUGJGQ1NmS1dKUXFHYSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozODoiaHR0cHM6Ly9jcDJiLmtvcmFuZ2FydXQuYmxvZy90cmFuc2Frc2kiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozODoiaHR0cHM6Ly9jcDJiLmtvcmFuZ2FydXQuYmxvZy90cmFuc2Frc2kiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1745796800),
('AFwwwrE1lZorPIencT2V7MzspltAFl38pxvQurAt', NULL, '64.233.173.69', 'Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36 (compatible; Google-Read-Aloud; +https://support.google.com/webmasters/answer/1061943)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWUVENnp2bFJsOExMbmdYbEd0dEpBQTVmUkdLTTVKYlF4aWtGT0RFZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vY3AyYi5rb3JhbmdhcnV0LmJsb2cvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1745796800),
('dMYmzUxbZxlw2xZleqJ7qJVFbUqOcFT0Kfmob28s', NULL, '128.199.33.251', 'Mozilla/5.0 (compatible)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQmd5cmJ1dXFSU2loRWozZlNySlVWRDgxaTBTUkE0UDdFdDM2WmlBRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly93d3cuY3AyYi5rb3JhbmdhcnV0LmJsb2cvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1745661067),
('gRBcKHbljlVCiYOp3S5wIv2iUUj9AJCjxJcv3jSr', 1, '103.248.9.190', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiT2JxeHFrTlBQejZEc1Y1U2QwV0RQVkdFdllnMHpOVTI0SlBWT1JVdiI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyODoiaHR0cHM6Ly9jcDJiLmtvcmFuZ2FydXQuYmxvZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1745708357),
('O6jZFUtnd0bhj7rx3s1p7tM320Fc4W0BVltsLkJr', NULL, '128.199.33.251', 'Mozilla/5.0 (compatible)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMFpxMzRBUTd3aFNKVUpXV3hzYUtsTElzR3ZPU2ZSSng1TlBlRU1MUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHBzOi8vd3d3LmNwMmIua29yYW5nYXJ1dC5ibG9nL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1745661073),
('OrqZR0x46WQ3PHmQojyEXbWUb0cASANX21X2aRVy', NULL, '128.199.33.251', 'Mozilla/5.0 (compatible)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibUpaR29Db2l6OWpaMHEybTlWSzlZY2NtYU1vckhpZVg3NmVESE9ubCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMjoiaHR0cHM6Ly93d3cuY3AyYi5rb3JhbmdhcnV0LmJsb2ciO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMjoiaHR0cHM6Ly93d3cuY3AyYi5rb3JhbmdhcnV0LmJsb2ciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1745661069),
('UuooQ5T6i8zkdGaZqsWFmtvbQ7PXE1Id7uLh0y8I', 1, '103.248.9.190', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZnFNUlI4RzBnRlBSREI2NmJBNDJKdjlMRkRQYU9tS0xYV0lZU0RiVyI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyODoiaHR0cHM6Ly9jcDJiLmtvcmFuZ2FydXQuYmxvZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1745664786),
('wqR4YkHwu2hBRKIqO6kfjplAeAa7MLsBTjRREB9O', NULL, '128.199.33.251', 'Mozilla/5.0 (compatible)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiN3JNSjNPbHRmWXh6djVINzV5OE1abkFOMDlLMVRhd0JlSFVaMWxBayI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMToiaHR0cDovL3d3dy5jcDJiLmtvcmFuZ2FydXQuYmxvZyI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vd3d3LmNwMmIua29yYW5nYXJ1dC5ibG9nIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1745661066),
('xZD5yrdyh1mm2uQvqyTGRHuVzSiXPSSYldzXULw1', 1, '114.122.68.60', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiV3VLZk5TZXhWcUZyckRxMDVqbmJpWWtWZFh2TWJSc05jUE5pT3A3WSI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czo0NToiaHR0cHM6Ly9jcDJiLmtvcmFuZ2FydXQuYmxvZy90cmFuc2Frc2kvY3JlYXRlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1745796866);

-- --------------------------------------------------------

--
-- Struktur dari tabel `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `type` enum('pemasukan','pengeluaran','pindah') NOT NULL DEFAULT 'pengeluaran',
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `target_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `descriptions` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transactions`
--

INSERT INTO `transactions` (`id`, `date`, `type`, `account_id`, `category_id`, `target_account_id`, `amount`, `descriptions`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '2025-02-02', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 15:18:02', '2025-03-15 15:18:02'),
(2, '2025-02-06', 'pengeluaran', 3, 1, NULL, 500.00, 'Liquid', 1, '2025-03-15 15:19:51', '2025-03-15 15:19:51'),
(3, '2025-02-20', 'pengeluaran', 3, 10, NULL, 9000.00, 'Nabung Ghania dan Bekel', 1, '2025-03-15 15:20:35', '2025-03-15 15:20:35'),
(4, '2025-02-20', 'pengeluaran', 3, 7, NULL, 7000.00, 'Kopi Good Day 4', 1, '2025-03-15 15:21:39', '2025-03-15 15:21:39'),
(5, '2025-02-20', 'pengeluaran', 3, 7, NULL, 19000.00, 'Rokok', 1, '2025-03-15 15:22:06', '2025-03-15 15:22:06'),
(6, '2025-02-20', 'pengeluaran', 3, 3, NULL, 8000.00, 'Jajan Basreng Barudak', 1, '2025-03-15 15:22:41', '2025-03-15 15:22:41'),
(7, '2025-02-20', 'pengeluaran', 3, 2, NULL, 13000.00, '1 Telur, Soklin, shampo, rencang sangu', 1, '2025-03-15 15:24:20', '2025-03-15 15:24:20'),
(8, '2025-02-20', 'pemasukan', 3, 8, NULL, 1670000.00, 'Honorium Sekolah', 1, '2025-03-15 15:25:05', '2025-03-15 15:25:05'),
(9, '2025-02-21', 'pengeluaran', 3, 1, NULL, 6000.00, 'Liquid, Downi, Mie Goreng', 1, '2025-03-15 15:31:07', '2025-03-15 15:31:07'),
(10, '2025-02-21', 'pengeluaran', 3, 2, NULL, 430000.00, 'Tabung Gas, Beras 10kg, minyak 4L, kerupuk udang 1kg, royko 220grm', 1, '2025-03-15 15:33:12', '2025-03-15 15:33:12'),
(11, '2025-02-21', 'pengeluaran', 3, 2, NULL, 11000.00, 'Rencang Sangu', 1, '2025-03-15 15:34:06', '2025-03-15 15:34:06'),
(12, '2025-02-21', 'pengeluaran', 3, 1, NULL, 28000.00, 'Potong rambut Aa dan Albi', 1, '2025-03-15 15:35:47', '2025-03-15 15:35:47'),
(13, '2025-02-21', 'pengeluaran', 3, 7, NULL, 15000.00, 'Rokok sampoerna kretek 1', 1, '2025-03-15 15:36:37', '2025-03-15 15:36:37'),
(14, '2025-02-21', 'pengeluaran', 3, 10, NULL, 8000.00, 'Bekel Ghania + Nabung', 1, '2025-03-15 15:37:41', '2025-03-15 15:37:41'),
(15, '2025-02-21', 'pengeluaran', 3, 3, NULL, 19500.00, 'Jajan barudak', 1, '2025-03-15 15:38:13', '2025-03-15 15:38:13'),
(16, '2025-02-21', 'pengeluaran', 1, 5, NULL, 14000.00, 'Biaya Administrasi Bank BCA', 1, '2025-03-15 15:39:05', '2025-03-15 15:39:05'),
(17, '2025-02-22', 'pengeluaran', 3, 7, NULL, 4000.00, 'Kopi Good Day 2', 1, '2025-03-15 15:39:37', '2025-03-15 15:39:37'),
(18, '2025-02-22', 'pengeluaran', 3, 7, NULL, 71000.00, 'Udunan makan dosen pas sidang skripsi', 1, '2025-03-15 15:40:25', '2025-03-15 15:40:25'),
(19, '2025-02-22', 'pengeluaran', 3, 2, NULL, 20500.00, 'Hayam satengah dan liquid', 1, '2025-03-15 15:41:26', '2025-03-15 15:41:26'),
(20, '2025-02-22', 'pengeluaran', 3, 3, NULL, 17500.00, 'Jajan Barudak', 1, '2025-03-15 15:42:15', '2025-03-15 15:42:15'),
(21, '2025-02-23', 'pengeluaran', 3, 2, NULL, 23000.00, 'Rencang Sangu', 1, '2025-03-15 15:43:02', '2025-03-15 15:43:02'),
(22, '2025-02-23', 'pengeluaran', 3, 3, NULL, 20000.00, 'Jajan Barudak', 1, '2025-03-15 15:43:53', '2025-03-15 15:43:53'),
(23, '2025-02-24', 'pengeluaran', 3, 1, NULL, 1500.00, 'Mama lemon', 1, '2025-03-15 15:44:35', '2025-03-15 15:44:35'),
(24, '2025-02-24', 'pengeluaran', 3, 2, NULL, 2000.00, 'kecap', 1, '2025-03-15 15:45:18', '2025-03-15 15:45:18'),
(25, '2025-02-24', 'pengeluaran', 3, 7, NULL, 9500.00, 'Roko satengah', 1, '2025-03-15 15:45:49', '2025-03-15 15:45:49'),
(26, '2025-02-24', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 15:46:18', '2025-03-15 15:46:18'),
(27, '2025-02-24', 'pengeluaran', 3, 10, NULL, 5000.00, 'Nabung', 1, '2025-03-15 15:46:44', '2025-03-15 15:46:44'),
(28, '2025-02-24', 'pengeluaran', 3, 10, NULL, 5000.00, 'bekel', 1, '2025-03-15 15:48:33', '2025-03-15 15:48:33'),
(29, '2025-02-24', 'pengeluaran', 3, 10, NULL, 20000.00, 'Iyuran SPP Ghania', 1, '2025-03-15 15:49:16', '2025-03-15 15:49:16'),
(30, '2025-02-24', 'pengeluaran', 3, 3, NULL, 2000.00, 'Cilung', 1, '2025-03-15 15:49:47', '2025-03-15 15:49:47'),
(31, '2025-02-24', 'pengeluaran', 3, 3, NULL, 5000.00, 'Rania dan Albi', 1, '2025-03-15 15:50:18', '2025-03-15 15:50:18'),
(32, '2025-02-24', 'pengeluaran', 3, 10, NULL, 2000.00, 'Uang kas ngaos teteh Ghania', 1, '2025-03-15 15:51:09', '2025-03-15 15:51:09'),
(33, '2025-02-24', 'pengeluaran', 3, 1, NULL, 4000.00, 'Voucher wifi 1 hari', 1, '2025-03-15 15:51:45', '2025-03-15 15:51:45'),
(34, '2025-02-24', 'pengeluaran', 3, 2, NULL, 5000.00, 'Telur 2', 1, '2025-03-15 15:52:22', '2025-03-15 15:52:22'),
(35, '2025-02-24', 'pengeluaran', 3, 2, NULL, 1000.00, 'Bawang Merah dan Putih', 1, '2025-03-15 15:52:48', '2025-03-15 15:52:48'),
(36, '2025-02-24', 'pengeluaran', 3, 2, NULL, 2000.00, 'Cikur, Ladaku dan cengek', 1, '2025-03-15 15:53:30', '2025-03-15 15:53:30'),
(37, '2025-02-24', 'pengeluaran', 3, 1, NULL, 500.00, 'Liquid', 1, '2025-03-15 15:53:55', '2025-03-15 15:53:55'),
(38, '2025-02-24', 'pengeluaran', 3, 3, NULL, 2500.00, 'Jajan Barudak', 1, '2025-03-15 15:54:21', '2025-03-15 15:54:21'),
(39, '2025-02-24', 'pengeluaran', 3, 1, NULL, 44000.00, 'Lampu Philli[ 8watt', 1, '2025-03-15 15:54:53', '2025-03-15 15:54:53'),
(40, '2025-02-24', 'pengeluaran', 3, 12, NULL, 2000.00, 'Parkir', 1, '2025-03-15 15:55:19', '2025-03-15 15:55:19'),
(41, '2025-02-24', 'pengeluaran', 3, 7, NULL, 34500.00, 'roko, kopi, korek dan roti pas penjajakan pkl', 1, '2025-03-15 15:56:26', '2025-03-15 15:56:26'),
(42, '2025-02-24', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 15:56:52', '2025-03-15 15:56:52'),
(43, '2025-02-25', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 15:57:16', '2025-03-15 15:57:16'),
(44, '2025-02-25', 'pengeluaran', 3, 1, NULL, 500.00, 'Shampo', 1, '2025-03-15 15:57:49', '2025-03-15 15:57:49'),
(45, '2025-02-25', 'pengeluaran', 3, 2, NULL, 2000.00, 'Telur', 1, '2025-03-15 15:58:13', '2025-03-15 15:58:13'),
(46, '2025-02-25', 'pengeluaran', 3, 3, NULL, 500.00, 'Jajan Albi', 1, '2025-03-15 15:59:47', '2025-03-15 15:59:47'),
(47, '2025-02-25', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 16:00:20', '2025-03-15 16:00:20'),
(48, '2025-02-25', 'pengeluaran', 3, 10, NULL, 4000.00, 'bekel ghania', 1, '2025-03-15 16:00:52', '2025-03-15 16:00:52'),
(49, '2025-02-25', 'pengeluaran', 3, 3, NULL, 4000.00, 'Jajan Barudak', 1, '2025-03-15 16:01:22', '2025-03-15 16:01:22'),
(50, '2025-02-25', 'pengeluaran', 3, 1, NULL, 2500.00, 'Pampers', 1, '2025-03-15 16:02:02', '2025-03-15 16:02:02'),
(51, '2025-02-25', 'pengeluaran', 3, 1, NULL, 6000.00, 'Pasta gigi anak', 1, '2025-03-15 16:02:40', '2025-03-15 16:02:40'),
(52, '2025-02-25', 'pengeluaran', 3, 2, NULL, 8000.00, 'Kecap botol', 1, '2025-03-15 16:03:09', '2025-03-15 16:03:09'),
(53, '2025-02-25', 'pengeluaran', 3, 1, NULL, 5500.00, 'Shampo rantuy 24 pcs', 1, '2025-03-15 16:03:55', '2025-03-15 16:03:55'),
(54, '2025-02-25', 'pengeluaran', 3, 2, NULL, 5000.00, 'Bawang merah 1 ons', 1, '2025-03-15 16:04:26', '2025-03-15 16:04:26'),
(55, '2025-02-25', 'pengeluaran', 3, 2, NULL, 4500.00, 'bawang putih 1 ons', 1, '2025-03-15 16:04:57', '2025-03-15 16:04:57'),
(56, '2025-02-25', 'pengeluaran', 3, 1, NULL, 6000.00, 'Ongkos puskesmas', 1, '2025-03-15 16:05:28', '2025-03-15 16:05:28'),
(57, '2025-02-25', 'pengeluaran', 3, 12, NULL, 4000.00, 'Buruh eva', 1, '2025-03-15 16:05:56', '2025-03-15 16:05:56'),
(58, '2025-02-25', 'pengeluaran', 3, 12, NULL, 2000.00, 'fotocopy', 1, '2025-03-15 16:06:21', '2025-03-15 16:06:21'),
(59, '2025-02-25', 'pengeluaran', 3, 3, NULL, 2000.00, 'Jajan Barudak', 1, '2025-03-15 16:06:52', '2025-03-15 16:06:52'),
(60, '2025-02-25', 'pengeluaran', 3, 2, NULL, 14000.00, 'Rencang Sangu', 1, '2025-03-15 16:07:16', '2025-03-15 16:07:16'),
(61, '2025-02-25', 'pengeluaran', 3, 3, NULL, 4000.00, 'Jajan Barudak', 1, '2025-03-15 16:07:41', '2025-03-15 16:07:41'),
(62, '2025-02-25', 'pengeluaran', 3, 2, NULL, 4000.00, 'telur, jajan dan gorangan asin', 1, '2025-03-15 16:08:24', '2025-03-15 16:08:24'),
(63, '2025-02-25', 'pengeluaran', 3, 7, NULL, 11500.00, 'kopi rokok', 1, '2025-03-15 16:08:54', '2025-03-15 16:08:54'),
(64, '2025-02-25', 'pengeluaran', 3, 3, NULL, 4000.00, 'Jajan Barudak', 1, '2025-03-15 16:09:33', '2025-03-15 16:09:33'),
(65, '2025-02-25', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 16:10:05', '2025-03-15 16:10:05'),
(66, '2025-02-25', 'pengeluaran', 3, 6, NULL, 2000.00, 'Softex', 1, '2025-03-15 16:10:29', '2025-03-15 16:10:29'),
(67, '2025-02-26', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 16:11:16', '2025-03-15 16:11:16'),
(68, '2025-02-26', 'pengeluaran', 3, 2, NULL, 2500.00, 'Telur', 1, '2025-03-15 16:11:39', '2025-03-15 16:11:39'),
(69, '2025-02-26', 'pengeluaran', 3, 2, NULL, 2000.00, 'Susu', 1, '2025-03-15 16:12:10', '2025-03-15 16:12:10'),
(70, '2025-02-26', 'pengeluaran', 3, 1, NULL, 7000.00, 'pasta gigi plus ghania', 1, '2025-03-15 16:12:37', '2025-03-15 16:12:37'),
(71, '2025-02-26', 'pengeluaran', 3, 6, NULL, 2500.00, 'Jajan teteh', 1, '2025-03-15 16:13:07', '2025-03-15 16:13:07'),
(72, '2025-02-26', 'pengeluaran', 1, 6, NULL, 10000.00, 'Papasakan', 1, '2025-03-15 16:13:54', '2025-03-15 16:13:54'),
(73, '2025-02-26', 'pengeluaran', 3, 10, NULL, 3000.00, 'bekel ghania', 1, '2025-03-15 16:14:17', '2025-03-15 16:14:17'),
(74, '2025-02-26', 'pengeluaran', 3, 6, NULL, 2000.00, 'Jajan teteh', 1, '2025-03-15 16:14:39', '2025-03-15 16:14:39'),
(75, '2025-02-26', 'pengeluaran', 3, 3, NULL, 4000.00, 'Jajan Barudak', 1, '2025-03-15 16:15:04', '2025-03-15 16:15:04'),
(76, '2025-02-26', 'pengeluaran', 3, 2, NULL, 9500.00, 'Rencang Sangu', 1, '2025-03-15 16:15:25', '2025-03-15 16:15:25'),
(77, '2025-02-26', 'pengeluaran', 3, 3, NULL, 6000.00, 'Jajan Barudak', 1, '2025-03-15 16:15:47', '2025-03-15 16:15:47'),
(78, '2025-02-26', 'pengeluaran', 3, 3, NULL, 3000.00, 'Jajan Barudak', 1, '2025-03-15 16:16:12', '2025-03-15 16:16:12'),
(79, '2025-02-26', 'pengeluaran', 3, 7, NULL, 32000.00, 'kopi rokok', 1, '2025-03-15 16:16:43', '2025-03-15 16:16:43'),
(80, '2025-02-26', 'pengeluaran', 3, 4, NULL, 30000.00, 'Bensin', 1, '2025-03-15 16:17:09', '2025-03-15 16:17:09'),
(81, '2025-02-26', 'pengeluaran', 3, 4, NULL, 43000.00, 'Rem motor', 1, '2025-03-15 16:17:32', '2025-03-15 16:17:32'),
(82, '2025-02-27', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 16:18:06', '2025-03-15 16:18:06'),
(83, '2025-02-27', 'pengeluaran', 3, 3, NULL, 6000.00, 'Jajan Barudak', 1, '2025-03-15 16:18:29', '2025-03-15 16:18:29'),
(84, '2025-02-27', 'pengeluaran', 3, 2, NULL, 70000.00, 'Daging Sapi', 1, '2025-03-15 16:18:55', '2025-03-15 16:18:55'),
(85, '2025-02-27', 'pengeluaran', 3, 2, NULL, 26000.00, 'Samara plus jajan', 1, '2025-03-15 16:19:24', '2025-03-15 16:19:24'),
(86, '2025-02-27', 'pengeluaran', 3, 3, NULL, 5000.00, 'Jajan Barudak', 1, '2025-03-15 16:19:43', '2025-03-15 16:19:43'),
(87, '2025-02-27', 'pengeluaran', 3, 7, NULL, 38000.00, 'kopi rokok', 1, '2025-03-15 16:20:08', '2025-03-15 16:20:08'),
(88, '2025-02-27', 'pengeluaran', 3, 3, NULL, 1000.00, 'Albi', 1, '2025-03-15 16:20:40', '2025-03-15 16:20:40'),
(89, '2025-02-28', 'pengeluaran', 3, 3, NULL, 3000.00, 'Susu + roti', 1, '2025-03-15 16:21:13', '2025-03-15 16:21:13'),
(90, '2025-02-28', 'pengeluaran', 3, 2, NULL, 24000.00, 'bawang merah, suuk 4, tempe 3, kalapa', 1, '2025-03-15 16:23:37', '2025-03-15 16:23:37'),
(91, '2025-02-28', 'pengeluaran', 3, 1, NULL, 1000.00, 'Liquid', 1, '2025-03-15 16:25:30', '2025-03-15 16:25:30'),
(92, '2025-02-28', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 16:27:27', '2025-03-15 16:27:27'),
(93, '2025-02-28', 'pengeluaran', 3, 1, NULL, 57000.00, 'Haslin dan Pembersih', 1, '2025-03-15 16:28:01', '2025-03-15 16:28:01'),
(94, '2025-02-28', 'pengeluaran', 3, 12, NULL, 40000.00, 'Jajan Bakso', 1, '2025-03-15 16:28:29', '2025-03-15 16:28:29'),
(95, '2025-02-28', 'pengeluaran', 3, 7, NULL, 11000.00, 'kopi rokok', 1, '2025-03-15 16:28:52', '2025-03-15 16:28:52'),
(96, '2025-02-28', 'pengeluaran', 3, 7, NULL, 4000.00, 'Basreng dan kopi', 1, '2025-03-15 16:29:19', '2025-03-15 16:29:19'),
(97, '2025-03-01', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 16:29:57', '2025-03-15 16:29:57'),
(98, '2025-03-01', 'pengeluaran', 3, 1, NULL, 2000.00, 'Mama lemon', 1, '2025-03-15 16:30:23', '2025-03-15 16:30:23'),
(99, '2025-03-01', 'pengeluaran', 3, 1, NULL, 1000.00, 'Liquid', 1, '2025-03-15 16:30:43', '2025-03-15 16:30:43'),
(100, '2025-03-01', 'pengeluaran', 3, 6, NULL, 3000.00, 'bakso', 1, '2025-03-15 16:31:09', '2025-03-15 16:31:09'),
(101, '2025-03-01', 'pengeluaran', 3, 3, NULL, 2000.00, 'Jajan Barudak', 1, '2025-03-15 16:31:28', '2025-03-15 16:31:28'),
(102, '2025-03-01', 'pengeluaran', 3, 2, NULL, 17000.00, 'Ciken', 1, '2025-03-15 16:31:56', '2025-03-15 16:31:56'),
(103, '2025-03-01', 'pengeluaran', 3, 3, NULL, 4000.00, 'Jajan Barudak', 1, '2025-03-15 16:32:20', '2025-03-15 16:32:20'),
(104, '2025-03-01', 'pengeluaran', 3, 1, NULL, 2500.00, 'pempers', 1, '2025-03-15 16:32:49', '2025-03-15 16:32:49'),
(105, '2025-03-01', 'pengeluaran', 3, 7, NULL, 2500.00, 'Kopi Good Day 1', 1, '2025-03-15 16:33:09', '2025-03-15 16:33:09'),
(106, '2025-03-02', 'pengeluaran', 3, 2, NULL, 20000.00, 'kurupuk 1kg', 1, '2025-03-15 16:33:36', '2025-03-15 16:33:36'),
(107, '2025-03-02', 'pengeluaran', 3, 1, NULL, 2000.00, 'sabun colek + shampo', 1, '2025-03-15 16:34:05', '2025-03-15 16:34:05'),
(108, '2025-03-02', 'pengeluaran', 3, 2, NULL, 3000.00, 'Santan cikur cengek', 1, '2025-03-15 16:35:05', '2025-03-15 16:35:05'),
(109, '2025-03-02', 'pengeluaran', 3, 2, NULL, 2000.00, 'cipuk', 1, '2025-03-15 16:35:27', '2025-03-15 16:35:27'),
(110, '2025-03-02', 'pengeluaran', 3, 7, NULL, 11000.00, 'kopi rokok', 1, '2025-03-15 16:35:46', '2025-03-15 16:35:46'),
(111, '2025-03-03', 'pengeluaran', 3, 1, NULL, 3000.00, 'Shampo', 1, '2025-03-15 16:36:40', '2025-03-15 16:36:40'),
(112, '2025-03-03', 'pengeluaran', 3, 2, NULL, 6000.00, 'cireng cimol', 1, '2025-03-15 16:37:05', '2025-03-15 16:37:05'),
(113, '2025-03-03', 'pengeluaran', 3, 3, NULL, 2000.00, 'rania', 1, '2025-03-15 16:37:25', '2025-03-15 16:37:25'),
(114, '2025-03-03', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 16:38:04', '2025-03-15 16:38:04'),
(115, '2025-03-04', 'pengeluaran', 3, 5, NULL, 50000.00, 'Pulsa/kuota', 1, '2025-03-15 16:38:37', '2025-03-15 16:38:37'),
(116, '2025-03-04', 'pengeluaran', 3, 2, NULL, 8500.00, 'Mie+Telur', 1, '2025-03-15 16:39:16', '2025-03-15 16:39:16'),
(117, '2025-03-04', 'pengeluaran', 3, 1, NULL, 1000.00, 'Shampo', 1, '2025-03-15 16:39:47', '2025-03-15 16:39:47'),
(118, '2025-03-04', 'pengeluaran', 3, 6, NULL, 1000.00, 'Softex 2', 1, '2025-03-15 16:40:13', '2025-03-15 16:40:13'),
(119, '2025-03-04', 'pengeluaran', 3, 2, NULL, 17000.00, 'Daging setengah', 1, '2025-03-15 16:40:44', '2025-03-15 16:40:44'),
(120, '2025-03-04', 'pengeluaran', 3, 2, NULL, 7500.00, 'cireng, cipuk, muncang dan koneng', 1, '2025-03-15 16:41:27', '2025-03-15 16:41:27'),
(121, '2025-03-04', 'pengeluaran', 3, 3, 3, 6000.00, 'Jajan Barudak', 1, '2025-03-15 16:42:29', '2025-03-15 16:42:29'),
(122, '2025-03-04', 'pengeluaran', 3, 7, NULL, 12000.00, 'kopi rokok', 1, '2025-03-15 16:42:53', '2025-03-15 16:42:53'),
(123, '2025-03-05', 'pengeluaran', 3, 2, NULL, 6000.00, 'susu cipuk buka puasa', 1, '2025-03-15 16:44:07', '2025-03-15 16:44:07'),
(124, '2025-03-05', 'pengeluaran', 3, 10, NULL, 2000.00, 'Uang kas', 1, '2025-03-15 16:44:33', '2025-03-15 16:44:33'),
(125, '2025-03-06', 'pengeluaran', 3, 2, NULL, 6000.00, 'Mie+Telur', 1, '2025-03-15 16:45:08', '2025-03-15 16:45:08'),
(126, '2025-03-05', 'pengeluaran', 3, 7, 3, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 16:45:53', '2025-03-15 16:45:53'),
(127, '2025-03-05', 'pemasukan', 3, 9, NULL, 174500.00, 'Pemasangan spanduk', 1, '2025-03-15 16:46:28', '2025-03-15 16:46:28'),
(128, '2025-03-05', 'pemasukan', 1, 9, NULL, 4562.00, 'Saldo BCA', 1, '2025-03-15 16:48:46', '2025-03-15 16:48:46'),
(129, '2025-03-06', 'pengeluaran', 3, 1, NULL, 2000.00, 'Mama lemon', 1, '2025-03-15 16:49:27', '2025-03-15 16:49:27'),
(130, '2025-03-06', 'pengeluaran', 3, 2, NULL, 3000.00, 'cireng cengek', 1, '2025-03-15 16:50:04', '2025-03-15 16:50:04'),
(131, '2025-03-06', 'pemasukan', 3, 9, NULL, 150000.00, 'Pemasangan spanduk', 1, '2025-03-15 16:50:33', '2025-03-15 16:50:33'),
(132, '2025-03-06', 'pengeluaran', 3, 7, NULL, 30000.00, 'Rokok 2', 1, '2025-03-15 16:51:09', '2025-03-15 16:51:09'),
(133, '2025-03-06', 'pengeluaran', 3, 2, NULL, 1000.00, 'Liquid 2', 1, '2025-03-15 16:51:35', '2025-03-15 16:51:35'),
(134, '2025-03-06', 'pengeluaran', 3, 3, NULL, 4000.00, 'Jajan Barudak', 1, '2025-03-15 16:51:54', '2025-03-15 16:51:54'),
(135, '2025-03-06', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 16:52:19', '2025-03-15 16:52:19'),
(136, '2025-03-07', 'pengeluaran', 3, 6, NULL, 2000.00, 'susu', 1, '2025-03-15 16:52:41', '2025-03-15 16:52:41'),
(137, '2025-03-07', 'pengeluaran', 3, 2, NULL, 8500.00, 'tempe cireng telur 1', 1, '2025-03-15 16:54:30', '2025-03-15 16:54:30'),
(138, '2025-03-07', 'pengeluaran', 3, 1, NULL, 1500.00, 'shampo dan soklin lantai', 1, '2025-03-15 16:54:56', '2025-03-15 16:54:56'),
(139, '2025-03-07', 'pengeluaran', 3, 3, NULL, 2000.00, 'Albi', 1, '2025-03-15 16:55:22', '2025-03-15 16:55:22'),
(140, '2025-03-07', 'pengeluaran', 3, 1, NULL, 1000.00, 'sabun colek', 1, '2025-03-15 16:55:45', '2025-03-15 16:55:45'),
(141, '2025-03-07', 'pengeluaran', 3, 3, NULL, 4000.00, 'Jajan Barudak', 1, '2025-03-15 16:56:08', '2025-03-15 16:56:08'),
(142, '2025-03-07', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 16:57:02', '2025-03-15 16:57:02'),
(143, '2025-03-08', 'pengeluaran', 3, 7, NULL, 500.00, 'teh sisri', 1, '2025-03-15 16:57:27', '2025-03-15 16:57:27'),
(144, '2025-03-08', 'pengeluaran', 3, 3, NULL, 2500.00, 'Jajan Barudak', 1, '2025-03-15 16:57:47', '2025-03-15 16:57:47'),
(145, '2025-03-08', 'pengeluaran', 3, 2, NULL, 10000.00, 'jebred tempe cipuk', 1, '2025-03-15 16:58:47', '2025-03-15 16:58:47'),
(146, '2025-03-08', 'pengeluaran', 3, 3, NULL, 6000.00, 'Jajan Barudak', 1, '2025-03-15 16:59:10', '2025-03-15 16:59:10'),
(147, '2025-03-08', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 16:59:39', '2025-03-15 16:59:39'),
(148, '2025-03-08', 'pengeluaran', 3, 2, NULL, 2000.00, 'tahu balut', 1, '2025-03-15 17:00:03', '2025-03-15 17:00:03'),
(149, '2025-03-09', 'pengeluaran', 3, 7, NULL, 1000.00, 'Bajigur', 1, '2025-03-15 17:00:37', '2025-03-15 17:00:37'),
(150, '2025-03-09', 'pengeluaran', 3, 3, NULL, 3000.00, 'Jajan Barudak', 1, '2025-03-15 17:00:57', '2025-03-15 17:00:57'),
(151, '2025-03-09', 'pengeluaran', 3, 2, NULL, 13000.00, 'sayur cengek', 1, '2025-03-15 17:01:34', '2025-03-15 17:01:34'),
(152, '2025-03-09', 'pengeluaran', 3, 3, NULL, 1000.00, 'Jajan Barudak', 1, '2025-03-15 17:02:56', '2025-03-15 17:02:56'),
(153, '2025-03-09', 'pengeluaran', 3, 1, NULL, 500.00, 'Shampo', 1, '2025-03-15 17:04:10', '2025-03-15 17:04:10'),
(154, '2025-03-09', 'pengeluaran', 3, 4, NULL, 30000.00, 'isi bensin', 1, '2025-03-15 17:04:37', '2025-03-15 17:04:37'),
(155, '2025-03-09', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 17:05:06', '2025-03-15 17:05:06'),
(156, '2025-03-10', 'pengeluaran', 3, 10, NULL, 5000.00, 'Nabung', 1, '2025-03-15 17:07:00', '2025-03-15 17:07:00'),
(157, '2025-03-10', 'pengeluaran', 3, 2, NULL, 5000.00, 'Goreangan', 1, '2025-03-15 17:07:24', '2025-03-15 17:07:24'),
(158, '2025-03-10', 'pengeluaran', 3, 1, NULL, 4000.00, 'Shampo, Liquid 2 dan Pempers', 1, '2025-03-15 17:08:12', '2025-03-15 17:08:12'),
(159, '2025-03-10', 'pengeluaran', 3, 3, NULL, 3000.00, 'Jajan Barudak', 1, '2025-03-15 17:08:37', '2025-03-15 17:08:37'),
(160, '2025-03-11', 'pengeluaran', 3, 1, NULL, 2000.00, 'pewangi shampo', 1, '2025-03-15 17:11:22', '2025-03-15 17:11:22'),
(161, '2025-03-11', 'pengeluaran', 3, 10, NULL, 5000.00, 'Nabung', 1, '2025-03-15 17:11:45', '2025-03-15 17:11:45'),
(162, '2025-03-11', 'pengeluaran', 3, 3, NULL, 6000.00, 'Jajan Barudak', 1, '2025-03-15 17:12:06', '2025-03-15 17:12:06'),
(163, '2025-03-11', 'pengeluaran', 3, 10, NULL, 3500.00, 'Buku', 1, '2025-03-15 17:12:46', '2025-03-15 17:12:46'),
(164, '2025-03-11', 'pengeluaran', 3, 12, NULL, 4000.00, 'infaq pos yandu', 1, '2025-03-15 17:13:14', '2025-03-15 17:13:14'),
(165, '2025-03-11', 'pengeluaran', 3, 2, NULL, 8500.00, 'Telur 2  dan mie', 1, '2025-03-15 17:14:36', '2025-03-15 17:14:36'),
(166, '2025-03-11', 'pengeluaran', 3, 3, NULL, 5000.00, 'Jajan Barudak', 1, '2025-03-15 17:14:54', '2025-03-15 17:14:54'),
(167, '2025-03-11', 'pengeluaran', 3, 2, NULL, 3000.00, 'Goreangan', 1, '2025-03-15 17:15:19', '2025-03-15 17:15:19'),
(168, '2025-03-11', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 17:15:39', '2025-03-15 17:15:39'),
(169, '2025-03-11', 'pengeluaran', 3, 6, NULL, 5000.00, 'bakso ikan', 1, '2025-03-15 17:16:04', '2025-03-15 17:16:04'),
(170, '2025-03-12', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-15 17:16:22', '2025-03-15 17:16:22'),
(171, '2025-03-12', 'pengeluaran', 3, 2, NULL, 7500.00, 'Telur 3', 1, '2025-03-15 17:16:50', '2025-03-15 17:16:50'),
(172, '2025-03-12', 'pengeluaran', 3, 10, NULL, 5000.00, 'Nabung', 1, '2025-03-15 17:17:46', '2025-03-15 17:17:46'),
(173, '2025-03-12', 'pengeluaran', 3, 2, NULL, 3000.00, 'cireng cimol', 1, '2025-03-15 17:18:17', '2025-03-15 17:18:17'),
(174, '2025-03-12', 'pengeluaran', 3, 2, NULL, 11000.00, 'Rencang Sangu', 1, '2025-03-15 17:18:49', '2025-03-15 17:18:49'),
(175, '2025-03-12', 'pengeluaran', 3, 1, NULL, 2000.00, 'Mama lemon', 1, '2025-03-15 17:19:21', '2025-03-15 17:19:21'),
(176, '2025-03-12', 'pengeluaran', 3, 3, NULL, 7000.00, 'Jajan Barudak', 1, '2025-03-15 17:19:42', '2025-03-15 17:19:42'),
(177, '2025-03-13', 'pengeluaran', 3, 7, NULL, 500.00, 'teh sisri', 1, '2025-03-15 17:21:26', '2025-03-15 17:21:26'),
(178, '2025-03-13', 'pengeluaran', 3, 3, NULL, 4500.00, 'Jajan Barudak', 1, '2025-03-15 17:21:46', '2025-03-15 17:21:46'),
(179, '2025-03-13', 'pengeluaran', 3, 1, NULL, 3000.00, 'sabun colek + shampo', 1, '2025-03-15 17:22:27', '2025-03-15 17:22:27'),
(180, '2025-03-13', 'pengeluaran', 3, 2, NULL, 12500.00, 'cipuk telur sinti', 1, '2025-03-15 17:23:09', '2025-03-15 17:23:09'),
(181, '2025-03-13', 'pengeluaran', 3, 3, NULL, 2500.00, 'Jajan Barudak', 1, '2025-03-15 17:23:51', '2025-03-15 17:23:51'),
(182, '2025-03-13', 'pengeluaran', 3, 2, NULL, 2000.00, 'suuk cengek', 1, '2025-03-15 17:24:20', '2025-03-15 17:24:20'),
(183, '2025-03-14', 'pengeluaran', 3, 7, NULL, 13500.00, 'kopi rokok', 1, '2025-03-15 17:24:43', '2025-03-15 17:24:43'),
(184, '2025-03-14', 'pengeluaran', 3, 2, NULL, 3500.00, 'mie', 1, '2025-03-15 17:26:07', '2025-03-15 17:26:07'),
(185, '2025-03-14', 'pengeluaran', 3, 2, NULL, 19000.00, 'daging setengah dan bahan', 1, '2025-03-15 17:27:05', '2025-03-15 17:27:05'),
(186, '2025-03-14', 'pemasukan', 3, 9, NULL, 650000.00, 'Honorium USBK', 1, '2025-03-15 17:27:57', '2025-03-15 17:27:57'),
(187, '2025-03-14', 'pengeluaran', 3, 1, 3, 516000.00, 'Acuk albi, ghania dan parkir', 1, '2025-03-15 17:28:57', '2025-03-15 17:28:57'),
(188, '2025-03-14', 'pengeluaran', 3, 2, NULL, 4000.00, 'tahu balut', 1, '2025-03-15 17:29:45', '2025-03-15 17:29:45'),
(189, '2025-03-14', 'pengeluaran', 3, 7, NULL, 11500.00, 'kopi rokok', 1, '2025-03-15 17:30:09', '2025-03-15 17:30:09'),
(190, '2025-03-14', 'pengeluaran', 3, 3, NULL, 6500.00, 'Jajan Barudak', 1, '2025-03-15 17:30:41', '2025-03-15 17:30:41'),
(191, '2025-03-15', 'pengeluaran', 3, 6, NULL, 2000.00, 'susu', 1, '2025-03-15 17:31:28', '2025-03-15 17:31:28'),
(192, '2025-03-15', 'pengeluaran', 3, 1, NULL, 4000.00, 'Shampo, Liquid 2 dan sabun colek', 1, '2025-03-15 17:33:04', '2025-03-15 17:33:04'),
(193, '2025-03-15', 'pengeluaran', 3, 2, NULL, 8000.00, 'tempe cireng', 1, '2025-03-15 17:33:33', '2025-03-15 17:33:33'),
(194, '2025-03-15', 'pemasukan', 3, 9, NULL, 100000.00, 'Pemasangan spanduk', 1, '2025-03-15 17:34:28', '2025-03-15 17:34:28'),
(195, '2025-03-15', 'pengeluaran', 3, 3, NULL, 2000.00, 'Jajan Barudak', 1, '2025-03-15 17:34:47', '2025-03-15 17:34:47'),
(196, '2025-03-15', 'pengeluaran', 3, 2, NULL, 7000.00, 'telur 2 gula boda dan tomat', 1, '2025-03-15 17:35:25', '2025-03-15 17:35:25'),
(197, '2025-03-15', 'pengeluaran', 3, 4, NULL, 30000.00, 'Bensin', 1, '2025-03-15 17:35:58', '2025-03-15 17:35:58'),
(198, '2025-03-15', 'pengeluaran', 3, 7, NULL, 32000.00, 'rokok 2 kopi 1', 1, '2025-03-15 17:36:26', '2025-03-15 17:36:26'),
(199, '2025-02-23', 'pengeluaran', 3, 7, NULL, 8000.00, 'Kopi Good Day 4', 1, '2025-03-15 17:37:13', '2025-03-15 17:37:13'),
(200, '2025-02-20', 'pemasukan', 1, 9, NULL, 14876.00, 'Balancing Saldo BCA', 1, '2025-03-15 17:40:33', '2025-03-15 17:40:33'),
(201, '2025-02-22', 'pemasukan', 1, 9, NULL, 9124.00, 'Balancing Saldo BCA', 1, '2025-03-15 17:43:03', '2025-03-15 17:43:03'),
(204, '2025-03-16', 'pemasukan', 3, 9, NULL, 117000.00, 'Tabungan ti teh wina', 1, '2025-03-15 20:11:41', '2025-03-15 20:11:41'),
(205, '2025-03-16', 'pengeluaran', 3, 3, NULL, 1000.00, 'Jajan albi', 1, '2025-03-15 20:13:16', '2025-03-15 20:13:16'),
(206, '2025-03-16', 'pengeluaran', 3, 7, NULL, 3000.00, 'Roti', 1, '2025-03-15 20:14:01', '2025-03-15 20:14:01'),
(207, '2025-03-16', 'pengeluaran', 3, 6, NULL, 4000.00, 'Bakso', 1, '2025-03-15 20:14:23', '2025-03-15 20:14:23'),
(208, '2025-03-16', 'pengeluaran', 3, 2, NULL, 6000.00, 'Telur+mie', 1, '2025-03-15 20:41:33', '2025-03-15 20:41:33'),
(209, '2025-03-16', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-15 20:42:09', '2025-03-15 20:42:09'),
(210, '2025-03-16', 'pengeluaran', 3, 6, NULL, 2000.00, 'Susu', 1, '2025-03-15 21:12:05', '2025-03-15 21:12:05'),
(211, '2025-03-16', 'pengeluaran', 3, 2, NULL, 5000.00, 'Cipuk+cireng', 1, '2025-03-16 01:06:29', '2025-03-16 01:06:29'),
(213, '2025-03-16', 'pengeluaran', 3, 1, NULL, 2000.00, 'Royal+sabun colek', 1, '2025-03-16 01:07:16', '2025-03-16 01:07:16'),
(214, '2025-03-16', 'pemasukan', 1, 9, NULL, 700000.00, 'Domain', 1, '2025-03-17 07:13:51', '2025-03-17 07:13:51'),
(215, '2025-03-16', 'pengeluaran', 3, 2, NULL, 145000.00, 'Beras 10 KG', 1, '2025-03-17 07:15:23', '2025-03-17 07:15:23'),
(216, '2025-03-16', 'pengeluaran', 3, 2, NULL, 72000.00, 'Minyak 4liter', 1, '2025-03-17 07:16:49', '2025-03-17 07:16:49'),
(217, '2025-03-16', 'pengeluaran', 3, 1, NULL, 2000.00, 'Parkir', 1, '2025-03-17 07:18:01', '2025-03-17 07:18:01'),
(218, '2025-03-16', 'pindah', 1, 12, 3, 200000.00, 'Nyandak Artos', 1, '2025-03-17 07:19:16', '2025-03-17 07:19:16'),
(219, '2025-03-16', 'pengeluaran', 3, 1, NULL, 52000.00, 'Sapu, pengki, ember, tempat sampah', 1, '2025-03-17 07:20:38', '2025-03-17 07:20:38'),
(220, '2025-03-16', 'pengeluaran', 3, 1, NULL, 4000.00, 'Rania+Albi', 1, '2025-03-17 07:21:58', '2025-03-17 07:21:58'),
(221, '2025-03-16', 'pengeluaran', 3, 3, NULL, 2500.00, 'Rania+albi', 1, '2025-03-17 07:22:41', '2025-03-17 07:22:41'),
(222, '2025-03-16', 'pengeluaran', 3, 1, NULL, 2500.00, 'Pampers', 1, '2025-03-17 07:23:17', '2025-03-17 07:23:17'),
(223, '2025-03-16', 'pengeluaran', 1, 12, NULL, 50000.00, 'Bantuan garuda cbt', 1, '2025-03-17 07:24:20', '2025-03-17 07:24:20'),
(224, '2025-03-16', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-17 07:25:06', '2025-03-17 07:25:06'),
(225, '2025-03-16', 'pengeluaran', 3, 3, NULL, 5000.00, 'Ghania+Albi+Rania', 1, '2025-03-17 07:26:06', '2025-03-17 07:26:06'),
(226, '2025-03-16', 'pindah', 3, 11, 4, 50000.00, 'Ngambil untuk jaga - jaga', 1, '2025-03-17 07:29:52', '2025-03-17 07:29:52'),
(227, '2025-03-16', 'pengeluaran', 3, 6, NULL, 4000.00, 'Cilok', 1, '2025-03-17 07:30:45', '2025-03-17 07:30:45'),
(228, '2025-03-17', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-17 07:31:51', '2025-03-17 07:31:51'),
(229, '2025-03-17', 'pengeluaran', 3, 1, NULL, 1500.00, 'Mama lemon', 1, '2025-03-17 07:32:24', '2025-03-17 07:32:24'),
(230, '2025-03-17', 'pengeluaran', 3, 2, NULL, 3500.00, 'Mie', 1, '2025-03-17 07:33:09', '2025-03-17 07:33:09'),
(231, '2025-03-17', 'pengeluaran', 3, 2, NULL, 12000.00, 'Sarden', 1, '2025-03-17 07:33:40', '2025-03-17 07:33:40'),
(232, '2025-03-17', 'pengeluaran', 3, 6, NULL, 1000.00, 'Ciki', 1, '2025-03-17 07:34:19', '2025-03-17 07:34:19'),
(233, '2025-03-17', 'pengeluaran', 3, 2, NULL, 16000.00, 'Kacang, terigu, gula, asel, cengek, salam, telur', 1, '2025-03-17 07:34:56', '2025-03-17 07:34:56'),
(234, '2025-03-17', 'pengeluaran', 3, 3, NULL, 2500.00, 'Jajan Barudak', 1, '2025-03-17 13:58:04', '2025-03-17 13:58:04'),
(235, '2025-03-17', 'pengeluaran', 3, 6, NULL, 2000.00, 'jjn tth', 1, '2025-03-17 13:58:38', '2025-03-17 13:58:38'),
(236, '2025-03-17', 'pengeluaran', 3, 6, NULL, 25000.00, 'Pembersih tth', 1, '2025-03-17 13:59:08', '2025-03-17 13:59:08'),
(237, '2025-03-17', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi Good Day 1', 1, '2025-03-17 13:59:56', '2025-03-17 13:59:56'),
(238, '2025-03-17', 'pengeluaran', 3, 3, NULL, 10000.00, 'Ghania jajan boba', 1, '2025-03-17 14:00:30', '2025-03-17 14:00:30'),
(239, '2025-03-17', 'pengeluaran', 3, 6, NULL, 2000.00, 'Jajan ciki', 1, '2025-03-17 14:01:06', '2025-03-17 14:01:06'),
(240, '2025-03-18', 'pengeluaran', 3, 7, NULL, 500.00, 'Teh sisri', 1, '2025-03-18 00:04:25', '2025-03-18 00:04:25'),
(241, '2025-03-18', 'pengeluaran', 3, 2, NULL, 1500.00, 'Gula berem', 1, '2025-03-18 00:04:49', '2025-03-18 00:04:49'),
(242, '2025-03-18', 'pengeluaran', 3, 2, NULL, 8500.00, 'Daging 1/4', 1, '2025-03-18 03:03:00', '2025-03-18 03:03:00'),
(243, '2025-03-18', 'pengeluaran', 3, 2, NULL, 1500.00, 'Kecap bango', 1, '2025-03-18 03:03:24', '2025-03-18 03:03:24'),
(244, '2025-03-18', 'pengeluaran', 3, 2, NULL, 1000.00, 'Muncang+pedes siki', 1, '2025-03-18 03:03:51', '2025-03-18 03:03:51'),
(245, '2025-03-18', 'pengeluaran', 3, 3, NULL, 2000.00, 'Ghania', 1, '2025-03-18 03:54:43', '2025-03-18 03:54:43'),
(246, '2025-03-18', 'pengeluaran', 3, 3, NULL, 2000.00, 'Albi', 1, '2025-03-18 04:46:23', '2025-03-18 04:46:23'),
(247, '2025-03-18', 'pengeluaran', 3, 2, NULL, 3000.00, 'Cireng', 1, '2025-03-18 09:03:07', '2025-03-18 09:03:07'),
(248, '2025-03-18', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-18 09:03:33', '2025-03-18 09:03:33'),
(249, '2025-03-18', 'pengeluaran', 3, 3, NULL, 5000.00, 'Ghania', 1, '2025-03-18 11:12:29', '2025-03-18 11:12:29'),
(250, '2025-03-18', 'pengeluaran', 3, 6, NULL, 5000.00, 'Cilok+baso', 1, '2025-03-18 11:12:54', '2025-03-18 11:12:54'),
(251, '2025-03-18', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-19 02:02:10', '2025-03-19 02:02:10'),
(252, '2025-03-19', 'pengeluaran', 3, 6, NULL, 2000.00, 'Susu', 1, '2025-03-19 02:02:38', '2025-03-19 02:02:38'),
(253, '2025-03-19', 'pengeluaran', 3, 1, NULL, 1000.00, 'Sampo', 1, '2025-03-19 02:02:57', '2025-03-19 02:02:57'),
(254, '2025-03-19', 'pengeluaran', 3, 3, NULL, 4000.00, 'Rania+Albi', 1, '2025-03-19 02:03:18', '2025-03-19 02:03:18'),
(256, '2025-03-19', 'pindah', 4, 11, 3, 50000.00, 'pindah ke cash', 1, '2025-03-19 06:48:39', '2025-03-19 06:48:39'),
(257, '2025-03-19', 'pengeluaran', 3, 2, NULL, 4000.00, 'Cipuk cireng', 1, '2025-03-19 08:21:27', '2025-03-19 08:21:27'),
(258, '2025-03-19', 'pengeluaran', 3, 2, NULL, 16000.00, 'Telur, gula berem, muncang, cabe berem, tomat, pedes', 1, '2025-03-19 08:22:39', '2025-03-19 08:22:39'),
(259, '2025-03-19', 'pengeluaran', 3, 3, NULL, 1000.00, 'Rania', 1, '2025-03-19 08:23:36', '2025-03-19 08:23:36'),
(260, '2025-03-19', 'pengeluaran', 3, 1, NULL, 1000.00, 'Liquid', 1, '2025-03-19 08:24:12', '2025-03-19 08:24:12'),
(261, '2025-03-19', 'pengeluaran', 3, 3, NULL, 2000.00, 'Albi', 1, '2025-03-19 08:58:31', '2025-03-19 08:58:31'),
(262, '2025-03-19', 'pengeluaran', 3, 1, NULL, 500.00, 'Soklin lantai', 1, '2025-03-19 12:16:29', '2025-03-19 12:16:29'),
(263, '2025-03-19', 'pengeluaran', 3, 2, NULL, 500.00, 'Kecap', 1, '2025-03-19 12:16:45', '2025-03-19 12:16:45'),
(264, '2025-03-19', 'pengeluaran', 3, 3, NULL, 5000.00, 'Ghania', 1, '2025-03-19 12:17:03', '2025-03-19 12:17:03'),
(265, '2025-03-19', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-19 12:17:21', '2025-03-19 12:17:21'),
(266, '2025-03-20', 'pengeluaran', 3, 3, NULL, 2500.00, 'Ghania', 1, '2025-03-19 20:50:15', '2025-03-19 20:50:32'),
(267, '2025-03-20', 'pengeluaran', 3, 7, NULL, 500.00, 'Marimas', 1, '2025-03-19 20:50:54', '2025-03-19 20:50:54'),
(268, '2025-03-20', 'pengeluaran', 3, 3, NULL, 2000.00, 'Albi', 1, '2025-03-20 02:45:29', '2025-03-20 02:45:29'),
(269, '2025-03-20', 'pengeluaran', 3, 2, NULL, 17000.00, 'Belanja rencang', 1, '2025-03-20 03:35:10', '2025-03-20 03:35:10'),
(270, '2025-03-20', 'pengeluaran', 3, 2, NULL, 4000.00, 'Gehu', 1, '2025-03-20 08:50:46', '2025-03-20 08:50:46'),
(271, '2025-03-20', 'pemasukan', 3, 8, NULL, 1670000.00, 'Honor sakola', 1, '2025-03-20 11:19:07', '2025-03-20 11:19:07'),
(272, '2025-03-20', 'pemasukan', 3, 9, NULL, 200000.00, 'THR sakola', 1, '2025-03-20 11:19:36', '2025-03-20 11:19:36'),
(273, '2025-03-20', 'pemasukan', 3, 9, NULL, 250000.00, 'Penjajakan PKL', 1, '2025-03-20 11:20:05', '2025-03-20 11:20:05'),
(274, '2025-03-20', 'pengeluaran', 3, 5, NULL, 30000.00, 'Listrik', 1, '2025-03-20 11:21:45', '2025-03-20 11:21:45'),
(275, '2025-03-20', 'pengeluaran', 3, 5, NULL, 181000.00, 'SPinjam', 1, '2025-03-20 11:22:33', '2025-03-20 11:22:33'),
(276, '2025-03-20', 'pengeluaran', 3, 7, NULL, 50000.00, 'Uang muka pak salman', 1, '2025-03-20 11:23:48', '2025-03-20 11:23:48'),
(277, '2025-03-20', 'pengeluaran', 3, 1, NULL, 2500.00, 'Mama lemon', 1, '2025-03-20 11:28:18', '2025-03-20 11:28:18'),
(278, '2025-03-20', 'pengeluaran', 3, 2, NULL, 500.00, 'Muncang', 1, '2025-03-20 11:28:55', '2025-03-20 11:28:55'),
(279, '2025-03-20', 'pengeluaran', 3, 6, NULL, 500.00, 'Jajan', 1, '2025-03-20 11:29:26', '2025-03-20 11:29:26'),
(280, '2025-03-20', 'pengeluaran', 3, 3, NULL, 500.00, 'Rania', 1, '2025-03-20 11:29:43', '2025-03-20 11:29:43'),
(281, '2025-03-20', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-20 11:36:59', '2025-03-20 11:36:59'),
(282, '2025-03-20', 'pengeluaran', 3, 3, NULL, 4000.00, 'Ghania', 1, '2025-03-20 11:37:17', '2025-03-20 11:37:17'),
(283, '2025-03-20', 'pengeluaran', 3, 6, NULL, 5000.00, 'Cilok baso', 1, '2025-03-20 14:08:55', '2025-03-20 14:08:55'),
(284, '2025-03-21', 'pengeluaran', 3, 2, NULL, 6000.00, 'Mie+telur', 1, '2025-03-20 23:13:35', '2025-03-20 23:13:35'),
(285, '2025-03-21', 'pengeluaran', 3, 7, NULL, 500.00, 'Teh sisri', 1, '2025-03-20 23:13:57', '2025-03-20 23:13:57'),
(286, '2025-03-21', 'pengeluaran', 3, 1, NULL, 500.00, 'Sampo', 1, '2025-03-20 23:14:15', '2025-03-20 23:14:15'),
(287, '2025-03-21', 'pengeluaran', 3, 3, NULL, 2000.00, 'Susu', 1, '2025-03-20 23:14:41', '2025-03-20 23:14:41'),
(288, '2025-03-21', 'pengeluaran', 3, 1, NULL, 2000.00, 'Royal+Sampo', 1, '2025-03-21 02:43:59', '2025-03-21 02:43:59'),
(289, '2025-03-21', 'pemasukan', 3, 9, NULL, 150000.00, 'Pamasihan ti mamah', 1, '2025-03-21 07:23:52', '2025-03-21 07:23:52'),
(290, '2025-03-21', 'pengeluaran', 3, 7, NULL, 30000.00, 'Roko Sampoerna kretek 2 bungkus', 1, '2025-03-21 07:31:35', '2025-03-21 07:31:35'),
(291, '2025-03-21', 'pengeluaran', 3, 12, NULL, 31000.00, '1 roko Sampoerna kango apa, 1 roko Djarum kango abi', 1, '2025-03-21 07:33:34', '2025-03-21 07:33:34'),
(292, '2025-03-21', 'pengeluaran', 3, 1, NULL, 264000.00, 'Acuk barudak', 1, '2025-03-21 08:09:53', '2025-03-21 08:09:53'),
(293, '2025-03-21', 'pengeluaran', 3, 1, NULL, 101000.00, 'Blouse tth', 1, '2025-03-21 11:12:22', '2025-03-21 11:12:22'),
(294, '2025-03-21', 'pengeluaran', 3, 1, NULL, 180000.00, 'Rok tth', 1, '2025-03-21 11:12:46', '2025-03-21 11:12:46'),
(295, '2025-03-21', 'pengeluaran', 3, 3, NULL, 32000.00, 'Mixue 2', 1, '2025-03-21 11:13:33', '2025-03-21 11:13:33'),
(296, '2025-03-21', 'pengeluaran', 3, 12, NULL, 2000.00, 'Parkir', 1, '2025-03-21 11:13:49', '2025-03-21 11:13:49'),
(297, '2025-03-21', 'pengeluaran', 3, 2, NULL, 3000.00, 'Gehu', 1, '2025-03-21 11:14:07', '2025-03-21 11:14:07'),
(298, '2025-03-21', 'pengeluaran', 3, 3, NULL, 3000.00, 'Air mineral', 1, '2025-03-21 11:14:45', '2025-03-21 11:14:45'),
(299, '2025-03-21', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-21 11:55:39', '2025-03-21 11:55:39'),
(300, '2025-03-21', 'pengeluaran', 3, 1, NULL, 2500.00, 'Pampers', 1, '2025-03-21 11:55:56', '2025-03-21 11:55:56'),
(301, '2025-03-21', 'pengeluaran', 3, 6, NULL, 500.00, 'Marimas', 1, '2025-03-21 11:56:11', '2025-03-21 11:56:11'),
(302, '2025-03-21', 'pengeluaran', 3, 2, NULL, 10000.00, 'Daging+Muncang+Koneng', 1, '2025-03-21 12:45:27', '2025-03-21 12:45:27'),
(303, '2025-03-21', 'pengeluaran', 3, 2, NULL, 5000.00, 'Bawang bodas 1ons', 1, '2025-03-21 12:45:49', '2025-03-21 12:45:49'),
(304, '2025-03-21', 'pengeluaran', 1, 5, NULL, 14000.00, 'Potongan BCA bulanan', 1, '2025-03-21 20:29:30', '2025-03-21 20:29:30'),
(305, '2025-03-21', 'pengeluaran', 3, 2, NULL, 500.00, 'Kecap', 1, '2025-03-22 00:31:30', '2025-03-22 00:31:30'),
(306, '2025-03-21', 'pengeluaran', 3, 6, NULL, 500.00, 'Teh sisri', 1, '2025-03-22 00:31:51', '2025-03-22 00:31:51'),
(307, '2025-03-22', 'pengeluaran', 3, 7, NULL, 500.00, 'Teh sisri', 1, '2025-03-22 00:32:17', '2025-03-22 00:32:17'),
(308, '2025-03-22', 'pengeluaran', 3, 6, NULL, 1500.00, 'Cireng', 1, '2025-03-22 00:32:35', '2025-03-22 00:32:35'),
(309, '2025-03-22', 'pengeluaran', 3, 1, NULL, 500.00, 'Liquid', 1, '2025-03-22 00:32:53', '2025-03-22 00:32:53'),
(310, '2025-03-22', 'pengeluaran', 3, 2, NULL, 2500.00, 'Telur', 1, '2025-03-22 00:33:20', '2025-03-22 00:33:20'),
(311, '2025-03-22', 'pengeluaran', 1, 1, NULL, 21500.00, 'Legging rania', 1, '2025-03-22 07:08:18', '2025-03-22 07:08:18'),
(312, '2025-03-22', 'pengeluaran', 1, 1, NULL, 27329.00, 'Tudung rania', 1, '2025-03-22 07:09:10', '2025-03-22 07:09:10'),
(313, '2025-03-22', 'pengeluaran', 1, 1, NULL, 54753.00, 'Tudung + ciput tth', 1, '2025-03-22 07:10:07', '2025-03-22 07:10:07'),
(314, '2025-03-22', 'pengeluaran', 1, 1, NULL, 69050.00, 'Sandal barudak', 1, '2025-03-22 07:10:37', '2025-03-22 07:10:37'),
(315, '2025-03-22', 'pindah', 3, 11, 4, 50000.00, 'Bekel aa', 1, '2025-03-22 07:11:44', '2025-03-22 07:11:44'),
(316, '2025-03-22', 'pengeluaran', 3, 6, NULL, 2000.00, 'Basreng', 1, '2025-03-22 07:51:04', '2025-03-22 07:51:04'),
(317, '2025-03-22', 'pengeluaran', 3, 12, NULL, 40000.00, 'Bukber', 1, '2025-03-22 13:01:32', '2025-03-22 13:01:32'),
(318, '2025-03-22', 'pengeluaran', 4, 12, NULL, 20000.00, 'Masihan murangkalih a eman(raka engkus)', 1, '2025-03-22 13:13:42', '2025-03-22 13:13:42'),
(319, '2025-03-22', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-22 20:15:49', '2025-03-22 20:15:49'),
(320, '2025-03-23', 'pengeluaran', 3, 2, NULL, 6000.00, 'Mie+Telur', 1, '2025-03-22 20:16:18', '2025-03-22 20:16:18'),
(321, '2025-03-23', 'pengeluaran', 3, 7, NULL, 500.00, 'Marimas', 1, '2025-03-22 20:37:26', '2025-03-22 20:37:26'),
(322, '2025-03-23', 'pengeluaran', 3, 6, NULL, 1500.00, 'Jajan', 1, '2025-03-22 20:37:51', '2025-03-22 20:37:51'),
(323, '2025-03-23', 'pengeluaran', 3, 2, NULL, 2000.00, 'Cengek+tomat', 1, '2025-03-23 12:01:41', '2025-03-23 12:01:41'),
(324, '2025-03-23', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-23 12:02:06', '2025-03-23 12:02:06'),
(325, '2025-03-23', 'pengeluaran', 3, 3, NULL, 10000.00, 'Sosis (Rania+Albi)', 1, '2025-03-23 12:02:31', '2025-03-23 12:02:31'),
(326, '2025-03-23', 'pengeluaran', 3, 6, NULL, 8000.00, 'Cireng+sirop', 1, '2025-03-23 12:02:52', '2025-03-23 12:02:52'),
(327, '2025-03-24', 'pengeluaran', 3, 3, NULL, 2000.00, 'Susu ghania', 1, '2025-03-24 02:46:24', '2025-03-24 02:46:24'),
(328, '2025-03-24', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-24 09:07:55', '2025-03-24 09:07:55'),
(329, '2025-03-24', 'pengeluaran', 3, 3, NULL, 3000.00, 'Albi', 1, '2025-03-24 09:08:19', '2025-03-24 09:08:19'),
(330, '2025-03-24', 'pengeluaran', 3, 2, NULL, 11000.00, 'Lotekeun, suuk, telur, samara', 1, '2025-03-24 09:09:32', '2025-03-24 09:09:32'),
(331, '2025-03-23', 'pengeluaran', 3, 1, NULL, 4000.00, 'Liquid, sabun colek, sampo, pewangi', 1, '2025-03-24 09:19:32', '2025-03-24 09:19:32'),
(332, '2025-03-24', 'pengeluaran', 3, 2, NULL, 3000.00, 'Cipuk', 1, '2025-03-24 11:43:13', '2025-03-24 11:43:13'),
(333, '2025-03-24', 'pengeluaran', 3, 5, NULL, 24000.00, 'Wifi', 1, '2025-03-24 11:43:31', '2025-03-24 11:43:31'),
(334, '2025-03-24', 'pengeluaran', 1, 5, NULL, 93465.00, 'Gamis tth', 1, '2025-03-24 12:21:49', '2025-03-24 12:21:49'),
(335, '2025-03-25', 'pengeluaran', 3, 2, NULL, 1500.00, 'Suuk, gorengan asin', 1, '2025-03-24 20:29:05', '2025-03-24 20:29:05'),
(336, '2025-03-25', 'pengeluaran', 3, 7, NULL, 500.00, 'Teh sisri', 1, '2025-03-24 20:29:27', '2025-03-24 20:29:27'),
(337, '2025-03-25', 'pengeluaran', 3, 6, NULL, 2000.00, 'Susu', 1, '2025-03-24 21:06:53', '2025-03-24 21:06:53'),
(338, '2025-03-25', 'pengeluaran', 3, 1, NULL, 1000.00, 'Liquid', 1, '2025-03-24 21:07:09', '2025-03-24 21:07:09'),
(339, '2025-03-25', 'pengeluaran', 3, 1, NULL, 2500.00, 'Mama lemon', 1, '2025-03-25 02:20:00', '2025-03-25 02:20:00'),
(340, '2025-03-25', 'pengeluaran', 3, 2, NULL, 1500.00, 'Kecap', 1, '2025-03-25 02:20:15', '2025-03-25 02:20:15'),
(341, '2025-03-25', 'pengeluaran', 3, 12, NULL, 2000.00, 'Print ktp dan npwp', 1, '2025-03-25 04:54:06', '2025-03-25 04:54:06'),
(342, '2025-03-25', 'pengeluaran', 3, 12, NULL, 14000.00, 'Materai', 1, '2025-03-25 04:56:14', '2025-03-25 04:56:14'),
(343, '2025-03-25', 'pengeluaran', 3, 1, NULL, 2000.00, 'Parkir', 1, '2025-03-25 04:56:33', '2025-03-25 04:56:33'),
(344, '2025-03-25', 'pengeluaran', 4, 12, NULL, 20000.00, 'Masihan ka mang yayan', 1, '2025-03-25 06:54:51', '2025-03-25 06:54:51'),
(345, '2025-03-25', 'pengeluaran', 3, 3, NULL, 4000.00, 'Albi + Rania', 1, '2025-03-25 07:49:51', '2025-03-25 07:49:51'),
(346, '2025-03-25', 'pengeluaran', 3, 2, NULL, 19000.00, 'Balanja rencang + gehu', 1, '2025-03-25 09:15:59', '2025-03-25 09:16:09'),
(347, '2025-03-25', 'pengeluaran', 3, 3, NULL, 4000.00, 'Ghania+Albi+rania', 1, '2025-03-25 09:16:31', '2025-03-25 09:37:42'),
(348, '2025-03-25', 'pengeluaran', 3, 6, NULL, 5000.00, 'Cilok', 1, '2025-03-25 09:16:44', '2025-03-25 09:16:44'),
(353, '2025-03-25', 'pengeluaran', 3, 7, NULL, 4000.00, 'Kopi', 1, '2025-03-25 20:19:44', '2025-03-25 20:19:44'),
(354, '2025-03-25', 'pengeluaran', 3, 7, NULL, 9000.00, 'Roko', 1, '2025-03-25 20:20:01', '2025-03-25 20:21:18'),
(355, '2025-03-26', 'pengeluaran', 3, 2, NULL, 6000.00, 'Mie telur', 1, '2025-03-25 20:20:29', '2025-03-25 20:20:29'),
(356, '2025-03-25', 'pengeluaran', 3, 12, NULL, 10000.00, 'Sampe', 1, '2025-03-25 20:20:50', '2025-03-25 20:20:50'),
(357, '2025-03-26', 'pengeluaran', 3, 1, NULL, 500.00, 'Liquid', 1, '2025-03-26 03:12:54', '2025-03-26 03:12:54'),
(358, '2025-03-26', 'pengeluaran', 3, 2, NULL, 16500.00, 'Rencang, cireng', 1, '2025-03-26 03:13:16', '2025-03-26 03:13:16'),
(359, '2025-03-26', 'pengeluaran', 3, 1, NULL, 20500.00, 'Gas', 1, '2025-03-26 10:01:22', '2025-03-26 10:01:22'),
(360, '2025-03-26', 'pengeluaran', 3, 12, NULL, 181000.00, 'Beas 12.5kg (fitrah)', 1, '2025-03-26 10:02:11', '2025-03-26 10:02:11'),
(361, '2025-03-26', 'pengeluaran', 3, 4, NULL, 15000.00, 'Upah ganti ban', 1, '2025-03-26 11:30:00', '2025-03-26 11:30:00'),
(362, '2025-03-26', 'pengeluaran', 3, 4, NULL, 50000.00, 'Bensin', 1, '2025-03-26 11:30:22', '2025-03-26 11:30:22'),
(363, '2025-03-26', 'pengeluaran', 3, 4, NULL, 30000.00, 'Tambal ban belakang 2', 1, '2025-03-26 11:30:50', '2025-03-26 11:30:50'),
(364, '2025-03-26', 'pengeluaran', 3, 3, NULL, 2000.00, 'Susu', 1, '2025-03-26 11:31:57', '2025-03-26 11:31:57'),
(365, '2025-03-26', 'pengeluaran', 3, 2, NULL, 2500.00, 'Telur', 1, '2025-03-26 11:32:12', '2025-03-26 11:32:12'),
(366, '2025-03-26', 'pengeluaran', 3, 3, NULL, 1500.00, 'Segar dingin (ghania)', 1, '2025-03-26 11:32:34', '2025-03-26 11:32:34'),
(367, '2025-03-26', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-26 11:32:49', '2025-03-26 11:32:58'),
(368, '2025-03-26', 'pengeluaran', 3, 3, NULL, 2000.00, 'Jajan albi', 1, '2025-03-26 11:45:25', '2025-03-26 11:45:25'),
(369, '2025-03-27', 'pengeluaran', 3, 7, NULL, 9500.00, 'Roko+Teh sisri', 1, '2025-03-26 21:31:04', '2025-03-26 21:31:04'),
(370, '2025-03-27', 'pengeluaran', 3, 6, NULL, 500.00, 'Ciki', 1, '2025-03-26 21:31:22', '2025-03-26 21:31:22'),
(371, '2025-03-27', 'pengeluaran', 4, 4, NULL, 9000.00, 'Braket dan baud no 10 4pcs', 1, '2025-03-27 11:14:14', '2025-03-27 11:14:14'),
(372, '2025-03-27', 'pengeluaran', 3, 7, NULL, 30000.00, 'Roko Sampoerna kretek 2bks', 1, '2025-03-27 11:14:57', '2025-03-27 11:14:57'),
(373, '2025-03-27', 'pengeluaran', 3, 2, NULL, 20000.00, 'Cendol 4', 1, '2025-03-27 11:15:37', '2025-03-27 11:15:37'),
(374, '2025-03-27', 'pengeluaran', 3, 2, NULL, 5000.00, 'Gehu', 1, '2025-03-27 11:15:58', '2025-03-27 11:15:58'),
(375, '2025-03-27', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-27 20:34:56', '2025-03-27 20:34:56'),
(376, '2025-03-28', 'pengeluaran', 3, 7, NULL, 500.00, 'Teh sisri', 1, '2025-03-27 20:35:17', '2025-03-27 20:35:17'),
(377, '2025-03-28', 'pengeluaran', 3, 6, NULL, 2500.00, 'Sukro+Susu', 1, '2025-03-27 20:35:38', '2025-03-27 20:35:38'),
(378, '2025-03-28', 'pengeluaran', 3, 1, NULL, 1000.00, 'Liquid+Royal', 1, '2025-03-28 02:01:32', '2025-03-28 02:01:32'),
(379, '2025-03-28', 'pengeluaran', 3, 2, NULL, 500.00, 'Kecap', 1, '2025-03-28 02:01:46', '2025-03-28 02:01:46'),
(380, '2025-03-28', 'pengeluaran', 3, 2, NULL, 14500.00, 'Daging, tempe, tomat, samara, kecap', 1, '2025-03-28 07:56:05', '2025-03-28 07:56:05'),
(381, '2025-03-28', 'pengeluaran', 3, 2, NULL, 4000.00, 'Cipul cireng', 1, '2025-03-28 07:56:29', '2025-03-28 07:56:29'),
(382, '2025-03-28', 'pengeluaran', 3, 3, NULL, 5000.00, 'Ghania+Albi', 1, '2025-03-28 09:58:07', '2025-03-28 09:58:07'),
(383, '2025-03-29', 'pengeluaran', 3, 2, NULL, 19000.00, 'Daging 1/2', 1, '2025-03-29 04:40:57', '2025-03-29 04:40:57'),
(384, '2025-03-29', 'pengeluaran', 3, 2, NULL, 18000.00, 'Kentang 1kg', 1, '2025-03-29 04:41:15', '2025-03-29 04:41:15'),
(385, '2025-03-29', 'pengeluaran', 3, 2, NULL, 13000.00, 'Bawang berem 1/4', 1, '2025-03-29 04:41:37', '2025-03-29 04:41:37'),
(386, '2025-03-29', 'pengeluaran', 3, 2, NULL, 10000.00, 'Royco', 1, '2025-03-29 04:41:50', '2025-03-29 04:41:50'),
(387, '2025-03-29', 'pengeluaran', 3, 2, NULL, 1000.00, 'Apu', 1, '2025-03-29 05:50:09', '2025-03-29 05:50:09'),
(388, '2025-03-29', 'pengeluaran', 3, 2, NULL, 13000.00, 'Rencang', 1, '2025-03-29 12:09:38', '2025-03-29 12:09:38'),
(389, '2025-03-30', 'pengeluaran', 3, 7, NULL, 5000.00, 'Kopi 2, teh sisri 2', 1, '2025-03-29 20:28:31', '2025-03-29 20:28:48'),
(390, '2025-03-30', 'pengeluaran', 3, 6, NULL, 2000.00, 'Cireng', 1, '2025-03-29 20:29:08', '2025-03-29 20:29:08'),
(391, '2025-03-30', 'pengeluaran', 3, 1, NULL, 2000.00, 'Sampo 2 + antisep', 1, '2025-03-30 02:14:01', '2025-03-30 02:14:01'),
(392, '2025-03-30', 'pengeluaran', 3, 2, NULL, 12000.00, 'Samara', 1, '2025-03-30 02:36:36', '2025-03-30 02:36:36'),
(393, '2025-03-30', 'pengeluaran', 3, 2, NULL, 3000.00, 'Santan', 1, '2025-03-30 07:57:26', '2025-03-30 07:57:26'),
(394, '2025-03-30', 'pengeluaran', 3, 3, NULL, 2000.00, 'Ghania', 1, '2025-03-30 07:57:39', '2025-03-30 07:57:39'),
(395, '2025-03-30', 'pengeluaran', 3, 2, NULL, 48000.00, 'Alat bolu', 1, '2025-03-30 09:36:27', '2025-03-30 09:36:27'),
(396, '2025-03-30', 'pengeluaran', 3, 3, NULL, 8000.00, 'Eskrim', 1, '2025-03-30 09:36:53', '2025-03-30 09:36:53'),
(397, '2025-03-30', 'pengeluaran', 3, 7, NULL, 4000.00, 'Kopi 2', 1, '2025-03-30 14:43:54', '2025-03-30 14:43:54'),
(398, '2025-03-30', 'pengeluaran', 3, 6, NULL, 1000.00, 'Teh sisri', 1, '2025-03-30 14:44:10', '2025-03-30 14:44:10'),
(399, '2025-03-30', 'pengeluaran', 3, 2, NULL, 2500.00, 'Gula 1ons', 1, '2025-03-30 14:44:26', '2025-03-30 14:44:26'),
(400, '2025-03-30', 'pengeluaran', 3, 1, NULL, 1500.00, 'Soklin lantai + liquid', 1, '2025-03-30 14:44:58', '2025-03-30 14:44:58'),
(401, '2025-03-30', 'pengeluaran', 3, 3, NULL, 1000.00, 'Albi rania', 1, '2025-03-30 14:45:14', '2025-03-30 14:45:14'),
(402, '2025-03-31', 'pengeluaran', 3, 1, NULL, 3000.00, 'Mama lemon+Sampo', 1, '2025-03-31 04:22:28', '2025-03-31 04:22:28'),
(403, '2025-03-31', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-03-31 04:22:43', '2025-03-31 04:22:43'),
(404, '2025-03-30', 'pengeluaran', 3, 1, NULL, 1000.00, 'Sabun colek', 1, '2025-03-31 04:23:28', '2025-03-31 04:23:28'),
(405, '2025-03-30', 'pengeluaran', 3, 7, NULL, 3500.00, 'Mie', 1, '2025-03-31 04:23:46', '2025-03-31 04:23:46'),
(406, '2025-03-31', 'pindah', 4, 11, 3, 1000.00, 'Pindah', 1, '2025-03-31 09:22:21', '2025-03-31 09:22:21'),
(407, '2025-03-31', 'pengeluaran', 3, 6, NULL, 11000.00, 'Baso', 1, '2025-03-31 09:23:39', '2025-03-31 09:23:39'),
(408, '2025-03-31', 'pengeluaran', 3, 7, NULL, 10000.00, 'Baso', 1, '2025-03-31 09:23:59', '2025-03-31 09:23:59'),
(409, '2025-03-31', 'pengeluaran', 3, 12, NULL, 100000.00, 'Iuran Halal bihalal', 1, '2025-03-31 11:21:40', '2025-03-31 11:21:40'),
(410, '2025-03-31', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-01 00:20:29', '2025-04-01 00:20:29'),
(411, '2025-04-01', 'pengeluaran', 3, 2, NULL, 3000.00, 'Telur+kecap', 1, '2025-04-01 00:20:45', '2025-04-01 00:20:45'),
(412, '2025-04-01', 'pengeluaran', 3, 3, NULL, 2500.00, 'Pampers', 1, '2025-04-01 11:29:38', '2025-04-01 11:29:38'),
(413, '2025-04-01', 'pengeluaran', 3, 2, NULL, 3500.00, 'Mie', 1, '2025-04-01 11:30:18', '2025-04-01 11:30:18'),
(414, '2025-04-02', 'pengeluaran', 3, 1, NULL, 2000.00, 'Liquid+royal+sabun colek', 1, '2025-04-02 01:40:21', '2025-04-02 01:40:21'),
(415, '2025-04-02', 'pengeluaran', 3, 2, NULL, 13000.00, 'Sarden+jahe+tomat', 1, '2025-04-02 01:40:58', '2025-04-02 01:40:58'),
(416, '2025-04-02', 'pengeluaran', 3, 12, NULL, 15000.00, 'Ngamplop nikahan', 1, '2025-04-02 07:56:12', '2025-04-02 07:56:12'),
(417, '2025-04-02', 'pengeluaran', 3, 2, NULL, 4000.00, 'Kurupuk, cengek, ladaku', 1, '2025-04-02 07:56:37', '2025-04-02 07:56:37'),
(418, '2025-04-02', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-03 00:28:09', '2025-04-03 00:28:09'),
(419, '2025-04-03', 'pengeluaran', 3, 1, NULL, 4000.00, 'Telur+kecap', 1, '2025-04-03 00:28:34', '2025-04-03 00:28:34'),
(420, '2025-04-03', 'pengeluaran', 3, 7, NULL, 9000.00, 'Roko 1/2', 1, '2025-04-03 00:43:53', '2025-04-03 00:43:53'),
(421, '2025-04-03', 'pengeluaran', 3, 1, NULL, 4000.00, 'Royal, antisep, mama lemon', 1, '2025-04-03 01:12:34', '2025-04-03 01:12:34'),
(422, '2025-04-03', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-03 08:45:39', '2025-04-03 08:45:39');
INSERT INTO `transactions` (`id`, `date`, `type`, `account_id`, `category_id`, `target_account_id`, `amount`, `descriptions`, `user_id`, `created_at`, `updated_at`) VALUES
(423, '2025-04-03', 'pengeluaran', 3, 6, NULL, 8000.00, 'Baso', 1, '2025-04-03 08:45:58', '2025-04-03 08:45:58'),
(424, '2025-04-03', 'pengeluaran', 3, 2, NULL, 13000.00, 'Daging+samara', 1, '2025-04-03 10:18:06', '2025-04-03 10:18:06'),
(425, '2025-04-03', 'pengeluaran', 3, 7, NULL, 9500.00, 'Roko 1/2', 1, '2025-04-04 01:14:20', '2025-04-04 01:14:20'),
(426, '2025-04-04', 'pengeluaran', 3, 6, NULL, 5000.00, 'Baso ikan', 1, '2025-04-04 22:59:04', '2025-04-04 22:59:04'),
(427, '2025-04-04', 'pengeluaran', 3, 2, NULL, 7500.00, 'Rencang', 1, '2025-04-04 22:59:39', '2025-04-04 22:59:39'),
(428, '2025-04-04', 'pengeluaran', 3, 2, NULL, 1000.00, 'Kurupuk', 1, '2025-04-04 23:00:04', '2025-04-04 23:00:04'),
(429, '2025-04-04', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-04 23:00:22', '2025-04-04 23:00:22'),
(430, '2025-04-05', 'pengeluaran', 3, 6, NULL, 2000.00, 'Susu', 1, '2025-04-05 08:20:36', '2025-04-05 08:20:36'),
(431, '2025-04-05', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-05 08:20:52', '2025-04-05 08:20:52'),
(432, '2025-04-05', 'pengeluaran', 3, 1, NULL, 2000.00, 'Kecap', 1, '2025-04-05 08:21:07', '2025-04-05 08:21:07'),
(433, '2025-04-05', 'pengeluaran', 3, 1, NULL, 1000.00, 'Sampo', 1, '2025-04-05 08:21:20', '2025-04-05 08:21:20'),
(434, '2025-04-04', 'pengeluaran', 1, 5, NULL, 102000.00, 'Kuota', 1, '2025-04-05 08:21:36', '2025-04-05 08:21:36'),
(435, '2025-04-05', 'pengeluaran', 3, 2, NULL, 11500.00, 'Rencang', 1, '2025-04-05 10:29:23', '2025-04-05 10:29:23'),
(436, '2025-04-05', 'pengeluaran', 3, 2, NULL, 500.00, 'Tomat', 1, '2025-04-06 01:32:29', '2025-04-06 01:32:29'),
(437, '2025-04-06', 'pengeluaran', 3, 1, NULL, 2000.00, 'Royal 2, sabun colek', 1, '2025-04-06 01:32:52', '2025-04-06 01:32:52'),
(438, '2025-04-06', 'pengeluaran', 3, 2, NULL, 10000.00, 'Rencang', 1, '2025-04-06 09:39:03', '2025-04-06 09:39:03'),
(439, '2025-04-06', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-06 23:30:08', '2025-04-06 23:30:08'),
(440, '2025-04-07', 'pengeluaran', 3, 6, NULL, 1000.00, 'Melon', 1, '2025-04-07 02:58:39', '2025-04-07 02:58:39'),
(441, '2025-04-07', 'pengeluaran', 3, 2, NULL, 14000.00, 'Rencang', 1, '2025-04-07 02:58:54', '2025-04-07 02:58:54'),
(442, '2025-04-07', 'pengeluaran', 3, 7, NULL, 7000.00, 'Roko+kopi', 1, '2025-04-07 06:34:17', '2025-04-07 06:34:17'),
(443, '2025-04-07', 'pengeluaran', 3, 4, NULL, 50000.00, 'Bensin', 1, '2025-04-07 06:34:37', '2025-04-07 06:34:37'),
(444, '2025-04-07', 'pengeluaran', 3, 4, NULL, 15000.00, 'Tambal ban', 1, '2025-04-07 06:34:57', '2025-04-07 06:34:57'),
(445, '2025-04-07', 'pengeluaran', 3, 12, NULL, 15000.00, 'Cukur (aa)', 1, '2025-04-07 06:35:27', '2025-04-07 06:35:27'),
(446, '2025-04-07', 'pengeluaran', 3, 1, NULL, 1500.00, 'Sampo+royal', 1, '2025-04-07 11:36:50', '2025-04-07 11:36:50'),
(447, '2025-04-07', 'pengeluaran', 3, 2, NULL, 2500.00, 'Telur', 1, '2025-04-07 11:37:04', '2025-04-07 11:37:04'),
(448, '2025-04-07', 'pengeluaran', 3, 7, NULL, 9500.00, 'Roko', 1, '2025-04-07 11:37:22', '2025-04-07 11:37:22'),
(449, '2025-04-07', 'pengeluaran', 3, 6, NULL, 500.00, 'Jajan', 1, '2025-04-07 11:37:35', '2025-04-07 11:37:35'),
(450, '2025-04-08', 'pemasukan', 4, 9, NULL, 70000.00, 'Masuk ke dompet', 1, '2025-04-08 06:19:52', '2025-04-08 06:19:52'),
(451, '2025-04-08', 'pemasukan', 3, 9, NULL, 30000.00, 'Pemutihan data', 1, '2025-04-08 06:21:38', '2025-04-08 06:21:38'),
(452, '2025-04-08', 'pengeluaran', 3, 2, NULL, 3000.00, 'Tahu balut', 1, '2025-04-08 09:38:35', '2025-04-08 09:38:35'),
(453, '2025-04-08', 'pengeluaran', 3, 2, NULL, 3500.00, 'Mie', 1, '2025-04-08 09:38:50', '2025-04-08 09:38:50'),
(454, '2025-04-08', 'pengeluaran', 3, 6, NULL, 500.00, 'Teh sisri', 1, '2025-04-08 09:39:05', '2025-04-08 09:39:05'),
(455, '2025-04-08', 'pengeluaran', 3, 2, NULL, 2000.00, 'Kurupuk', 1, '2025-04-08 09:39:40', '2025-04-08 09:39:40'),
(456, '2025-04-09', 'pengeluaran', 4, 7, NULL, 13000.00, 'Rokok dan ke Bu rosa', 1, '2025-04-09 01:35:41', '2025-04-09 01:35:41'),
(457, '2025-04-08', 'pengeluaran', 3, 2, NULL, 1000.00, 'Cengek', 1, '2025-04-09 02:13:10', '2025-04-09 02:13:10'),
(458, '2025-04-08', 'pengeluaran', 3, 3, NULL, 1000.00, 'Rania', 1, '2025-04-09 02:13:37', '2025-04-09 02:13:37'),
(459, '2025-04-09', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-09 02:13:57', '2025-04-09 02:13:57'),
(460, '2025-04-09', 'pengeluaran', 3, 1, NULL, 1000.00, 'Antisep', 1, '2025-04-09 02:14:14', '2025-04-09 02:14:14'),
(461, '2025-04-09', 'pengeluaran', 3, 2, NULL, 3500.00, 'Telur+Kecap', 1, '2025-04-09 02:14:45', '2025-04-09 02:14:45'),
(462, '2025-04-09', 'pengeluaran', 3, 2, NULL, 4500.00, 'Tempe bendot', 1, '2025-04-09 02:22:39', '2025-04-09 02:22:39'),
(463, '2025-04-09', 'pengeluaran', 3, 3, NULL, 3000.00, 'Albi rania', 1, '2025-04-09 02:22:57', '2025-04-09 02:22:57'),
(464, '2025-04-09', 'pengeluaran', 3, 3, NULL, 4000.00, 'Bekel ghania', 1, '2025-04-09 02:23:14', '2025-04-09 02:23:14'),
(465, '2025-04-09', 'pengeluaran', 3, 6, NULL, 5000.00, 'Jajan', 1, '2025-04-09 02:23:29', '2025-04-09 02:23:29'),
(466, '2025-04-09', 'pengeluaran', 3, 3, NULL, 6000.00, 'Ghania albi rania', 1, '2025-04-09 08:05:54', '2025-04-09 08:05:54'),
(467, '2025-04-09', 'pengeluaran', 3, 6, NULL, 4000.00, 'Mie kururpuk', 1, '2025-04-09 08:06:31', '2025-04-09 08:06:31'),
(468, '2025-04-09', 'pengeluaran', 3, 10, NULL, 5000.00, 'Nabung', 1, '2025-04-09 08:52:18', '2025-04-09 08:52:18'),
(469, '2025-04-09', 'pengeluaran', 3, 2, NULL, 2000.00, 'Telur', 1, '2025-04-10 10:44:37', '2025-04-10 10:44:37'),
(470, '2025-04-09', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-10 10:44:54', '2025-04-10 10:44:54'),
(471, '2025-04-10', 'pengeluaran', 3, 1, NULL, 500.00, 'Sampo', 1, '2025-04-10 10:45:11', '2025-04-10 10:45:11'),
(472, '2025-04-10', 'pengeluaran', 3, 1, NULL, 2500.00, 'Pampers', 1, '2025-04-10 10:45:28', '2025-04-10 10:45:28'),
(473, '2025-04-10', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-10 10:45:43', '2025-04-10 10:45:43'),
(474, '2025-04-10', 'pengeluaran', 3, 3, NULL, 5000.00, 'Ghania albi rania', 1, '2025-04-10 10:46:08', '2025-04-10 10:46:08'),
(475, '2025-04-10', 'pengeluaran', 3, 6, NULL, 5000.00, 'Jjn', 1, '2025-04-10 10:46:32', '2025-04-10 10:46:32'),
(476, '2025-04-10', 'pengeluaran', 3, 3, NULL, 2000.00, 'Roti', 1, '2025-04-10 10:46:47', '2025-04-10 10:46:47'),
(477, '2025-04-11', 'pengeluaran', 3, 10, NULL, 5000.00, 'Nabung', 1, '2025-04-11 00:45:18', '2025-04-11 00:45:18'),
(478, '2025-04-11', 'pengeluaran', 3, 10, NULL, 3000.00, 'Bekel ghania', 1, '2025-04-11 01:12:42', '2025-04-11 01:20:05'),
(479, '2025-04-11', 'pengeluaran', 3, 10, NULL, 2000.00, 'Kas', 1, '2025-04-11 01:20:20', '2025-04-11 01:20:20'),
(480, '2025-04-11', 'pengeluaran', 3, 2, NULL, 9000.00, 'Daging + samara', 1, '2025-04-11 01:58:29', '2025-04-11 01:58:29'),
(481, '2025-04-11', 'pengeluaran', 3, 6, NULL, 2000.00, 'Cireng', 1, '2025-04-11 01:58:43', '2025-04-11 01:58:43'),
(482, '2025-04-11', 'pengeluaran', 4, 7, NULL, 13000.00, 'Rokok Marlboro 1 bks', 1, '2025-04-11 06:34:10', '2025-04-11 06:34:10'),
(483, '2025-04-11', 'pengeluaran', 3, 1, NULL, 1000.00, 'Sabun colek', 1, '2025-04-11 10:26:00', '2025-04-11 10:26:00'),
(484, '2025-04-11', 'pengeluaran', 3, 2, NULL, 3000.00, 'Cengek, gula, terasi', 1, '2025-04-11 10:26:23', '2025-04-11 10:26:23'),
(485, '2025-04-11', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-11 10:26:38', '2025-04-11 10:26:38'),
(486, '2025-04-12', 'pengeluaran', 3, 1, NULL, 1000.00, 'Sampo', 1, '2025-04-12 04:59:15', '2025-04-12 04:59:15'),
(487, '2025-04-12', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-12 04:59:30', '2025-04-12 04:59:30'),
(488, '2025-04-12', 'pengeluaran', 3, 6, NULL, 2000.00, 'Basreng', 1, '2025-04-12 04:59:54', '2025-04-12 04:59:54'),
(489, '2025-04-15', 'pindah', 4, 1, 3, 42000.00, 'Pindah', 1, '2025-04-14 23:30:14', '2025-04-14 23:30:14'),
(490, '2025-04-15', 'pengeluaran', 3, 10, NULL, 3000.00, 'Bekel', 1, '2025-04-15 02:18:09', '2025-04-15 02:18:09'),
(491, '2025-04-15', 'pengeluaran', 3, 2, NULL, 10500.00, 'Rencang', 1, '2025-04-15 02:18:23', '2025-04-15 02:18:23'),
(492, '2025-04-15', 'pengeluaran', 3, 6, NULL, 2500.00, 'Jjn', 1, '2025-04-15 02:18:38', '2025-04-15 02:18:38'),
(493, '2025-04-15', 'pengeluaran', 3, 2, NULL, 2000.00, 'Santan', 1, '2025-04-15 02:34:15', '2025-04-15 02:34:15'),
(494, '2025-04-15', 'pengeluaran', 3, 3, NULL, 2000.00, 'Rania+Albi', 1, '2025-04-15 03:52:17', '2025-04-15 03:52:17'),
(495, '2025-04-15', 'pemasukan', 4, 9, NULL, 50000.00, 'Namut ka Bu Rosa', 1, '2025-04-15 10:18:34', '2025-04-15 10:18:34'),
(496, '2025-04-15', 'pengeluaran', 4, 7, NULL, 13000.00, 'Rokok', 1, '2025-04-15 10:19:03', '2025-04-15 10:19:03'),
(497, '2025-04-15', 'pemasukan', 3, 9, NULL, 100000.00, 'Nambut k mmh', 1, '2025-04-15 10:20:10', '2025-04-15 10:20:10'),
(498, '2025-04-15', 'pengeluaran', 3, 12, NULL, 50000.00, 'Nyecep k ahez', 1, '2025-04-15 10:20:31', '2025-04-15 10:20:31'),
(499, '2025-04-15', 'pengeluaran', 3, 2, NULL, 5000.00, 'Telur 2', 1, '2025-04-15 10:20:58', '2025-04-15 10:20:58'),
(500, '2025-04-15', 'pengeluaran', 3, 2, NULL, 6500.00, 'Tempe, suuk, telur', 1, '2025-04-15 10:22:15', '2025-04-15 10:22:15'),
(501, '2025-04-15', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-15 10:22:33', '2025-04-15 10:22:33'),
(502, '2025-04-15', 'pengeluaran', 3, 1, NULL, 1500.00, 'Mama lemon', 1, '2025-04-15 10:22:50', '2025-04-15 10:22:50'),
(503, '2025-04-16', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-16 00:40:45', '2025-04-16 00:40:45'),
(504, '2025-04-15', 'pengeluaran', 3, 2, NULL, 500.00, 'Kecap', 1, '2025-04-16 00:40:59', '2025-04-16 00:40:59'),
(505, '2025-04-13', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-16 00:42:29', '2025-04-16 00:42:29'),
(506, '2025-04-13', 'pengeluaran', 3, 1, NULL, 1000.00, 'Antisep', 1, '2025-04-16 00:42:53', '2025-04-16 00:42:53'),
(507, '2025-04-13', 'pengeluaran', 3, 2, NULL, 7000.00, 'Rencang', 1, '2025-04-16 00:43:27', '2025-04-16 00:43:27'),
(508, '2025-04-13', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-16 00:43:46', '2025-04-16 00:43:46'),
(509, '2025-04-13', 'pengeluaran', 3, 6, NULL, 3000.00, 'Cilok', 1, '2025-04-16 00:44:01', '2025-04-16 00:44:01'),
(510, '2025-04-14', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-16 00:44:59', '2025-04-16 00:44:59'),
(511, '2025-04-14', 'pengeluaran', 3, 10, NULL, 3000.00, 'Bekel ghania', 1, '2025-04-16 00:46:05', '2025-04-16 00:46:05'),
(512, '2025-04-14', 'pengeluaran', 3, 6, NULL, 2000.00, 'Jjn', 1, '2025-04-16 00:46:26', '2025-04-16 00:46:26'),
(513, '2025-04-14', 'pengeluaran', 3, 2, NULL, 5000.00, 'Kangkung cengek tempe', 1, '2025-04-16 00:46:47', '2025-04-16 00:48:14'),
(514, '2025-04-14', 'pengeluaran', 3, 2, NULL, 3000.00, 'Gula', 1, '2025-04-16 00:48:35', '2025-04-16 00:48:35'),
(515, '2025-04-14', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-16 00:48:52', '2025-04-16 00:48:52'),
(516, '2025-04-14', 'pengeluaran', 3, 6, NULL, 3500.00, 'Mie', 1, '2025-04-16 00:49:08', '2025-04-16 00:49:08'),
(517, '2025-04-14', 'pengeluaran', 3, 7, NULL, 3500.00, 'Mie', 1, '2025-04-16 00:49:23', '2025-04-16 00:49:23'),
(518, '2025-04-16', 'pengeluaran', 3, 10, NULL, 5000.00, 'Ghania', 1, '2025-04-16 01:03:15', '2025-04-16 01:03:15'),
(519, '2025-04-15', 'pengeluaran', 3, 1, NULL, 500.00, 'Sampo', 1, '2025-04-16 01:03:30', '2025-04-16 01:03:30'),
(520, '2025-04-16', 'pengeluaran', 3, 2, NULL, 10000.00, 'Pejit telur cengek terasi', 1, '2025-04-16 02:33:44', '2025-04-16 08:53:35'),
(521, '2025-04-16', 'pengeluaran', 3, 3, NULL, 2000.00, 'Albi', 1, '2025-04-16 08:54:09', '2025-04-16 08:54:09'),
(522, '2025-04-16', 'pengeluaran', 4, 7, 4, 12000.00, 'Rokok', 1, '2025-04-16 11:12:07', '2025-04-16 11:12:07'),
(523, '2025-04-16', 'pindah', 4, 11, 3, 27000.00, 'Pindah', 1, '2025-04-17 01:21:36', '2025-04-17 01:21:36'),
(524, '2025-04-17', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-17 01:22:32', '2025-04-17 01:22:32'),
(525, '2025-04-17', 'pengeluaran', 3, 6, NULL, 2000.00, 'Susu', 1, '2025-04-17 01:22:51', '2025-04-17 01:22:51'),
(526, '2025-04-17', 'pengeluaran', 3, 2, NULL, 1000.00, 'Kecap', 1, '2025-04-17 01:23:17', '2025-04-17 01:23:17'),
(527, '2025-04-17', 'pengeluaran', 3, 10, NULL, 5000.00, 'Bekel ghania', 1, '2025-04-17 01:23:54', '2025-04-17 01:23:54'),
(528, '2025-04-17', 'pengeluaran', 3, 3, NULL, 2000.00, 'Albi', 1, '2025-04-17 01:24:11', '2025-04-17 01:24:11'),
(529, '2025-04-17', 'pengeluaran', 3, 2, NULL, 6000.00, 'Pindang', 1, '2025-04-17 01:53:17', '2025-04-17 01:53:51'),
(530, '2025-04-17', 'pengeluaran', 3, 2, NULL, 2500.00, 'Kangkung', 1, '2025-04-17 01:53:38', '2025-04-17 01:53:38'),
(531, '2025-04-17', 'pengeluaran', 3, 2, NULL, 3000.00, 'Tempe', 1, '2025-04-17 01:54:06', '2025-04-17 01:54:06'),
(532, '2025-04-17', 'pengeluaran', 3, 7, NULL, 4500.00, 'Mie+kopi', 1, '2025-04-17 23:34:55', '2025-04-17 23:34:55'),
(533, '2025-04-17', 'pemasukan', 3, 9, 3, 300000.00, 'Ti pa asep ujikom', 1, '2025-04-18 05:00:21', '2025-04-18 05:00:21'),
(534, '2025-04-18', 'pengeluaran', 3, 3, NULL, 5000.00, 'Ghania+Albi', 1, '2025-04-18 05:01:11', '2025-04-18 05:01:11'),
(535, '2025-04-18', 'pengeluaran', 3, 6, NULL, 4000.00, 'Seblak', 1, '2025-04-18 05:02:49', '2025-04-18 05:02:49'),
(536, '2025-04-18', 'pengeluaran', 3, 3, NULL, 2000.00, 'Rania', 1, '2025-04-18 05:09:23', '2025-04-18 05:09:23'),
(537, '2025-04-18', 'pengeluaran', 3, 7, NULL, 11500.00, 'Kopi roko', 1, '2025-04-19 00:16:06', '2025-04-19 00:16:06'),
(538, '2025-04-18', 'pengeluaran', 3, 6, NULL, 500.00, 'Teh sisri', 1, '2025-04-19 00:16:21', '2025-04-19 00:16:21'),
(539, '2025-04-19', 'pengeluaran', 3, 2, NULL, 14000.00, 'Daging', 1, '2025-04-19 01:42:10', '2025-04-19 01:42:10'),
(540, '2025-04-19', 'pengeluaran', 3, 2, NULL, 4000.00, 'Kalapa', 1, '2025-04-19 01:42:43', '2025-04-19 01:42:43'),
(542, '2025-04-19', 'pengeluaran', 3, 3, NULL, 2000.00, 'Albi', 1, '2025-04-19 01:43:20', '2025-04-19 01:43:20'),
(543, '2025-04-19', 'pengeluaran', 3, 2, NULL, 2500.00, 'Racik', 1, '2025-04-19 06:51:35', '2025-04-19 06:52:33'),
(544, '2025-04-19', 'pengeluaran', 3, 6, NULL, 1000.00, 'Jjn', 1, '2025-04-19 06:52:18', '2025-04-19 06:52:18'),
(545, '2025-04-19', 'pengeluaran', 3, 1, NULL, 2500.00, 'Mama lemon', 1, '2025-04-19 06:53:02', '2025-04-19 06:53:02'),
(546, '2025-04-19', 'pengeluaran', 3, 12, NULL, 50000.00, 'Masihan ka bi rohinah', 1, '2025-04-19 08:22:34', '2025-04-19 08:22:34'),
(547, '2025-04-18', 'pengeluaran', 1, 5, NULL, 14000.00, 'Admin BCA', 1, '2025-04-19 10:31:12', '2025-04-19 10:31:12'),
(548, '2025-04-19', 'pengeluaran', 1, 7, NULL, 7000.00, 'Adem sari', 1, '2025-04-19 10:31:38', '2025-04-19 10:31:38'),
(549, '2025-04-19', 'pemasukan', 1, 8, NULL, 300000.00, 'Honorium sekolah', 1, '2025-04-19 10:41:38', '2025-04-19 10:41:38'),
(550, '2025-04-19', 'pemasukan', 3, 8, NULL, 1370000.00, 'Honorium sekolah', 1, '2025-04-19 10:42:16', '2025-04-19 10:42:16'),
(551, '2025-04-19', 'pemasukan', 3, 9, NULL, 30000.00, 'Dari yang lulus ppg', 1, '2025-04-19 10:42:48', '2025-04-19 10:42:48'),
(552, '2025-04-19', 'pengeluaran', 3, 5, NULL, 206000.00, 'Cicilan celana dan jaket', 1, '2025-04-19 10:49:57', '2025-04-19 10:49:57'),
(553, '2025-04-19', 'pengeluaran', 3, 1, NULL, 50000.00, 'Bayar sametan ka bu rosa', 1, '2025-04-19 10:50:40', '2025-04-19 10:50:40'),
(554, '2025-04-19', 'pengeluaran', 3, 10, NULL, 85000.00, 'Melunasi rompi sekolah', 1, '2025-04-19 10:51:15', '2025-04-19 10:51:15'),
(555, '2025-04-19', 'pengeluaran', 3, 5, NULL, 87176.00, 'Bayar listrik', 1, '2025-04-19 10:52:26', '2025-04-19 10:52:26'),
(556, '2025-04-19', 'pengeluaran', 3, 4, NULL, 50000.00, 'Bensin', 1, '2025-04-19 10:52:59', '2025-04-19 10:52:59'),
(557, '2025-04-19', 'pengeluaran', 3, 7, NULL, 23000.00, 'Kopi roko di rumah sakit', 1, '2025-04-19 10:53:22', '2025-04-19 10:53:22'),
(558, '2025-04-19', 'pengeluaran', 3, 12, NULL, 41000.00, 'Roko untuk pak ipur', 1, '2025-04-19 10:53:51', '2025-04-19 10:54:22'),
(559, '2025-04-19', 'pengeluaran', 3, 7, NULL, 12000.00, 'Rokok humer', 1, '2025-04-19 10:54:52', '2025-04-19 10:54:52'),
(560, '2025-04-19', 'pengeluaran', 3, 1, NULL, 50000.00, 'Mayar sametan ka mamah', 1, '2025-04-19 10:59:20', '2025-04-19 10:59:20'),
(561, '2025-04-19', 'pindah', 3, 11, 4, 100000.00, 'Untuk jaga - jaga', 1, '2025-04-19 11:04:28', '2025-04-19 11:04:28'),
(562, '2025-04-19', 'pengeluaran', 3, 3, NULL, 4000.00, 'Jajan ghania albi', 1, '2025-04-19 11:04:50', '2025-04-19 11:04:50'),
(563, '2025-04-19', 'pengeluaran', 3, 1, NULL, 11000.00, 'Rokok dan kopi haqqi', 1, '2025-04-19 11:05:33', '2025-04-19 11:05:33'),
(564, '2025-04-20', 'pengeluaran', 3, 1, NULL, 1000.00, 'Antisep', 1, '2025-04-20 01:42:14', '2025-04-20 01:42:14'),
(565, '2025-04-20', 'pengeluaran', 3, 2, NULL, 2500.00, 'Telur', 1, '2025-04-20 01:42:32', '2025-04-20 01:42:32'),
(566, '2025-04-20', 'pengeluaran', 3, 6, NULL, 1500.00, 'Cireng', 1, '2025-04-20 01:42:50', '2025-04-20 01:42:50'),
(567, '2025-04-20', 'pengeluaran', 3, 7, NULL, 5000.00, 'Roko', 1, '2025-04-20 06:16:39', '2025-04-20 06:16:39'),
(568, '2025-04-20', 'pengeluaran', 3, 2, NULL, 4500.00, 'Tempe gula', 1, '2025-04-20 06:16:55', '2025-04-20 06:16:55'),
(569, '2025-04-20', 'pengeluaran', 3, 6, NULL, 4000.00, 'Mie', 1, '2025-04-20 06:17:12', '2025-04-20 06:17:12'),
(570, '2025-04-20', 'pengeluaran', 3, 1, NULL, 500.00, 'Sampo', 1, '2025-04-20 06:17:28', '2025-04-20 06:17:28'),
(571, '2025-04-20', 'pengeluaran', 3, 3, NULL, 1000.00, 'Rania', 1, '2025-04-20 06:17:55', '2025-04-20 06:17:55'),
(572, '2025-04-20', 'pengeluaran', 3, 3, NULL, 2000.00, 'Ghania', 1, '2025-04-20 23:57:07', '2025-04-20 23:57:07'),
(573, '2025-04-21', 'pengeluaran', 3, 10, NULL, 10000.00, 'Nabung', 1, '2025-04-21 00:53:55', '2025-04-21 01:13:27'),
(574, '2025-04-21', 'pengeluaran', 3, 3, NULL, 4000.00, 'Bekel ghania', 1, '2025-04-21 00:54:12', '2025-04-21 01:48:13'),
(575, '2025-04-21', 'pengeluaran', 3, 3, NULL, 2000.00, 'Albi', 1, '2025-04-21 01:13:45', '2025-04-21 01:13:45'),
(576, '2025-04-21', 'pengeluaran', 3, 10, NULL, 40000.00, 'Spp', 1, '2025-04-21 01:48:32', '2025-04-21 01:48:32'),
(577, '2025-04-21', 'pengeluaran', 3, 3, NULL, 2000.00, 'Rania', 1, '2025-04-21 01:48:51', '2025-04-21 03:16:08'),
(578, '2025-04-21', 'pengeluaran', 3, 2, NULL, 11000.00, 'Bawang berem 1/4', 1, '2025-04-21 01:56:28', '2025-04-21 01:56:28'),
(579, '2025-04-21', 'pengeluaran', 3, 2, NULL, 5000.00, 'Bawang bodas 1ons', 1, '2025-04-21 01:56:50', '2025-04-21 01:56:50'),
(580, '2025-04-21', 'pengeluaran', 3, 2, NULL, 9000.00, 'Royco', 1, '2025-04-21 01:57:05', '2025-04-21 01:57:05'),
(581, '2025-04-21', 'pengeluaran', 3, 2, NULL, 20000.00, 'Kecap bango 540gr', 1, '2025-04-21 01:57:29', '2025-04-21 01:57:29'),
(582, '2025-04-21', 'pengeluaran', 3, 1, NULL, 5000.00, 'Pasta gigi anak', 1, '2025-04-21 01:58:04', '2025-04-21 01:58:04'),
(583, '2025-04-21', 'pengeluaran', 3, 1, NULL, 2000.00, 'Sampo bardk', 1, '2025-04-21 01:58:19', '2025-04-21 01:58:19'),
(584, '2025-04-21', 'pengeluaran', 3, 1, NULL, 10000.00, 'Mama lemon 680ml', 1, '2025-04-21 01:58:42', '2025-04-21 01:58:42'),
(585, '2025-04-21', 'pengeluaran', 3, 1, NULL, 18000.00, 'Daia 1kg', 1, '2025-04-21 01:59:00', '2025-04-21 01:59:00'),
(586, '2025-04-21', 'pengeluaran', 3, 2, NULL, 11500.00, 'Rencang', 1, '2025-04-21 02:35:56', '2025-04-21 02:35:56'),
(587, '2025-04-21', 'pengeluaran', 3, 2, NULL, 1000.00, 'Cengek', 1, '2025-04-21 03:16:37', '2025-04-21 03:16:37'),
(588, '2025-04-21', 'pengeluaran', 3, 6, NULL, 1500.00, 'Tth', 1, '2025-04-21 03:16:57', '2025-04-21 03:16:57'),
(589, '2025-04-21', 'pengeluaran', 3, 2, NULL, 26000.00, 'Gas+buruh', 1, '2025-04-21 03:52:30', '2025-04-21 03:52:30'),
(590, '2025-04-21', 'pemasukan', 3, 9, NULL, 300000.00, 'Honor ujikom', 1, '2025-04-21 09:22:41', '2025-04-21 09:22:41'),
(591, '2025-04-21', 'pengeluaran', 3, 7, NULL, 16000.00, 'Roko', 1, '2025-04-21 09:22:54', '2025-04-21 09:22:54'),
(592, '2025-04-21', 'pengeluaran', 3, 6, NULL, 5000.00, 'Batagor', 1, '2025-04-21 23:14:40', '2025-04-21 23:14:40'),
(593, '2025-04-21', 'pengeluaran', 3, 3, NULL, 4000.00, 'Ghania albi', 1, '2025-04-21 23:14:58', '2025-04-21 23:14:58'),
(594, '2025-04-21', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-21 23:15:13', '2025-04-21 23:15:13'),
(595, '2025-04-22', 'pengeluaran', 3, 2, NULL, 2500.00, 'Telur', 1, '2025-04-21 23:15:51', '2025-04-21 23:15:51'),
(596, '2025-04-22', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-21 23:16:08', '2025-04-21 23:16:08'),
(597, '2025-04-22', 'pengeluaran', 3, 10, NULL, 5000.00, 'Nabung', 1, '2025-04-22 00:51:44', '2025-04-22 00:51:44'),
(598, '2025-04-22', 'pengeluaran', 3, 3, NULL, 5000.00, 'Bekel ghania', 1, '2025-04-22 00:52:00', '2025-04-22 00:52:00'),
(599, '2025-04-22', 'pengeluaran', 3, 2, NULL, 68000.00, 'Minyak 4leter', 1, '2025-04-22 01:19:48', '2025-04-22 01:19:48'),
(600, '2025-04-22', 'pengeluaran', 3, 2, NULL, 18000.00, 'Kurupuk udang 1kg', 1, '2025-04-22 01:20:08', '2025-04-22 01:20:08'),
(601, '2025-04-22', 'pengeluaran', 3, 10, NULL, 5000.00, 'Buku garis', 1, '2025-04-22 02:33:16', '2025-04-22 02:33:16'),
(603, '2025-04-22', 'pengeluaran', 3, 6, NULL, 5000.00, 'Baso', 1, '2025-04-22 02:45:49', '2025-04-22 02:45:49'),
(604, '2025-04-22', 'pengeluaran', 3, 6, NULL, 1000.00, 'Minuman', 1, '2025-04-22 03:04:47', '2025-04-22 03:04:47'),
(605, '2025-04-22', 'pengeluaran', 3, 10, NULL, 100000.00, 'Foto wisuda', 1, '2025-04-22 04:12:52', '2025-04-22 04:12:52'),
(606, '2025-04-22', 'pengeluaran', 3, 2, NULL, 19500.00, 'Rencang', 1, '2025-04-22 08:39:00', '2025-04-22 08:39:00'),
(607, '2025-04-22', 'pengeluaran', 3, 6, NULL, 2000.00, 'Basreng', 1, '2025-04-22 08:39:14', '2025-04-22 08:39:14'),
(608, '2025-04-22', 'pindah', 3, 11, 4, 200000.00, 'Pindah', 1, '2025-04-22 10:56:39', '2025-04-22 10:56:39'),
(609, '2025-04-22', 'pengeluaran', 4, 7, NULL, 8500.00, 'Roko', 1, '2025-04-22 10:56:58', '2025-04-22 10:56:58'),
(610, '2025-04-22', 'pengeluaran', 3, 7, NULL, 5500.00, 'Mie kopi', 1, '2025-04-22 17:07:02', '2025-04-22 17:07:02'),
(611, '2025-04-22', 'pengeluaran', 3, 6, NULL, 4500.00, 'Mie kurupuk', 1, '2025-04-22 17:07:21', '2025-04-22 17:07:21'),
(612, '2025-04-22', 'pengeluaran', 4, 3, NULL, 500.00, 'Albi', 1, '2025-04-22 17:07:45', '2025-04-22 17:07:45'),
(613, '2025-04-23', 'pengeluaran', 3, 10, NULL, 5000.00, 'Nabung', 1, '2025-04-23 01:07:52', '2025-04-23 01:07:52'),
(614, '2025-04-23', 'pengeluaran', 3, 3, NULL, 3000.00, 'Bekel ghania', 1, '2025-04-23 01:08:09', '2025-04-23 01:08:09'),
(615, '2025-04-23', 'pengeluaran', 4, 3, NULL, 1000.00, 'Ghania', 1, '2025-04-23 01:08:27', '2025-04-23 01:08:27'),
(616, '2025-04-23', 'pengeluaran', 4, 10, NULL, 10000.00, 'Print kertas jeruk 4 lembar', 1, '2025-04-23 03:22:48', '2025-04-23 03:22:48'),
(617, '2025-04-23', 'pengeluaran', 4, 7, NULL, 20500.00, 'Kopi rokok', 1, '2025-04-23 03:38:46', '2025-04-23 03:38:46'),
(620, '2025-04-23', 'pengeluaran', 4, 10, NULL, 3000.00, 'Pulpen', 1, '2025-04-23 03:53:10', '2025-04-23 03:53:10'),
(621, '2025-04-23', 'pengeluaran', 4, 7, NULL, 4000.00, 'Kopi', 1, '2025-04-23 03:54:32', '2025-04-23 03:54:32'),
(622, '2025-04-23', 'pengeluaran', 4, 10, NULL, 157000.00, 'Jilid skripsi', 1, '2025-04-23 07:37:10', '2025-04-23 07:37:10'),
(623, '2025-04-23', 'pengeluaran', 4, 7, NULL, 13000.00, 'Makan diwarung abah', 1, '2025-04-23 07:37:55', '2025-04-23 07:37:55'),
(624, '2025-04-24', 'pengeluaran', 3, 7, NULL, 4000.00, 'Kopi', 1, '2025-04-24 00:45:49', '2025-04-24 00:45:49'),
(625, '2025-04-24', 'pengeluaran', 3, 10, NULL, 5000.00, 'Nabung', 1, '2025-04-24 01:23:31', '2025-04-24 01:23:31'),
(626, '2025-04-24', 'pengeluaran', 3, 3, NULL, 3000.00, 'Bekel ghania', 1, '2025-04-24 01:23:47', '2025-04-24 01:23:47'),
(627, '2025-04-23', 'pengeluaran', 3, 2, NULL, 2500.00, 'Telur', 1, '2025-04-24 01:50:13', '2025-04-24 01:50:13'),
(628, '2025-04-23', 'pengeluaran', 3, 2, NULL, 5000.00, 'Jengkol', 1, '2025-04-24 01:50:27', '2025-04-24 01:50:27'),
(629, '2025-04-23', 'pengeluaran', 3, 2, NULL, 2000.00, 'Cengek', 1, '2025-04-24 01:50:41', '2025-04-24 01:52:03'),
(630, '2025-04-23', 'pengeluaran', 3, 1, NULL, 1000.00, 'Sampo', 1, '2025-04-24 01:50:56', '2025-04-24 01:52:14'),
(631, '2025-04-23', 'pengeluaran', 3, 6, NULL, 3000.00, 'Jjn', 1, '2025-04-24 01:51:16', '2025-04-24 01:51:16'),
(632, '2025-04-23', 'pengeluaran', 3, 12, NULL, 4000.00, 'Voucher', 1, '2025-04-24 01:51:33', '2025-04-24 01:51:33'),
(633, '2025-04-23', 'pengeluaran', 3, 2, NULL, 2000.00, 'Gula berem', 1, '2025-04-24 01:51:49', '2025-04-24 01:51:49'),
(634, '2025-04-23', 'pengeluaran', 3, 6, NULL, 2000.00, 'Seblk', 1, '2025-04-24 01:52:53', '2025-04-24 01:52:53'),
(635, '2025-04-23', 'pengeluaran', 3, 2, NULL, 5500.00, 'Kacang', 1, '2025-04-24 01:53:07', '2025-04-24 01:53:07'),
(636, '2025-04-23', 'pengeluaran', 3, 3, NULL, 2000.00, 'Albi', 1, '2025-04-24 01:53:24', '2025-04-24 01:53:24'),
(637, '2025-04-24', 'pengeluaran', 3, 6, NULL, 5000.00, 'Cilok', 1, '2025-04-24 05:55:33', '2025-04-24 05:55:33'),
(638, '2025-04-24', 'pengeluaran', 3, 3, NULL, 2000.00, 'Ghania', 1, '2025-04-24 05:55:54', '2025-04-24 05:55:54'),
(639, '2025-04-24', 'pemasukan', 4, 9, NULL, 50000.00, 'Pasang spanduk', 1, '2025-04-24 09:50:47', '2025-04-24 09:50:47'),
(640, '2025-04-24', 'pengeluaran', 4, 7, NULL, 12000.00, 'Rokok Humer', 1, '2025-04-24 09:51:08', '2025-04-24 09:51:08'),
(642, '2025-04-24', 'pengeluaran', 3, 2, NULL, 5000.00, 'Telur 2', 1, '2025-04-24 10:08:40', '2025-04-24 10:08:40'),
(643, '2025-04-24', 'pengeluaran', 3, 12, NULL, 4000.00, 'Voucher Wi-Fi', 1, '2025-04-24 10:08:59', '2025-04-24 10:08:59'),
(644, '2025-04-25', 'pengeluaran', 3, 3, NULL, 2000.00, 'Bekel ghania', 1, '2025-04-25 02:12:37', '2025-04-25 02:12:37'),
(645, '2025-04-25', 'pengeluaran', 3, 2, NULL, 3500.00, 'Mie (bekel ghania)', 1, '2025-04-25 02:12:59', '2025-04-25 02:12:59'),
(646, '2025-04-25', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-25 02:13:11', '2025-04-25 02:13:11'),
(647, '2025-04-25', 'pengeluaran', 3, 2, NULL, 13000.00, 'Rencang', 1, '2025-04-25 02:15:14', '2025-04-25 02:15:14'),
(648, '2025-04-25', 'pengeluaran', 3, 6, NULL, 500.00, 'Cireng', 1, '2025-04-25 05:27:11', '2025-04-25 05:27:11'),
(649, '2025-04-25', 'pengeluaran', 4, 6, NULL, 2000.00, 'Cireng', 1, '2025-04-25 05:27:30', '2025-04-25 05:27:30'),
(650, '2025-04-25', 'pengeluaran', 3, 7, NULL, 5000.00, 'Kopi+batagor', 1, '2025-04-25 05:27:49', '2025-04-25 05:27:49'),
(651, '2025-04-25', 'pengeluaran', 3, 3, NULL, 6000.00, 'Ghania Albi rania', 1, '2025-04-25 10:55:31', '2025-04-25 10:55:31'),
(652, '2025-04-25', 'pengeluaran', 3, 6, NULL, 4000.00, 'Cilok', 1, '2025-04-25 10:55:44', '2025-04-25 10:55:44'),
(653, '2025-04-26', 'pengeluaran', 4, 7, NULL, 20000.00, 'Kopi roko', 1, '2025-04-26 03:26:58', '2025-04-26 03:26:58'),
(654, '2025-04-26', 'pengeluaran', 3, 2, NULL, 13000.00, 'Rencang', 1, '2025-04-26 10:41:59', '2025-04-26 10:41:59'),
(655, '2025-04-26', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-26 10:42:18', '2025-04-26 10:42:18'),
(656, '2025-04-26', 'pengeluaran', 3, 6, NULL, 3000.00, 'Cilok', 1, '2025-04-26 10:42:35', '2025-04-26 10:42:35'),
(657, '2025-04-26', 'pengeluaran', 3, 3, NULL, 2000.00, 'Rania', 1, '2025-04-26 10:42:50', '2025-04-26 10:42:50'),
(658, '2025-04-26', 'pengeluaran', 3, 12, NULL, 4000.00, 'Voucher', 1, '2025-04-26 10:43:09', '2025-04-26 10:43:09'),
(659, '2025-04-26', 'pengeluaran', 3, 6, NULL, 3000.00, 'Batagor', 1, '2025-04-26 10:43:25', '2025-04-26 10:43:25'),
(660, '2025-04-26', 'pindah', 3, 11, 5, 63000.00, 'Anu teh neneng', 1, '2025-04-26 10:45:44', '2025-04-26 10:45:44'),
(661, '2025-04-27', 'pengeluaran', 3, 5, NULL, 20824.00, 'Paket (dewi)', 1, '2025-04-26 22:58:51', '2025-04-26 22:58:51'),
(662, '2025-04-27', 'pengeluaran', 3, 2, NULL, 21500.00, 'Rencang', 1, '2025-04-27 23:33:15', '2025-04-27 23:33:15'),
(663, '2025-04-27', 'pengeluaran', 3, 1, NULL, 1000.00, 'Sabun colek', 1, '2025-04-27 23:33:32', '2025-04-27 23:33:32'),
(664, '2025-04-27', 'pengeluaran', 3, 7, NULL, 2000.00, 'Kopi', 1, '2025-04-27 23:33:48', '2025-04-27 23:33:48');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Irawan Kilmer', 'irawankillmer@gmail.com', NULL, '$2y$12$/cCMzz1G.N1OYRu.QiinA.ZBf9Ui4tQYQd52Ynm/.Ote/HmPwjpna', 'hIfwIHCnE8h2iUf2SlZOARcU1GHbY4lzd6xUou6F23ugW2Qg1jbiTPKh8EWS', '2025-03-15 15:01:27', '2025-03-15 15:01:27');

-- --------------------------------------------------------

--
-- Struktur dari tabel `yearly_reports`
--

CREATE TABLE `yearly_reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `year` year(4) NOT NULL,
  `total_income` decimal(15,2) NOT NULL,
  `total_expense` decimal(15,2) NOT NULL,
  `net_balance` decimal(15,2) NOT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`details`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accounts_name_unique` (`name`);

--
-- Indeks untuk tabel `balances`
--
ALTER TABLE `balances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `balances_account_id_foreign` (`account_id`);

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_name_unique` (`name`);

--
-- Indeks untuk tabel `daily_reports`
--
ALTER TABLE `daily_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `monthly_reports`
--
ALTER TABLE `monthly_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_account_id_foreign` (`account_id`),
  ADD KEY `transactions_category_id_foreign` (`category_id`),
  ADD KEY `transactions_target_account_id_foreign` (`target_account_id`),
  ADD KEY `transactions_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indeks untuk tabel `yearly_reports`
--
ALTER TABLE `yearly_reports`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `balances`
--
ALTER TABLE `balances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `daily_reports`
--
ALTER TABLE `daily_reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `monthly_reports`
--
ALTER TABLE `monthly_reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=665;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `yearly_reports`
--
ALTER TABLE `yearly_reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `balances`
--
ALTER TABLE `balances`
  ADD CONSTRAINT `balances_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transactions_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transactions_target_account_id_foreign` FOREIGN KEY (`target_account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
