import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../pages/payment_page.dart'; // Import PaymentPage

class SeatSelectionPage extends StatefulWidget {
  final int ticketId; // Menambahkan parameter ticketId untuk referensi tiket

  const SeatSelectionPage({super.key, required this.ticketId});

  Future<void> saveTransaction(
      BuildContext context, int userId, int ticketId, int seatNumber) async {
    final url = Uri.parse(
        'http://localhost/app_aceh_travel/tickets/create_transaction.php');
    final response = await http.post(
      url,
      body: {
        'user_id': userId.toString(),
        'ticket_id': ticketId.toString(),
        'seat_number': seatNumber.toString(),
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transaksi berhasil disimpan')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan transaksi')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal terhubung ke server')),
      );
    }
  }

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  int? selectedSeat;
  List<int> availableSeats = List.generate(15, (index) => index + 1);
  int userId = 1; // Misalnya, userId diambil dari sesi pengguna yang login

  // Fungsi untuk menyimpan transaksi
  Future<void> saveTransaction(int ticketId, int seatNumber) async {
    final url = Uri.parse(
        'http://localhost/app_aceh_travel/tickets/create_transaction.php');
    try {
      final response = await http.post(
        url,
        body: {
          'user_id': userId.toString(),
          'ticket_id': ticketId.toString(),
          'seat_number': seatNumber.toString(),
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Transaksi berhasil disimpan')),
          );
        } else {
          throw Exception('Gagal menyimpan transaksi');
        }
      } else {
        throw Exception('Gagal terhubung ke server');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void selectSeat(int seatNumber) {
    setState(() {
      selectedSeat = seatNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Kursi'),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/img/POSISI_KURSI.jpg',
                  height: 200,
                  width: 200,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pilih Kursi (Max 15 kursi)',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: availableSeats.length,
                        itemBuilder: (context, index) {
                          final seatNumber = availableSeats[index];
                          return GestureDetector(
                            onTap: () => selectSeat(seatNumber),
                            child: Container(
                              decoration: BoxDecoration(
                                color: selectedSeat == seatNumber
                                    ? Colors.blue[800]
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  seatNumber.toString(),
                                  style: TextStyle(
                                    color: selectedSeat == seatNumber
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedSeat != null) {
                    await widget.saveTransaction(
                        context, userId, widget.ticketId, selectedSeat!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PaymentPage(ticketId: widget.ticketId),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Silakan pilih kursi terlebih dahulu')),
                    );
                  }
                },
                child: Text('Pesan Kursi'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
