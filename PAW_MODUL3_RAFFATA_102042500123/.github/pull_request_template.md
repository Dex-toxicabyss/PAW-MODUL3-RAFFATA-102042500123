## Ringkasan Perubahan
Jelaskan perubahan apa saja yang dilakukan pada Pull Request ini dan alasan perubahannya.

## Issue Terkait
Closes #(nomor_issue)

## Daftar File yang Diubah (Layer MVC)
- [ ] **Models** (`Buku.php`, `Anggota.php`, `Peminjaman.php`)
- [ ] **Routes & Controllers** (`web.php`, `BukuController.php`, `AnggotaController.php`, `PeminjamanController.php`)
- [ ] **Blade Views** (`buku/create.blade.php`, `peminjaman/create.blade.php`, `peminjaman/index.blade.php`)
- [ ] **Dokumentasi / Konfigurasi** (`README.md`, `CONTRIBUTING.md`, `.gitignore`)

## Checklist Verifikasi Sebelum Merge
- [ ] Tidak ada file `.env`, `/vendor`, atau kredensial rahasia yang ikut ter-*commit*
- [ ] `php artisan route:list` berjalan tanpa galat
- [ ] `php artisan test` lulus 100% (`SistemPeminjamanBukuTest`)
- [ ] Tampilan antarmuka telah diuji pada browser (`http://127.0.0.1:8000`)
