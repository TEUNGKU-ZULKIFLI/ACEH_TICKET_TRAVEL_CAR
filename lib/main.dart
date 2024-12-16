import 'package:flutter/material.dart';
import './pages/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Ticket Travel Car',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF6B21A8), // Merah Muda
        scaffoldBackgroundColor: Colors.white, // Background putih
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF6B21A8), // Ungu Tua
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          displayLarge:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: Colors.white), // Title of AppBar
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFF472B6), // Merah Muda untuk tombol
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFF472B6), // Merah Muda untuk FAB
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          shadowColor: Colors.black45,
          elevation: 5,
        ),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFF472B6)),
      ),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => LandingPage());
      },
      navigatorKey: GlobalKey<NavigatorState>(),
    );
  }
}
