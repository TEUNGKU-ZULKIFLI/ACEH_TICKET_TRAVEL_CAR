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
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => LandingPage());
      }, //ubah ke landing page
      navigatorKey: GlobalKey<NavigatorState>(),
    );
  }
}
