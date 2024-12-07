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

  Future<void> fetchTickets() async {
    try {
      final url = Uri.parse(
          'http://localhost/app_aceh_travel/tickets/get_user_tickets.php?user_id=${widget.user['id']}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          setState(() {
            tickets = List<Map<String, dynamic>>.from(data['tickets']);
          });
        }
      }
    } catch (e) {
      print("Error fetching tickets: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTickets();
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
              'Tiket Saya:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : tickets.isEmpty
                    ? Text('Belum ada tiket yang dipesan.')
                    : Expanded(
                        child: ListView.builder(
                          itemCount: tickets.length,
                          itemBuilder: (context, index) {
                            final ticket = tickets[index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                title: Text(
                                  '${ticket['kota_asal']} -> ${ticket['kota_tujuan']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                subtitle: Text(
                                  '${ticket['tanggal']} | ${ticket['waktu_berangkat']}',
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Rp ${ticket['harga']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                    Text(
                                      '${ticket['status'].toUpperCase()}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ticket['status'] == 'paid'
                                            ? Colors.blue
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
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
