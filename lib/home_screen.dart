import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Inisialisasi Plugin Notifikasi
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

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
      'price': 'Rp 150.000'
    },
    {
      'image': 'assets/img/hiace_putih.png',
      'title': 'Travel Lhoksemawe-Langsa',
      'price': 'Rp 60.000'
    },
  ];

  // Daftar tiket favorit
  List<Map<String, String>> favoriteTickets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tiket Trevel.com'),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteScreen(favoriteTickets: favoriteTickets),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            final ticket = tickets[index];
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
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/img/placeholder.png', fit: BoxFit.cover);
                    },
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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        setState(() {
                          favoriteTickets.add(ticket);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tiket ditambahkan ke favorit!')),
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigasi ke halaman detail atau fungsi pemesanan
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailScreen(ticket: ticket)),
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Fungsi Filter Tiket
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Tiket'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Harga Terendah'),
                onTap: () {
                  setState(() {
                    tickets.sort((a, b) => int.parse(a['price']!.replaceAll(RegExp(r'[Rp .]'), '')).compareTo(
                        int.parse(b['price']!.replaceAll(RegExp(r'[Rp .]'), ''))));
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Harga Tertinggi'),
                onTap: () {
                  setState(() {
                    tickets.sort((a, b) => int.parse(b['price']!.replaceAll(RegExp(r'[Rp .]'), '')).compareTo(
                        int.parse(a['price']!.replaceAll(RegExp(r'[Rp .]'), ''))));
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// Halaman Favorit Tiket
class FavoriteScreen extends StatelessWidget {
  final List<Map<String, String>> favoriteTickets;

  FavoriteScreen({required this.favoriteTickets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tiket Favorit'),
      ),
      body: ListView.builder(
        itemCount: favoriteTickets.length,
        itemBuilder: (context, index) {
          final ticket = favoriteTickets[index];
          return ListTile(
            leading: Image.asset(ticket['image']!),
            title: Text(ticket['title']!),
            subtitle: Text(ticket['price']!),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Map<String, String> ticket;

  DetailScreen({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ticket['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(ticket['image']!),
            SizedBox(height: 20),
            Text(ticket['title']!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Harga: ${ticket['price']!}', style: TextStyle(fontSize: 20, color: Colors.green)),
            SizedBox(height: 20),
            Text('Deskripsi:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Perjalanan dari Lhoksemawe ke Banda Aceh dengan Aman & Nyaman.'),
            SizedBox(height: 20),
            Text('Fasilitas:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('AC, Kursi Nyaman'),
            SizedBox(height: 20),
            Text('Opsi Pembayaran:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Transfer Bank, Kartu Kredit, E-Wallet'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Konfirmasi Pemesanan anda'),
                      content: Text('Apakah Anda yakin ingin memesan tiket ini?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Tutup dialog
                          },
                          child: Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Logika untuk menyelesaikan pemesanan
                            Navigator.of(context).pop(); // Tutup dialog
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Pemesaanan Tiket berhasil dipesan!')),
                            );
                          },
                          child: Text('Pesan'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Pesan Tiket'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}