import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final int ticketId; // Menyimpan ID tiket

  const PaymentPage({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Halaman Pembayaran',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF6B21A8), // Warna ungu tua
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6B21A8), Color(0xFFF472B6)], // Gradien ungu-pink
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    // Menampilkan gambar QR Code dari folder assets
                    Image.asset(
                      'assets/img/qrcode_github.com.png', // Gambar QR Code
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Scan QR Code untuk melakukan pembayaran',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white, // Teks berwarna putih
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFF472B6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 12.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // Kembali ke halaman
                      },
                      child: const Text('Ke HOME 🏃🏻‍➡️🏡'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
