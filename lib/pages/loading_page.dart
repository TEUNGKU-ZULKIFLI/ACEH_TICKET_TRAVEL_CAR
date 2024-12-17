import 'package:flutter/material.dart';
import '../pages/landing_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate a logout process with a delay
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    });

    return Scaffold(
      // Background dengan gradasi warna ungu
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6B21A8), // Ungu Tua
              Color(0xFF9D4EDD), // Ungu Muda
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Custom Loading Indicator dengan warna putih dan lebih besar
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(height: 30),
              // Teks utama dengan gaya keren
              Text(
                'NEU SABA BACUET ...',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Warna teks putih
                  shadows: [
                    Shadow(
                      blurRadius: 15.0,
                      color: Colors.black.withOpacity(0.6),
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Teks animasi untuk efek fade-in
              AnimatedOpacity(
                opacity: 0.8,
                duration: Duration(seconds: 1),
                child: Text(
                  'MEU SI DETIK KOEN NA ...',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.white70,
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
