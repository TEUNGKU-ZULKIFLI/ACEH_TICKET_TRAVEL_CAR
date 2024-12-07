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
      backgroundColor: Colors.blue[800], // Set a cool background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Custom Loading Indicator
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white), // Customize color
              ),
            ),
            SizedBox(height: 20),
            // Cool Text Style
            Text(
              'NEU SABA BACUET ...',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Change text color
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Animated Fade-in Text
            AnimatedOpacity(
              opacity: 0.8,
              duration: Duration(seconds: 1),
              child: Text(
                'MEU SI DETIK KOEN NA ...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
