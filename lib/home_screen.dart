import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> tickets = [
    {
      'image': 'assets/img/hiace_modern.png',
      'title': 'Travel Lhoksemawe-Banda Aceh',
      'price': 'Rp 150.000'
    },
    {
      'image': 'assets/img/hiace_coklat.png',
      'title': 'Travel Lhoksemawe-Medan',
      'price': 'Rp 1500.000'
    },
    {
      'image': 'assets/img/hiace_putih.png',
      'title': 'Travel Lhoksemawe-Langsa',
      'price': 'Rp 60.000'
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tiket Trevel.Com'),
        backgroundColor: Colors.blue[800],
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
                    // Tambahkan aksi saat tombol ditekan
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
    );
  }
}