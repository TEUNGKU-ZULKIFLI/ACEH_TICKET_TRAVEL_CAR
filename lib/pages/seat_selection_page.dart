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
  List<int> availableSeats = [];
  int userId = 1; // ID pengguna
  bool isLoading = true;

  // Fungsi untuk mengambil kursi yang tersedia dari server
  Future<void> fetchAvailableSeats() async {
    final url = Uri.parse(
        'http://localhost/app_aceh_travel/tickets/get_available_seats.php');
    try {
      final response = await http.post(
        url,
        body: {'ticket_id': widget.ticketId.toString()},
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['success']) {
          setState(() {
            availableSeats = List<int>.from(result['available_seats']);
            isLoading = false;
          });
        } else {
          throw Exception(result['message']);
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

  // Panggil fetchAvailableSeats saat inisialisasi
  @override
  void initState() {
    super.initState();
    fetchAvailableSeats();
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
        title: const Text('PILIH KURSI 💺',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white)),
        backgroundColor: Color(0xFF6B21A8), // Warna ungu tua
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6B21A8), Color(0xFFF472B6)], // Gradasi ungu-pink
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              'assets/img/POSISI_KURSI.jpg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pilih Kursi 💺',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 16),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                                itemCount: availableSeats.length,
                                itemBuilder: (context, index) {
                                  final seatNumber = availableSeats[index];
                                  return GestureDetector(
                                    onTap: () => selectSeat(seatNumber),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedSeat == seatNumber
                                            ? Color(
                                                0xFF6B21A8) // Ungu tua untuk kursi terpilih
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color:
                                              Color(0xFF6B21A8), // Garis ungu
                                          width: 2,
                                        ),
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFF472B6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
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
                                content: Text(
                                    'Silakan pilih kursi terlebih dahulu')),
                          );
                        }
                      },
                      child: Text(
                        'Pesan Kursi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
