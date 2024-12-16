import 'package:aceh_ticket_travel_car/pages/loading_page.dart';
import 'package:flutter/material.dart';
import '../screens/home_sopir.dart';
import '../screens/profile_sopir.dart';

class BottomNavSopir extends StatefulWidget {
  final Map<String, dynamic> user;

  const BottomNavSopir({super.key, required this.user});
  @override
  _BottomNavSopirState createState() => _BottomNavSopirState();
}

class _BottomNavSopirState extends State<BottomNavSopir> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = <Widget>[
      HomeSopir(),
      ProfileSopir(user: widget.user),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ACEH TICKET TRAVEL CAR 🚙',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Menebalkan teks
            fontSize: 20, // Ukuran font
            color: Colors.white, // Warna teks
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
