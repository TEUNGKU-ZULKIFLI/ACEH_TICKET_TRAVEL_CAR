import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> tickets = [
    {
      'image': 'assets/img/hiace_modern.png',
      'title': 'Travel Lhoksemawe-Banda Aceh',
      'price': 'Rp 150.000'
    },
    {
      'image': 'assets/img/hiace_coklat.png',
      'title': 'Travel Lhoksemawe-Medan',
      'price': 'Rp 120.000'
    },
    {
      'image': 'assets/img/hiace_putih.png',
      'title': 'Travel Lhoksemawe-Langsa',
      'price': 'Rp 60.000'
    },
  ];

  String searchQuery = '';
  String selectedOriginCity = 'Pilih Kota Asal';
  String selectedDestinationCity = 'Pilih Kota Tujuan';
  int selectedSeats = 1;

  final List<String> cities = ['Kota Lhoksemawe', 'Kota Lhoksukon', 'Sigli', 'Perulak', 'Idi'];

  @override
  Widget build(BuildContext context) {
    final filteredTickets = tickets.where((ticket) {
      return ticket['title']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tiket Trevel Aceh.com'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Cari Tiket',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.search),
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
              items: cities.map<DropdownMenuItem<String>>((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),

            // Dropdown untuk memilih kota tujuan
            DropdownButton<String>(
              value: selectedDestinationCity,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDestinationCity = newValue!;
                });
              },
              items: cities.map<DropdownMenuItem<String>>((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),

            // Pilihan jumlah kursi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Jumlah Kursi: $selectedSeats'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      selectedSeats++;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (selectedSeats > 1) selectedSeats--;
                    });
                  },
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                itemCount: filteredTickets.length,
                itemBuilder: (context, index) {
                  final ticket = filteredTickets[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        ticket['image']!,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Aksi untuk kembali ke halaman utama
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(
                      originCity: selectedOriginCity,
                      destinationCity: selectedDestinationCity,
                      seats: selectedSeats,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BookingScreen extends StatelessWidget {
  final String originCity;
  final String destinationCity;
  final int seats;

  BookingScreen({
    required this.originCity,
    required this.destinationCity,
    required this.seats,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan Tiket'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kota Asal: $originCity'),
            Text('Kota Tujuan: $destinationCity'),
            Text('Jumlah Kursi: $seats'),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(),
                    ),
                  );
                },
                child: Text('Lanjut ke Pembayaran'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Metode Pembayaran:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Transfer Bank'),
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Kartu Kredit/Debit'),
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: Text('Bayar di Tempat'),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showPaymentSuccessDialog(context);
                },
                child: Text('Bayar Sekarang'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pembayaran Sukses"),
          content: Text('Pembayaran berhasil! Terima kasih telah memesan tiket.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
