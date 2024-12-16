import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../pages/ticket_detail_page.dart';

class SearchResultsPage extends StatelessWidget {
  final String kotaAsal;
  final String kotaTujuan;
  final String tanggal;
  final String waktuBerangkat;

  SearchResultsPage({
    required this.kotaAsal,
    required this.kotaTujuan,
    required this.tanggal,
    required this.waktuBerangkat,
  });

  Future<List<Map<String, dynamic>>> fetchTickets() async {
    try {
      final url = Uri.parse(
          'http://localhost/app_aceh_travel/tickets/get_daftar_ticket.php'
          '?kota_asal=$kotaAsal&kota_tujuan=$kotaTujuan&tanggal=$tanggal&waktu_berangkat=$waktuBerangkat');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        } else {
          return [];
        }
      } else {
        throw Exception('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Gagal terhubung ke server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HASIL PENCARIAN 💾',
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
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchTickets(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'Tidak ada tiket ditemukan',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            final tickets = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  color: Colors.white.withOpacity(0.8),
                  child: ListTile(
                    title: Text(
                      '${ticket['kota_asal']} -> ${ticket['kota_tujuan']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF6B21A8),
                      ),
                    ),
                    subtitle: Text(
                      '${ticket['tanggal']} | ${ticket['waktu_berangkat']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Text(
                      'Rp ${ticket['harga']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TicketDetailPage(ticket: ticket),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
