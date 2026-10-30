# ==============================================================================
# Script Otomatis Rapihin Folder & Push GitHub — PAW Modul 3 & Jurnal 3
# Target Repo : https://github.com/Dex-toxicabyss/PAW-MODUL3-RAFFATA-102042500123
# Struktur    :
#   PAW-MODUL3-RAFFATA-102042500123/
#   ├── .github/
#   ├── PAW_MODUL3_RAFFATA_102042500123/   (Modul 3 - Sistem Peminjaman Buku)
#   ├── PAW_JURNAL3_RAFFATA_102042500123/  (Jurnal 3 - CeLOE LMS)
#   ├── .gitignore
#   ├── CONTRIBUTING.md
#   ├── LICENSE
#   └── README.md
# ==============================================================================

$ErrorActionPreference = "Stop"

# Sesuaikan path folder induk tempat folder Modul 3 & Jurnal 3 berada:
$WorkspaceDir = "D:\SEMESTER 3\WEB DEV"
$RepoDir      = Join-Path $WorkspaceDir "PAW-MODUL3-RAFFATA-102042500123-REPO"
$Modul3Src    = Join-Path $WorkspaceDir "PAW_MODUL3_RAFFATA_102042500123"
$Jurnal3Src   = Join-Path $WorkspaceDir "PAW_JURNAL3_RAFFATA_102042500123"

$GitHubUser   = "Dex-toxicabyss"
$RepoName     = "PAW-MODUL3-RAFFATA-102042500123"
$RemoteUrl    = "https://github.com/$GitHubUser/$RepoName.git"

Write-Host "==> [1/6] Menyiapkan direktori repositori gabungan di: $RepoDir" -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path $RepoDir | Out-Null

# Fungsi salin project Laravel tanpa membawa folder berat (vendor, node_modules, .git) dan tanpa .env
function Copy-LaravelClean($SourcePath, $DestName) {
    if (Test-Path $SourcePath) {
        $DestPath = Join-Path $RepoDir $DestName
        Write-Host "    Menyalin $DestName (mengecualikan vendor, node_modules, .git, dan .env)..." -ForegroundColor Yellow
        $null = robocopy $SourcePath $DestPath /E /XD vendor node_modules .git /XF .env .phpunit.result.cache /NFL /NDL /NJH /NJS /NC /NS
    } else {
        Write-Host "    [INFO] Folder $SourcePath tidak ditemukan di $WorkspaceDir, lewati penyalinan." -ForegroundColor DarkGray
    }
}

Copy-LaravelClean $Modul3Src  "PAW_MODUL3_RAFFATA_102042500123"
Copy-LaravelClean $Jurnal3Src "PAW_JURNAL3_RAFFATA_102042500123"

Set-Location $RepoDir

Write-Host "==> [2/6] Menulis .gitignore agar .env dan /vendor aman & tidak pernah ter-push..." -ForegroundColor Cyan
@"
**/vendor/
**/node_modules/
**/.env
**/.env.backup
**/.phpunit.result.cache
**/storage/*.key
**/storage/logs/*.log
.DS_Store
Thumbs.db
.vscode/
.idea/
"@ | Set-Content -Path ".gitignore" -Encoding UTF8

# Jika file README_MODUL3.md ada di folder kerja, salin menjadi README.md utama
if (Test-Path (Join-Path $WorkspaceDir "README_MODUL3.md")) {
    Copy-Item (Join-Path $WorkspaceDir "README_MODUL3.md") -Destination (Join-Path $RepoDir "README.md") -Force
}

Write-Host "==> [3/6] Inisialisasi Git & Membuat Branch Kerja Sesuai Panduan Kontribusi..." -ForegroundColor Cyan
if (-not (Test-Path ".git")) {
    git init
}

# Bersihkan file .env atau vendor dari index git jika sebelumnya pernah ter-stage
git rm -r --cached **/vendor **/node_modules **/.env -ErrorAction SilentlyContinue | Out-Null

Write-Host "==> [4/6] Mengelompokkan Commit Secara Logis (Conventional Commits)..." -ForegroundColor Cyan

# Commit 1: Modul 3 (Sistem Peminjaman Buku Perpustakaan)
if (Test-Path "PAW_MODUL3_RAFFATA_102042500123") {
    git add PAW_MODUL3_RAFFATA_102042500123/
    git commit -m "feat(modul3): add Laravel 12 library borrowing CRUD system (TODO 1-10)" --allow-empty
}

# Commit 2: Jurnal 3 (CeLOE LMS Telkom University)
if (Test-Path "PAW_JURNAL3_RAFFATA_102042500123") {
    git add PAW_JURNAL3_RAFFATA_102042500123/
    git commit -m "feat(jurnal3): add CeLOE LMS course, material, and enrollment CRUD system (TODO 1-8)" --allow-empty
}

# Commit 3: Dokumentasi README, CONTRIBUTING, LICENSE, & .gitignore
git add .gitignore README.md CONTRIBUTING.md LICENSE .github/ -ErrorAction SilentlyContinue
git add .
git commit -m "docs: update README with full Modul 3 & Jurnal 3 folder structure and Docker/MySQL setup" --allow-empty

git branch -M main

Write-Host "==> [5/6] Menampilkan daftar folder & file tingkat atas yang akan di-push:" -ForegroundColor Cyan
git status -s
Get-ChildItem -Force | Select-Object Mode, Name

Write-Host "==> [6/6] Menghubungkan Remote GitHub & Push ke $RemoteUrl..." -ForegroundColor Cyan
$existingRemote = git remote
if ($existingRemote -contains "origin") {
    git remote set-url origin $RemoteUrl
} else {
    git remote add origin $RemoteUrl
}

git push -u origin main

Write-Host ""
Write-Host "Selesai! Modul 3 & Jurnal 3 berhasil di-push ke: https://github.com/$GitHubUser/$RepoName" -ForegroundColor Green
