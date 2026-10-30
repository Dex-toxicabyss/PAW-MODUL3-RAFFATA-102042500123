# Panduan Kontribusi (Contribution Guidelines)

Repositori ini merupakan repositori praktikum individu **Pengembangan Aplikasi Website (PAW)** milik **Raffata Izacky Yuargya Aletama** (`@Dex-toxicabyss`). Seluruh perubahan kode mengikuti alur kerja berikut agar riwayat Git dan struktur cabang (*branch*) tetap rapi.

## 1. Struktur Cabang (Branch Naming)

- Cabang utama adalah `main` dan selalu berisi kode yang stabil serta lolos uji.
- Jika mengerjakan fitur baru, perbaikan bug, atau pembaruan dokumentasi, buat cabang terpisah dari `main` dengan format:
  - `feat/<nama-fitur>` — penambahan fitur baru (contoh: `feat/filter-status-tugas`)
  - `fix/<nama-perbaikan>` — perbaikan bug atau validasi (contoh: `fix/validasi-kode-unik`)
  - `docs/<nama-dokumen>` — pembaruan dokumentasi atau `README.md`
  - `chore/<nama-tugas>` — perapian struktur berkas atau konfigurasi

```bash
git checkout -b feat/nama-fitur
```

## 2. Format Pesan Commit (Commit Messages)

Gunakan pesan commit yang singkat, jelas, dan mengelompokkan perubahan secara logis:

- `feat: ...` untuk penambahan fitur atau modul baru
- `fix: ...` untuk perbaikan bug atau penanganan error
- `docs: ...` untuk perubahan dokumentasi (`README.md`, `LICENSE`, `CONTRIBUTING.md`)
- `refactor: ...` untuk perapian kode tanpa mengubah perilaku program

## 3. Pemeriksaan Sebelum Commit / Pull Request (Prerequisites)

Sebelum melakukan *commit* atau membuat *Pull Request* ke cabang `main`, pastikan:
1. Seluruh berkas PHP bebas dari kesalahan sintaks:
   ```bash
   php -l index.php
   ```
2. Skema database (`db_modul2.sql` dan `database.sql`) dapat diimpor ulang tanpa error menggunakan `INSERT IGNORE` dan `CREATE TABLE IF NOT EXISTS`.
3. Tidak ada kredensial rahasia, kata sandi pribadi, atau berkas sementara editor (`.vscode/`, `.DS_Store`) yang ikut masuk ke dalam *commit*.

## 4. Template Issue & Pull Request

Gunakan struktur pada `.github/ISSUE_TEMPLATE/issue-template.md` saat mencatat kendala baru dan `.github/pull_request_template.md` saat mengajukan *Pull Request* (sertakan `Closes #NOMOR_ISSUE` jika menutup *issue* terkait).
