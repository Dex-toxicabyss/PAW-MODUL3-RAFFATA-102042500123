# 📚 PAW Modul 3 — Sistem Peminjaman Buku Perpustakaan (Laravel 12 MVC & Eloquent ORM)

[![PHP](https://img.shields.io/badge/PHP-8.2%2B-777BB4?logo=php&logoColor=white)](https://www.php.net/)
[![Laravel](https://img.shields.io/badge/Laravel-12.x-FF2D20?logo=laravel&logoColor=white)](https://laravel.com/)
[![MySQL](https://img.shields.io/badge/MySQL-db__peminjamanbuku-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3.3-7952B3?logo=bootstrap&logoColor=white)](https://getbootstrap.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## What This Does

Repositori ini merupakan implementasi lengkap **Modul 3 Praktikum Pengembangan Aplikasi Web (PAW)**: *Pengenalan Framework Laravel (Instalasi, Struktur MVC, Routing, Blade Template Engine, Migration, dan Eloquent ORM)*. Aplikasi **Sistem Peminjaman Buku Perpustakaan** ini mengelola inventaris buku, direktori anggota perpustakaan, serta transaksi peminjaman dan pengembalian buku secara *real-time* menggunakan transaksi basis data (`DB::transaction`) dan *row-level locking* (`lockForUpdate()`) agar stok buku selalu sinkron dan bebas dari *race condition*.

---

## 👤 Identitas Praktikan

| Atribut | Detail |
| :--- | :--- |
| **Nama Lengkap** | Raffata Izacky Yuargya Aletama |
| **NIM** | `102042500123` |
| **Kelas** | `S1-SI-KJ-25-02` |
| **Kode Asisten** | `MARK` |
| **Mata Kuliah** | Pengembangan Aplikasi Web (PAW) — Modul 3 |
| **Dosen Pembimbing** | Dewi Marini Umi Atmaja, S.Kom., M.Kom. |
| **Program Studi** | S1 Sistem Informasi — Fakultas Rekayasa Industri, Telkom University |
| **Nama Project** | `PAW_MODUL3_RAFFATA_102042500123` |
| **Nama Repository** | `PAW-MODUL3-RAFFATA-102042500123` |

---

## 🛠️ Tech Stack

- **Backend Framework**: Laravel 12.x (`PHP 8.2+`)
- **Database & ORM**: MySQL (`db_peminjamanbuku`) & Laravel Eloquent ORM
- **Frontend & UI**: Blade Template Engine, Bootstrap 5.3.3, Bootstrap Icons 1.11.3, Google Fonts (`Inter`)
- **Testing**: PHPUnit 11.5 (`tests/Feature/SistemPeminjamanBukuTest.php`)
- **Local Environment**: Laragon (Apache/Nginx + MySQL 8.0)

---

## 📂 Project Structure

```text
PAW_MODUL3_RAFFATA_102042500123/
├── app/
│   ├── Http/Controllers/
│   │   ├── AuthController.php          # Autentikasi sesi login & logout
│   │   ├── DashboardController.php     # Statistik kartu ringkasan & 5 transaksi terbaru
│   │   ├── BukuController.php          # CRUD Buku (TODO 5: store() & validasi stok)
│   │   ├── AnggotaController.php       # CRUD Anggota (TODO 6: store() & validasi email unik)
│   │   └── PeminjamanController.php    # Transaksi Pinjam & Kembali (TODO 7: DB::transaction)
│   └── Models/
│       ├── User.php                    # Model autentikasi pengguna/admin
│       ├── Buku.php                    # Model tabel bukum (TODO 1: $fillable)
│       ├── Anggota.php                 # Model tabel anggotas (TODO 2: $fillable)
│       └── Peminjaman.php              # Model tabel peminjamans (TODO 3: belongsTo)
├── database/
│   ├── migrations/                     # 4 file migrasi tabel (users, bukum, anggotas, peminjamans)
│   └── seeders/
│       └── DatabaseSeeder.php          # Seeder 1 akun Admin, 5 Buku, dan 5 Anggota
├── resources/views/
│   ├── layouts/app.blade.php           # Master layout (Sidebar gelap & Topbar responsif)
│   ├── dashboard.blade.php             # Halaman ringkasan statistik perpustakaan
│   ├── buku/
│   │   ├── index.blade.php             # Daftar katalog buku & indikator stok
│   │   ├── create.blade.php            # Form tambah buku (TODO 8)
│   │   └── edit.blade.php              # Form ubah data buku
│   ├── anggota/
│   │   ├── index.blade.php             # Direktori anggota perpustakaan
│   │   ├── create.blade.php            # Form registrasi anggota baru
│   │   └── edit.blade.php              # Form ubah data anggota
│   └── peminjaman/
│       ├── index.blade.php             # Riwayat transaksi & aksi kembalikan/hapus (TODO 10)
│       └── create.blade.php            # Form transaksi peminjaman buku (TODO 9)
├── routes/
│   └── web.php                         # Definisi route resource & custom route (TODO 4)
└── tests/Feature/
    └── SistemPeminjamanBukuTest.php    # 12 skenario automated feature testing
```

---

## ✅ Daftar 10 File TODO yang Diselesaikan (TODO 1–10)

Seluruh *file* bawaan *template* dijaga 100% utuh dan hanya ke-10 *file* bertanda `TODO` berikut yang dilengkapi sesuai instruksi modul:

| No | File | Lokasi Layer | Implementasi yang Dilengkapi |
| :-: | :--- | :--- | :--- |
| **1** | `app/Models/Buku.php` | Model | Mendefinisikan `$fillable = ['judul', 'penulis', 'penerbit', 'tahun_terbit', 'stok']` untuk *mass assignment* pada tabel `bukum`. |
| **2** | `app/Models/Anggota.php` | Model | Mendefinisikan `$fillable = ['nama', 'email', 'no_telp', 'alamat']` pada tabel `anggotas`. |
| **3** | `app/Models/Peminjaman.php` | Model | Menambahkan relasi Eloquent `belongsTo(Anggota::class, 'anggota_id')` dan `belongsTo(Buku::class, 'buku_id')`. |
| **4** | `routes/web.php` | Routing | Mendaftarkan `Route::resource` untuk `buku`, `anggota` (`->parameters(['anggota' => 'anggota'])`), `peminjaman`, serta `Route::put('/peminjaman/{peminjaman}/kembali', ...)->name('peminjaman.kembali')`. |
| **5** | `app/Http/Controllers/BukuController.php` | Controller | Melengkapi `store()` dengan validasi server-side dan penyimpanan `Buku::create($validated)`. |
| **6** | `app/Http/Controllers/AnggotaController.php` | Controller | Melengkapi `store()` dengan validasi keunikan email (`unique:anggotas,email`) dan `Anggota::create($validated)`. |
| **7** | `app/Http/Controllers/PeminjamanController.php` | Controller | Melengkapi `store()` menggunakan `DB::transaction`, `lockForUpdate()`, pengecekan stok, kreasi *record* berstatus `'Dipinjam'`, dan `$buku->decrement('stok')`. |
| **8** | `resources/views/buku/create.blade.php` | Blade View | Membangun *form* tambah buku ber-CSRF (`@csrf`), *binding* `old()`, dan pesan *error* `@error`. |
| **9** | `resources/views/peminjaman/create.blade.php` | Blade View | Membangun *form* peminjaman dengan `<select>` anggota, `<select>` buku (`stok > 0`), tanggal pinjam, dan rencana kembali. |
| **10** | `resources/views/peminjaman/index.blade.php` | Blade View | Menampilkan tabel transaksi dengan *eager loading* (`anggota`, `buku`), *badge* status, tombol **Kembalikan** (`@method('PUT')`), dan **Hapus** (`@method('DELETE')`). |

---

## 🚀 Getting Started (Quick Start)

### Prerequisites
- **PHP** `>= 8.2` & **Composer**
- **MySQL** `>= 8.0` (melalui Laragon / XAMPP)

### Installation

1. **Clone repositori ke direktori `www` Laragon:**
   ```bash
   git clone https://github.com/Dex-toxicabyss/PAW-MODUL3-RAFFATA-102042500123.git
   cd PAW-MODUL3-RAFFATA-102042500123
   ```

2. **Instal dependensi PHP menggunakan Composer:**
   ```bash
   composer install
   ```

3. **Salin konfigurasi environment dan buat Application Key:**
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

4. **Pastikan konfigurasi database MySQL pada `.env` mengarah ke `db_peminjamanbuku`:**
   ```env
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=db_peminjamanbuku
   DB_USERNAME=root
   DB_PASSWORD=
   ```

5. **Jalankan migrasi tabel sekaligus pengisian data awal (*Database Seeder*):**
   ```bash
   php artisan migrate:fresh --seed
   ```
   > **Catatan**: Gunakan `php artisan migrate:fresh --seed` jika Anda ingin mengulang *seeding* dari awal tanpa terkena galat `Duplicate entry 'admin@perpustakaan.com'`.

6. **Jalankan server pengembangan lokal:**
   ```bash
   php artisan serve
   ```
   Buka `http://127.0.0.1:8000` di peramban dan masuk menggunakan akun Admin bawaan:
   - **Email**: `admin@perpustakaan.com`
   - **Password**: `admin123`

---

## ⚙️ How It Works

1. **Autentikasi & Proteksi Middleware**: Semua rute manajemen perpustakaan dibungkus di dalam grup `Route::middleware('auth')` sehingga pengunjung yang belum masuk otomatis diarahkan ke `/login`.
2. **Manajemen Inventaris & Anggota**: Pustakawan dapat menambah, mengubah, dan menghapus data buku (`/buku`) maupun anggota (`/anggota`) dengan validasi *server-side* dan umpan balik *flash message* `session('success')`.
3. **Transaksi Peminjaman Atomik**: Saat pustakawan mencatat peminjaman baru di `/peminjaman/create`, `PeminjamanController@store` mengunci baris buku terkait (`lockForUpdate()`), memverifikasi `stok > 0`, menyimpan transaksi dengan status `'Dipinjam'`, dan mengurangi stok buku sebanyak `1` unit secara atomik.
4. **Pengembalian Buku Otomatis**: Saat tombol **Kembalikan** ditekan pada `/peminjaman`, metode `PeminjamanController@kembalikan` mengubah status menjadi `'Dikembalikan'`, mencatat tanggal kembali aktual (`Carbon::today()`), dan mengembalikan stok buku (`$buku->increment('stok')`).

---

## 🧪 Running Automated Tests

Proyek ini dilengkapi 12 pengujian otomatis (*Feature Tests*) di `tests/Feature/SistemPeminjamanBukuTest.php`. Untuk memverifikasi seluruh rute dan fitur sebelum melakukan *commit* atau *Pull Request*:

```bash
php artisan route:list
php artisan test
```

---

## 🤝 Contributing

Kontribusi, pelaporan *bug*, dan usulan perbaikan sangat terbuka! Silakan baca panduan lengkap di [CONTRIBUTING.md](CONTRIBUTING.md) untuk standar *branching*, format *Conventional Commits*, pemeriksaan keamanan file `.env`, serta *checklist* pengujian sebelum membuka *Pull Request*.

---

## 📄 License

Proyek ini dilisensikan di bawah [MIT License](LICENSE) — © 2026 Raffata Izacky Yuargya Aletama.
