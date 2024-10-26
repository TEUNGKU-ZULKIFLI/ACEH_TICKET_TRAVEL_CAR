import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> tickets = [
    {
      'image': 'assets/img/hiace_modern.png',
    },
    {
      'image': 'assets/img/hiace_coklat.png',
    },
    {
      'image': 'assets/img/hiace_putih.png',
    },
  ];

  String selectedOriginCity = 'Pilih Kota Asal';
  String selectedDestinationCity = 'Pilih Kota Tujuan';
  int selectedSeats = 1; // Jumlah kursi default

  final List<String> cities = [
    'Kota Lhoksemawe',
    'Kota Lhoksukon',
    'Sigli',
    'Perulak',
    'Idi'
  ];

  // Daftar kursi
  final List<int> availableSeats = List.generate(10, (index) => index + 1);

  // Daftar untuk menyimpan riwayat pembayaran
  List<Map<String, dynamic>> paymentHistory = [];

  void showPaymentScreen() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pembayaran Tiket'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Anda akan membayar untuk:'),
              Text('Dari: $selectedOriginCity'),
              Text('Ke: $selectedDestinationCity'),
              Text('Jumlah Kursi: $selectedSeats'),
              SizedBox(height: 20),
              Text('Metode Pembayaran:'),
              DropdownButton<String>(
                items: [
                  DropdownMenuItem(value: 'Kartu Kredit', child: Text('Kartu Kredit')),
                  DropdownMenuItem(value: 'Transfer Bank', child: Text('Transfer Bank')),
                  DropdownMenuItem(value: 'E-Wallet', child: Text('E-Wallet')),
                ],
                onChanged: (String? value) {
                  // Logika untuk pemilihan metode pembayaran
                },
                hint: Text('Pilih Metode Pembayaran'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Menyimpan riwayat pembayaran
                paymentHistory.add({
                  'origin': selectedOriginCity,
                  'destination': selectedDestinationCity,
                  'seats': selectedSeats,
                  'timestamp': DateTime.now().toString(),
                });

                Navigator.of(context).pop();
                // Tampilkan pesan sukses
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pembayaran berhasil!')),
                );
              },
              child: Text('Bayar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  void showPaymentHistory() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Riwayat Pembayaran'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: paymentHistory.length,
              itemBuilder: (context, index) {
                final payment = paymentHistory[index];
                return ListTile(
                  title: Text('Dari: ${payment['origin']} ke ${payment['destination']}'),
                  subtitle: Text('Jumlah Kursi: ${payment['seats']}\nTanggal: ${payment['timestamp']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.print),
                    onPressed: () {
                      // Logika untuk mencetak slip pembayaran
                      print('Slip Pembayaran:\nDari: ${payment['origin']}\nKe: ${payment['destination']}\nJumlah Kursi: ${payment['seats']}\nTanggal: ${payment['timestamp']}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Slip pembayaran dicetak!')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void showSearchResult() {
    // Tampilkan hasil pencarian tiket (untuk demonstrasi, gunakan dialog)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hasil Pencarian Tiket'),
          content: Text(
            'Dari: $selectedOriginCity\n'
            'Ke: $selectedDestinationCity\n'
            'Jumlah Kursi: $selectedSeats',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                showPaymentScreen(); // Buka layar pembayaran setelah menutup dialog
              },
              child: Text('Lanjut ke Pembayaran'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRAVEL MOBIL ACEH.COM'),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: showPaymentHistory,
            tooltip: 'Riwayat Pembayaran',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Memusatkan item secara vertikal
          crossAxisAlignment: CrossAxisAlignment.center, // Memusatkan item secara horizontal
          children: [
            // Gambar iklan yang bisa di-slide
            Container(
              height: 200,
              child: PageView(
                children: tickets.map((ticket) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        ticket['image']!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 10),

            // Dropdown untuk memilih kota asal
            DropdownButton<String>(
              value: selectedOriginCity,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOriginCity = newValue!;
                });
              },
              items: ['Pilih Kota Asal', ...cities].map<DropdownMenuItem<String>>((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),

            SizedBox(height: 10),

            // Dropdown untuk memilih kota tujuan
            DropdownButton<String>(
              value: selectedDestinationCity,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDestinationCity = newValue!;
                });
              },
              items: ['Pilih Kota Tujuan', ...cities].map<DropdownMenuItem<String>>((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),

            SizedBox(height: 10),

            // Kontrol untuk memilih jumlah kursi
            Text('Pilih Jumlah Kursi:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (selectedSeats > 1) {
                        selectedSeats--;
                      }
                    });
                  },
                ),
                Text(
                  '$selectedSeats',
                  style: TextStyle(fontSize: 24),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (selectedSeats < 10) { // Mengatur batas maksimum kursi
                        selectedSeats++;
                      }
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 10),

            // Tombol Cari
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Tampilkan hasil pencarian tiket
                  showSearchResult();
                },
                child: Text('Cari Tiket'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
