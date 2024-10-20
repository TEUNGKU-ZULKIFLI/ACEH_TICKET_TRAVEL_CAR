import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> tickets = [
    {
      'image': 'assets/img/hiace_modern.png',
      'title': 'Travel ke Kota A',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tiket Travel'),
      ),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return Card(
            child: ListTile(
              leading: Image.asset(
                ticket['image']!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(ticket['title']!),
              subtitle: Text(ticket['price']!),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
