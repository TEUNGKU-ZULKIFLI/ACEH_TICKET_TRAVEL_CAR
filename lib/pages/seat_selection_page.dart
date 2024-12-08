import 'package:flutter/material.dart';
import '../pages/payment_page.dart'; // Import PaymentPage

class SeatSelectionPage extends StatefulWidget {
  final int ticketId; // Menambahkan parameter ticketId untuk referensi tiket

  const SeatSelectionPage({super.key, required this.ticketId});

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  int? selectedSeat; // Menyimpan kursi yang dipilih
  List<int> availableSeats =
      List.generate(15, (index) => index + 1); // Daftar kursi dari 1-15

  // Fungsi untuk menangani pemilihan kursi
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
            // Tampilkan gambar posisi kursi di samping
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
                onPressed: () {
                  if (selectedSeat != null) {
                    // Setelah memilih kursi, navigasi ke halaman pembayaran
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
