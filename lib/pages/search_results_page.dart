import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
          title: Text('HASIL PENCARIAN 💾'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          centerTitle: true,
          backgroundColor: Colors.blue[800]),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada tiket ditemukan'));
          }

          final tickets = snapshot.data!;
          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return ListTile(
                title: Text(
                  '${ticket['kota_asal']} -> ${ticket['kota_tujuan']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  '${ticket['tanggal']} | ${ticket['waktu_berangkat']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                trailing: Text(
                  'Rp ${ticket['harga']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Detail Tiket'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Kota Asal: ${ticket['kota_asal']}'),
                          Text('Kota Tujuan: ${ticket['kota_tujuan']}'),
                          Text('Tanggal: ${ticket['tanggal']}'),
                          Text('Waktu Berangkat: ${ticket['waktu_berangkat']}'),
                          Text('Harga: Rp ${ticket['harga']}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Tutup'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
