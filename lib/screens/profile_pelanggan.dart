import 'package:flutter/material.dart';

class ProfilePelanggan extends StatefulWidget {
  final Map<String, dynamic> user;

  const ProfilePelanggan({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePelangganState createState() => _ProfilePelangganState();
}

class _ProfilePelangganState extends State<ProfilePelanggan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PELANGGAN ${widget.user['nama']}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.person_pin_rounded, size: 200, color: Colors.black),
            Text(
              'Nama: ${widget.user['nama']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${widget.user['email']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'No HP: ${widget.user['no_hp']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Bergabung: ${widget.user['created_at']}',
              style: TextStyle(fontSize: 16),
            ),
            // Bagian 'Tiket Saya' telah dihapus untuk sementara
          ],
        ),
      ),
    );
  }
}
