import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> tickets = [
    {
      'image': 'assets/img/hiace_modern.png',
      'title': 'Mobil-Hiace',
      'price': 'Rp 100.000'
      
    },
    {
      'image': 'assets/img/hiace_coklat.png',
      'title': 'Travel ke Kota B',
      'price': 'Rp 120.000'
    },
    {
      'image': 'assets/img/hiace_putih.png',
      'title': 'Travel ke Kota C',
      'price': 'Rp 150.000'
    },
  ];

  String searchQuery = '';
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

  @override
  Widget build(BuildContext context) {
    final filteredTickets = tickets.where((ticket) {
      return ticket['title']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tiket Yusuf'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pencarian Tiket
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

            SizedBox(height: 10),

            // Gambar iklan mobil
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  return Container(
                    width: 160,
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
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Image.asset(
                            ticket['image']!,
                            width: 160,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black54,
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ticket['title']!,
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ticket['price']!,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10),

            // Daftar Tiket
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
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          ticket['image']!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        ticket['title']!,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        ticket['price']!,
                        style: TextStyle(fontSize: 16, color: Colors.green),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Navigasi ke layar pemesanan tiket
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingScreen(
                                title: ticket['title']!,
                                price: ticket['price']!,
                                originCity: selectedOriginCity,
                                destinationCity: selectedDestinationCity,
                                seats: selectedSeats,
                              ),
                            ),
                          );
                        },
                        child: Text('Pesan'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
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

class BookingScreen extends StatelessWidget {
  final String title;
  final String price;
  final String originCity;
  final String destinationCity;
  final int seats;

  BookingScreen({
    required this.title,
    required this.price,
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
            Text(
              'Detail Pemesanan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Judul: $title', style: TextStyle(fontSize: 18)),
            Text('Harga: $price', style: TextStyle(fontSize: 18)),
            Text('Kota Asal: $originCity', style: TextStyle(fontSize: 18)),
            Text('Kota Tujuan: $destinationCity', style: TextStyle(fontSize: 18)),
            Text('Jumlah Kursi: $seats', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Tindakan ketika tombol 'Pesan Sekarang' ditekan
                  _showConfirmationDialog(context);
                },
                child: Text('Pesan Sekarang'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Pemesanan"),
          content: Text('Apakah Anda yakin ingin memesan tiket ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                // Logika pemesanan tiket bisa ditambahkan di sini
                Navigator.of(context).pop();
                _showSuccessDialog(context);
              },
              child: Text("Konfirmasi"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pemesanan Berhasil"),
          content: Text('Tiket Anda telah dipesan!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
