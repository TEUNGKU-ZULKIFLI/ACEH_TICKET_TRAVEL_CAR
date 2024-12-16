import 'package:flutter/material.dart';
import '../accounts/login_penumpang.dart';
import '../accounts/login_sopir.dart';
import '../accounts/regis_page.dart';

class LandingPage extends StatelessWidget {
  final List<Map<String, String>> tiket = [
    {'gambar': 'assets/img/hiace_putih.png'},
    {'gambar': 'assets/img/hiace_modern.png'},
    {'gambar': 'assets/img/hiace_coklat.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aceh Ticket Travel Car 🚙',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white, // White for better visibility
            )),
        centerTitle: true,
        backgroundColor: Color(0xFF6B21A8), // Ungu Tua
        elevation: 5,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // Add action for information button
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6B21A8),
              Color(0xFFF472B6)
            ], // Gradasi Ungu Tua ke Merah Muda
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  child: PageView(
                    children: tiket.map((t) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            t['gambar']!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Selamat Datang di Aceh Ticket Travel',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Make text white for contrast
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPenumpang()),
                    );
                  },
                  child: Text('LOGIN sebagai PENUMPANG'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF472B6), // Merah Muda
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginSopir()),
                    );
                  },
                  child: Text('LOGIN sebagai SOPIR'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6B21A8), // Ungu Tua
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisPage()),
                    );
                  },
                  child: Text(
                    'BELUM PUNYA AKUN ? DAFTAR',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // White for better visibility
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
