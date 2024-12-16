import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileSopir extends StatefulWidget {
  final Map<String, dynamic> user;

  const ProfileSopir({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileSopirState createState() => _ProfileSopirState();
}

class _ProfileSopirState extends State<ProfileSopir> {
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
          'SOPIR ${widget.user['nama']}',
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
                  'STATUS: ${widget.user['role']}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  'Bergabung: ${widget.user['created_at']}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  'Tiket Sopir',
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
