import 'package:flutter/material.dart';
import '../accounts/login_penumpang.dart';
import '../accounts/login_sopir.dart';
import '../accounts/regis_page.dart';

class LandingPage extends StatelessWidget {
  final List<Map<String, String>> tiket = [
    {'gambar': 'assets/img/hiace_putih.png'},
    {'gambar': 'assets/img/hiace_modern.png'},
    {'gambar': 'assets/img/hiace_coklat.png'},
  ];

// Fungsi untuk menampilkan dialog info pengembang
  void _showDeveloperInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tentang Pengembang',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center), // Mengatur agar title terpusat
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Pusatkan semua konten
              children: [
                // Deskripsi aplikasi
                Center(
                  child: Image.network(
                    'https://cdn.icon-icons.com/icons2/12/PNG/256/travel_car_BMV_1741.png', // Logo aplikasi
                    width: 100,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'ACEH TICKET TRAVEL CAR (ATTC)\n\nSistem Pemesanan Tiket Travel Mobil adalah aplikasi mobile yang memudahkan pengguna untuk memesan tiket perjalanan dengan mobil angkutan.',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.center, // Pusatkan teks
                ),
                SizedBox(height: 16),
                const Text(
                  'Fitur Utama:\n~ Pesan Tiket Online\n~ Hindari Pungli',
                  style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                      letterSpacing: 1.2,
                      wordSpacing: 1.2,
                      height: 1.5),
                  textAlign: TextAlign.center, // Pusatkan teks
                ),
                SizedBox(height: 16),
                SizedBox(height: 8),
                Text(
                  'Anggota Proyek:\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Table(
                  columnWidths: {0: FixedColumnWidth(50)},
                  children: [
                    TableRow(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://avatars.githubusercontent.com/u/120408238?v=4'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('TEUNGKU ZULKIFLI',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Manajer Proyek'),
                          ],
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://avatars.githubusercontent.com/u/112492742?v=4'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Muhammad Yusuf',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Desainer UI/UX'),
                          ],
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://avatars.githubusercontent.com/u/112504032?v=4'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Muhammad Rizana Fajri',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Desainer UI/UX'),
                          ],
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://avatars.githubusercontent.com/u/112678307?v=4'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ahmad Maulidi',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Pengembang Backend'),
                          ],
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://avatars.githubusercontent.com/u/112515424?v=4'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('MHD ZULKHAIRI',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Pengembang Frontend'),
                          ],
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://avatars.githubusercontent.com/u/160695745?v=4'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rahmat Hidayat',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Pengembang Database'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Teknologi yang Digunakan:\n~ Flutter\n~ MYSQL',
                  style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                      letterSpacing: 1.2,
                      wordSpacing: 1.2,
                      height: 1.5),
                  textAlign: TextAlign.center, // Pusatkan teks
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aceh Ticket Travel Car 🚙',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24, // Ukuran font disesuaikan
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF6B21A8), // Ungu Tua
        elevation: 5,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _showDeveloperInfo(context); // Menampilkan dialog info pengembang
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6B21A8),
              Color(0xFFF472B6)
            ], // Gradasi Ungu Tua ke Merah Muda
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 180,
                  child: PageView(
                    children: tiket.map((t) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            t['gambar']!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Selamat Datang di Aceh Ticket Travel',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Warna teks putih
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPenumpang()),
                    );
                  },
                  child: Text(
                    'LOGIN sebagai PENUMPANG',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF472B6), // Merah Muda
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Sudut membulat kecil
                    ),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginSopir()),
                    );
                  },
                  child: Text(
                    'LOGIN sebagai SOPIR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6B21A8), // Ungu Tua
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisPage()),
                    );
                  },
                  child: Text(
                    'BELUM PUNYA AKUN? DAFTAR',
                    style: TextStyle(
                      fontSize: 16,
                      backgroundColor: Colors.transparent,
                      color: Colors.white, // Warna teks putih
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2, // Spasi antar huruf
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
