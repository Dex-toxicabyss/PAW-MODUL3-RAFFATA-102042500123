# ==============================================================================
# Script Otomatis Push GitHub — PAW Modul 3 (Raffata Izacky - 102042500123)
# Target Repo : https://github.com/Dex-toxicabyss/PAW-MODUL3-RAFFATA-102042500123
# Lokasi Lokal: C:\laragon\www\Sistem_Peminjaman_Buku
# ==============================================================================

$ErrorActionPreference = "Stop"

$ProjectDir = "C:\laragon\www\Sistem_Peminjaman_Buku"
$RepoName   = "PAW-MODUL3-RAFFATA-102042500123"
$GitHubUser = "Dex-toxicabyss"
$RemoteUrl  = "https://github.com/$GitHubUser/$RepoName.git"

Write-Host "==> [1/6] Masuk ke direktori proyek: $ProjectDir" -ForegroundColor Cyan
Set-Location $ProjectDir

Write-Host "==> [2/6] Memastikan .gitignore memproteksi .env, /vendor, dan /node_modules..." -ForegroundColor Cyan
$gitignoreEntries = @("/vendor", "/node_modules", ".env", ".env.backup", ".phpunit.result.cache")
if (-not (Test-Path ".gitignore")) {
    New-Item -ItemType File -Path ".gitignore" | Out-Null
}
$currentGitignore = Get-Content ".gitignore" -Raw
foreach ($entry in $gitignoreEntries) {
    if ($currentGitignore -notmatch [regex]::Escape($entry)) {
        Add-Content -Path ".gitignore" -Value $entry
    }
}

Write-Host "==> [3/6] Menjalankan verifikasi rute Laravel (php artisan route:list)..." -ForegroundColor Cyan
php artisan route:list

Write-Host "==> [4/6] Inisialisasi Git & Pengelompokan Commit secara Logis (Conventional Commits)..." -ForegroundColor Cyan
if (-not (Test-Path ".git")) {
    git init
}
git branch -M main

# Pastikan .env tidak pernah masuk staging
git rm --cached .env -ErrorAction SilentlyContinue | Out-Null

# Commit 1: Base project skeleton & migrations/seeders
git add .gitignore composer.json composer.lock artisan bootstrap/ config/ database/ public/ resources/css/ resources/js/ resources/views/layouts/ resources/views/auth/ resources/views/dashboard.blade.php resources/views/buku/index.blade.php resources/views/buku/edit.blade.php resources/views/anggota/ storage/ tests/ vite.config.js phpunit.xml .env.example
git commit -m "chore: initialize base Laravel 12 library borrowing project skeleton" --allow-empty

# Commit 2: TODO 1-3 (Models Layer)
git add app/Models/
git commit -m "feat(models): complete fillable attributes and belongsTo relations (TODO 1-3)" --allow-empty

# Commit 3: TODO 4-7 (Routes & Controllers Layer)
git add routes/ app/Http/
git commit -m "feat(routes,controllers): implement CRUD routes and atomic loan store logic (TODO 4-7)" --allow-empty

# Commit 4: TODO 8-10 (Blade Views Layer)
git add resources/views/buku/create.blade.php resources/views/peminjaman/
git commit -m "feat(views): build book creation, loan creation, and loan index Blade views (TODO 8-10)" --allow-empty

# Commit 5: Documentation & GitHub Contribution Templates
git add README.md CONTRIBUTING.md LICENSE .github/ -ErrorAction SilentlyContinue
git add .
git commit -m "docs: add portfolio README, CONTRIBUTING guidelines, and GitHub issue/PR templates" --allow-empty

Write-Host "==> [5/6] Memeriksa status Git (memastikan .env dan /vendor tidak ikut ter-track)..." -ForegroundColor Cyan
git status -s

Write-Host "==> [6/6] Menghubungkan ke Remote GitHub & Push ke branch main..." -ForegroundColor Cyan
$existingRemote = git remote
if ($existingRemote -contains "origin") {
    git remote set-url origin $RemoteUrl
} else {
    git remote add origin $RemoteUrl
}

# Jika GitHub CLI (gh) terinstal, buat repo publik otomatis jika belum ada
if (Get-Command gh -ErrorAction SilentlyContinue) {
    Write-Host "Mendeteksi GitHub CLI (gh), memeriksa/membuat repo $GitHubUser/$RepoName..." -ForegroundColor Yellow
    gh repo view "$GitHubUser/$RepoName" 2>$null
    if ($LASTEXITCODE -ne 0) {
        gh repo create "$GitHubUser/$RepoName" --public --description "Modul 3 Praktikum PAW — Sistem Peminjaman Buku Perpustakaan (Laravel 12 MVC & Eloquent ORM) - Raffata Izacky (102042500123)"
    }
}

git push -u origin main

Write-Host ""
Write-Host "✅ Selesai! Proyek berhasil di-push ke: https://github.com/$GitHubUser/$RepoName" -ForegroundColor Green
