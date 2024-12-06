import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'regis_page.dart';
import '../pages/bottom_nav_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://localhost/app_aceh_travel/users/login_user.php'), // Inoe neuboh beu sesuai menyoe neu run [2] atou [3] neu boh IP v4.
        body: {
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success']) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavPage(user: data['user']),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(data['message']),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to connect to server'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN 🔑',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Menebalkan teks
            fontSize: 20, // Ukuran font
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true, // Menjadikan teks di tengah
      ),
      body: Container(
        color: Colors.lightBlue[50], // Warna latar belakang halaman
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Menambahkan gambar di atas form
            Image.asset(
              'assets/img/login_image.jpg', // Ganti dengan path gambar Anda
              height: 150, // Atur tinggi gambar
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20), // Jarak antara gambar dan form
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisPage()),
                );
              },
              child: Text('Belum punya akun? Daftar disini'),
            ),
          ],
        ),
      ),
    );
  }
}
