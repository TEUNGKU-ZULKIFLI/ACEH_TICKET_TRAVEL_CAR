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
  List<Map<String, dynamic>> tickets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTickets();
  }

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
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF6B21A8),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6B21A8), Color(0xFFF472B6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 80, color: Color(0xFF6B21A8)),
                ),
                const SizedBox(height: 16),
                Text(
                  'Nama: ${widget.user['nama']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Email: ${widget.user['email']}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  'No HP: ${widget.user['no_hp']}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  'Bergabung: ${widget.user['created_at']}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  'Tiket Saya',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                isLoading
                    ? CircularProgressIndicator()
                    : tickets.isEmpty
                        ? Text(
                            'Belum ada tiket',
                            style: TextStyle(color: Colors.white),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: tickets.length,
                            itemBuilder: (context, index) {
                              final ticket = tickets[index];
                              return Card(
                                color: Colors.white.withOpacity(0.7),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: ListTile(
                                  title: Text(
                                    '${ticket['kota_asal']} ke ${ticket['kota_tujuan']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6B21A8),
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Tanggal: ${ticket['tanggal']}\n'
                                    'Waktu: ${ticket['waktu_berangkat']}\n'
                                    'Kursi: ${ticket['seat_number']}',
                                    style: TextStyle(color: Colors.black),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
