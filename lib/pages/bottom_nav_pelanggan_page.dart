import 'package:aceh_ticket_travel_car/pages/loading_page.dart';
import 'package:flutter/material.dart';
import '../screens/home_pelanggan.dart';
import '../screens/profile_pelanggan.dart';

class BottomNavPelanggan extends StatefulWidget {
  final Map<String, dynamic> user;

  const BottomNavPelanggan({super.key, required this.user});
  @override
  _BottomNavPelangganState createState() => _BottomNavPelangganState();
}

class _BottomNavPelangganState extends State<BottomNavPelanggan> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = <Widget>[
      HomePelanggan(),
      ProfilePelanggan(user: widget.user),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ACEH TICKET TRAVEL 🚙',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Menebalkan teks
            fontSize: 20, // Ukuran font
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoadingPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
