import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart'; // Pastikan path ini benar

class RegisPage extends StatefulWidget {
  @override
  _RegisPageState createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _noHpController = TextEditingController();

  Future<void> _register() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://localhost/api_aceh_travel/users/register_user.php'), // Inoe neuboh beu sesuai menyoe neu run [2] atou [3] neu boh IP v4.
        body: {
          'nama': _namaController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'no_hp': _noHpController.text,
        },
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success']) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(data['message']),
            backgroundColor: Colors.green,
          ));
          // Redirect ke LoginPage setelah registrasi berhasil
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
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
          'REGISTER ✍️',
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
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      filled: true,
                      fillColor: Colors.white, // Warna latar belakang TextField
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _noHpController,
                    decoration: InputDecoration(
                      labelText: 'No HP',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    child: Text('Register'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Warna tombol Daftar
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Sudah punya akun? Login',
                      style: TextStyle(color: Colors.blue), // Warna teks
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
