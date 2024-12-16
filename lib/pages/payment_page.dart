import 'package:flutter/material.dart';
// import '../screens/profile_pelanggan.dart';

class PaymentPage extends StatelessWidget {
  final int ticketId; // Menyimpan id tiket

  const PaymentPage({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Pembayaran'),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  // Menampilkan gambar QR Code yang ada di assets
                  Image.asset(
                    'assets/img/qrcode_github.com.png', // Gambar QR Code di folder assets
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Scan QR Code untuk melakukan pembayaran',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
