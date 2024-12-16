<div align="center">

# **ACEH TICKET TRAVEL CAR (ATTC)**

<div align="center">
  <img src="https://cdn.icon-icons.com/icons2/12/PNG/256/travel_car_BMV_1741.png" alt="Sistem Pemesanan Tiket Travel Mobil">
</div>

## Deskripsi

Sistem Pemesanan Tiket Travel Mobil adalah aplikasi mobile yang memudahkan pengguna untuk memesan tiket perjalanan dengan mobil angkutan. Pengguna dapat memasukkan rute perjalanan yang diinginkan, dan sistem akan mencari apakah ada data valid dalam database. Jika ada, informasi pemesanan tiket akan ditampilkan; jika tidak, sistem akan memberi tahu bahwa tidak ada data yang sesuai.

## Anggota Proyek

| Foto                                               | Peran                                                                                     |
|----------------------------------------------------|-------------------------------------------------------------------------------------------|
| <div align="center"> ![TEUNGKU ZULKIFLI](https://avatars.githubusercontent.com/u/120408238?v=4)  <br> **TEUNGKU ZULKIFLI** </div> | **Manajer Proyek** - Bertanggung jawab untuk mengelola keseluruhan proyek dan memastikan semua berjalan sesuai rencana. |
| <div align="center"> ![Muhammad Yusuf](https://avatars.githubusercontent.com/u/112492742?v=4) <br> **Muhammad Yusuf** </div> | **Desainer UI/UX** - Mendesain antarmuka pengguna dan pengalaman pengguna yang menarik dan intuitif. |
| <div align="center"> ![Muhammad Rizana Fajri](https://avatars.githubusercontent.com/u/112504032?v=4) <br> **Muhammad Rizana Fajri** </div> | **Desainer UI/UX** - Bekerja sama dalam menciptakan desain yang estetis dan fungsional. |
| <div align="center"> ![Ahmad Maulidi](https://avatars.githubusercontent.com/u/112678307?v=4) <br> **Ahmad Maulidi** </div> | **Pengembang Backend** - Mengembangkan logika server dan integrasi basis data untuk mendukung aplikasi. |
| <div align="center"> ![MHD ZULKHAIRI](https://avatars.githubusercontent.com/u/112515424?v=4) <br> **MHD ZULKHAIRI** </div> | **Pengembang Frontend** - Bertanggung jawab untuk implementasi visual aplikasi dan interaksi pengguna. |
| <div align="center"> ![Rahmat Hidayat](https://avatars.githubusercontent.com/u/160695745?v=4) <br> **Rahmat Hidayat** </div> | **Pengembang Database** - Mengelola dan merancang struktur database yang efisien untuk aplikasi. |


## Fitur Utama
</div>

- **PESAN TIKET**: 
  - Pemesanan tiket secara online untuk menghindari pungli.

<div align="center">

## Teknologi yang Digunakan
</div>

- **Flutter**: Framework untuk membangun aplikasi mobile.
- **MYSQL**: Backend untuk autentikasi dan database.

---
<div align="center">

# **Jobdesk Tim Proyek Sistem Ticket Travel Car** 🏃🏻‍♂️‍➡️ **1 DESEMBER 2024** s/d 🎯 **11 DESEMBER 2024** 🏆
</div>

## SEMUA ANGGOTA DIWAJIBKAN MEMAHAMI DARI AWAL SISTEM (BAGAIMANA SISTEM ITU BERKERJA) HINGGA TITIK PENGHABISAN
## untuk database sudah diperbarui, monggo di unduh.

### **Catatan:**
- Setiap anggota diharapkan menyelesaikan tugas sesuai dengan deadline yang telah ditetapkan.
- Pastikan semua komponen diuji dengan baik sebelum digabungkan dalam proyek utama.
- Jika ada kendala atau pertanyaan, segera koordinasikan dengan tim melalui channel komunikasi yang disepakati.

# ⚠️UNTUK USER YANG MENJALANKANNYA DI NO [2] atau CHROME JALANKAN DENGAN PERINTAH BERIKUT :⚠️
```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"
```


<div align="center">
  <a href="https://drive.google.com/drive/folders/1k-DomrbnKNk5JaUYwuar0b0F4iCSlUSA">
    <button style="font-size: 18px; padding: 12px 24px; background-color: #007bff; color: white; border: none; border-radius: 8px; font-weight: bold; cursor: pointer; transition: background-color 0.3s ease;">
      COMPONENT DATABASE BESERTA API NYA 💾
    </button>
  </a>
</div>

## UNTUK SEPUH CODE SQL DATABASE RECOMENDED MENJALANKAN INI SAJA
```CODINGAN
-- Menghapus database jika sudah ada
DROP DATABASE IF EXISTS aceh_travel;

-- Membuat database baru
CREATE DATABASE aceh_travel;

-- Menggunakan database aceh_travel
USE aceh_travel;

-- Membuat tabel 'tickets'
CREATE TABLE tickets (
  id INT(11) NOT NULL AUTO_INCREMENT,
  kota_asal VARCHAR(100) NOT NULL,
  kota_tujuan VARCHAR(100) NOT NULL,
  tanggal DATE NOT NULL,
  waktu_berangkat VARCHAR(50) NOT NULL,
  harga DECIMAL(10,2) NOT NULL,
  jumlah_kursi INT(11) NOT NULL,
  PRIMARY KEY (id)
);

-- Membuat tabel 'users'
CREATE TABLE users (
  id INT(11) NOT NULL AUTO_INCREMENT,
  nama VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  password VARCHAR(255) NOT NULL,
  no_hp VARCHAR(15) NOT NULL,
  role ENUM('penumpang', 'sopir') NOT NULL DEFAULT 'penumpang',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY email (email)
);

-- Membuat tabel 'user_ticket_transactions'
CREATE TABLE user_ticket_transactions (
  id INT(11) NOT NULL AUTO_INCREMENT,
  user_id INT(11) NOT NULL,
  ticket_id INT(11) NOT NULL,
  seat_number INT(11) NOT NULL,
  status ENUM('pending', 'completed', 'cancelled') DEFAULT 'pending',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY user_id (user_id),
  KEY ticket_id (ticket_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE
);

-- Menampilkan struktur tabel setelah dibuat
SHOW TABLES;
```
