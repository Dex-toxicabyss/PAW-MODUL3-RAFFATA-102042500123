<?php

namespace Database\Seeders;

use App\Models\Assignment;
use App\Models\MataKuliah;
use App\Models\Material;
use App\Models\Submission;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Akun Pengguna LMS (1 Dosen & 1 Mahasiswa)
        // TODO 1 : Buat akun awal untuk Dosen.
        // Hint:
        // - Gunakan email sebagai identitas akun.
        // - Lengkapi nama, password yang di-hash, role Dosen,dan nomor induk.
        $dosen = User::updateOrCreate(
            ['email' => 'dosen@celoe.test'],
            [
                'name' => 'Dr. Ir. Budi Santoso, M.T.',
                'password' => Hash::make('password123'),
                'role' => 'dosen',
                'nomor_induk' => '198504122010121001',
            ]
        );

        $mahasiswa = User::updateOrCreate(
            ['email' => 'mahasiswa@celoe.test'],
            [
                'name' => 'Raffata Izacky Yuargya Aletama',
                'password' => Hash::make('password123'),
                'role' => 'mahasiswa',
                'nomor_induk' => '102042500123',
            ]
        );

        // Data Awal Mata Kuliah, Materi, Tugas, dan Enrollment
        $course = MataKuliah::updateOrCreate(
            ['kode_mk' => 'PAW'],
            [
                'nama_mk' => 'Pengembangan Aplikasi Website',
                'deskripsi' => 'Mata kuliah yang membahas arsitektur Model-View-Controller (MVC), routing, Blade templating, migrasi basis data, serta operasi CRUD relasional menggunakan framework Laravel.',
                'sks' => 3,
                'semester' => 'Ganjil 2026/2027',
                'dosen_id' => $dosen->id,
            ]
        );

        // Daftarkan mahasiswa dengan status approved
        $course->students()->syncWithoutDetaching([
            $mahasiswa->id => [
                'status' => 'approved',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);

        Material::updateOrCreate(
            [
                'course_id' => $course->id,
                'judul' => 'Modul 03 - Operasi CRUD dan Eloquent ORM pada Laravel',
            ],
            [
                'konten' => "Pokok Bahasan Minggu ke-3:\n1. Konfigurasi Database Migration & Seeder\n2. Definisi Model Eloquent, \$fillable, dan Relasi Tabel (BelongsTo, HasMany, BelongsToMany)\n3. Pembuatan Resource Controller (MataKuliahController & MaterialController)\n4. Implementasi Blade Template Engine & Validasi Form Server-Side.",
                'minggu_ke' => 3,
                'urutan' => 1,
            ]
        );

        $assignment = Assignment::updateOrCreate(
            [
                'course_id' => $course->id,
                'judul' => 'Tugas 01 - Bikin Sistem Kasir pake Laravel',
            ],
            [
                'deskripsi' => 'Buatlah aplikasi CRUD berbasis Laravel dengan menerapkan struktur MVC, validasi request, relasi Eloquent, dan Blade template sesuai instruksi Jurnal Modul 3.',
                'deadline' => now()->addDays(7)->setTime(23, 59),
            ]
        );

        Submission::updateOrCreate(
            [
                'assignment_id' => $assignment->id,
                'user_id' => $mahasiswa->id,
            ],
            [
                'jawaban' => 'Seluruh fitur CRUD Mata Kuliah, Materi Pembelajaran, dan Pengumpulan Tugas pada CeLOE LMS telah selesai diimplementasikan oleh Raffata Izacky Yuargya Aletama (102042500123).',
                'submitted_at' => now(),
            ]
        );
    }
}
