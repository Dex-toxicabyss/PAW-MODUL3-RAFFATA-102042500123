# Panduan Kontribusi (Contributing Guidelines)

Terima kasih telah berkontribusi pada repositori **PAW-MODUL3-RAFFATA-102042500123** (*Sistem Peminjaman Buku Perpustakaan — Laravel 12*). Dokumen ini menjelaskan tahapan kerja standar agar setiap perubahan kode tetap bersih, aman, dan teruji.

---

## 🔒 1. Keamanan & File yang Dilarang Masuk Git

Sebelum melakukan `git add`, pastikan file sensitif dan direktori dependensi berikut **tidak pernah** ikut ter-*commit* (sudah diatur di dalam `.gitignore`):
- `.env` (berisi kredensial database dan `APP_KEY`)
- `/vendor` (dependensi Composer)
- `/node_modules` (dependensi NPM)
- `/storage/*.key`

---

## 🔍 2. Pemeriksaan Sebelum Membuat Issue atau Pull Request

1. Periksa daftar *Issues* dan *Pull Requests* yang sudah ada agar tidak terjadi duplikasi.
2. Jika menemukan *bug* atau ingin menambahkan fitur baru, buat *Issue* terlebih dahulu menggunakan templat di `.github/ISSUE_TEMPLATE/issue-template.md`.

---

## 🌿 3. Alur Branching & Conventional Commits

1. Buat *branch* baru dari `main` dengan penamaan deskriptif:
   - `feat/<nama-fitur>` — untuk penambahan fitur (contoh: `feat/modul3-crud-laravel`)
   - `fix/<nama-bug>` — untuk perbaikan *bug* (contoh: `fix/stok-decrement-lock`)
   - `docs/<topik>` — untuk pembaruan dokumentasi (contoh: `docs/readme-setup-guide`)

2. Kelompokkan *commit* secara logis berdasarkan *layer* MVC menggunakan format **Conventional Commits**:
   - `feat(models): complete fillable and belongsTo relations (TODO 1-3)`
   - `feat(routes,controllers): register CRUD routes and store logic (TODO 4-7)`
   - `feat(views): implement book and loan Blade views (TODO 8-10)`
   - `docs: add comprehensive README, CONTRIBUTING, and GitHub templates`

---

## ✅ 4. Verifikasi Wajib Sebelum Push / Pull Request

Setiap perubahan kode **wajib** lulus pemeriksaan rute dan *automated test* Laravel sebelum diajukan ke *Pull Request*:

```bash
php artisan route:list
php artisan test
```

Pastikan seluruh 12 pengujian di `tests/Feature/SistemPeminjamanBukuTest.php` berstatus **PASS** sebelum menggabungkan (*merge*) *branch* ke `main`.
