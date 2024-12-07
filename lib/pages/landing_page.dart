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
        title: Text('Aceh Ticket Travel'),
        centerTitle: true,
      ),
      body: Center(
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPenumpang()),
                  );
                },
                child: Text('LOGIN sebagai PENUMPANG'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
