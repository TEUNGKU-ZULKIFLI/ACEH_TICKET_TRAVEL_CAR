import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfilePelanggan extends StatefulWidget {
  final Map<String, dynamic> user;

  const ProfilePelanggan({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePelangganState createState() => _ProfilePelangganState();
}

class _ProfilePelangganState extends State<ProfilePelanggan> {
  List<Map<String, dynamic>> tickets = []; // Menyimpan data tiket
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTickets(); // Panggil API untuk mengambil tiket
  }

  // Fungsi untuk mengambil tiket pengguna
  Future<void> fetchTickets() async {
    final url = Uri.parse(
        'http://localhost/app_aceh_travel/tickets/get_user_tickets.php');
    try {
      final response = await http.post(
        url,
        body: {
          'user_id': widget.user['id'].toString(),
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'success') {
          setState(() {
            tickets = List<Map<String, dynamic>>.from(result['data']);
            isLoading = false;
          });
        } else {
          throw Exception('Gagal memuat data tiket');
        }
      } else {
        throw Exception('Gagal terhubung ke server');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

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
            SizedBox(height: 16),
            Text(
              'Tiket Saya',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : tickets.isEmpty
                      ? Center(child: Text('Belum ada tiket'))
                      : ListView.builder(
                          itemCount: tickets.length,
                          itemBuilder: (context, index) {
                            final ticket = tickets[index];
                            return Card(
                              child: ListTile(
                                title: Text(
                                  '${ticket['kota_asal']} ke ${ticket['kota_tujuan']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'Tanggal: ${ticket['tanggal']}\n'
                                  'Waktu: ${ticket['waktu_berangkat']}\n'
                                  'Kursi: ${ticket['seat_number']}',
                                ),
                                trailing: Text(
                                  'Rp ${ticket['harga']}',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
