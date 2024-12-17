import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../pages/bottom_nav_pelanggan_page.dart'; // Ganti dengan halaman yang sesuai untuk penumpang

class LoginPenumpang extends StatefulWidget {
  @override
  _LoginPenumpangState createState() => _LoginPenumpangState();
}

class _LoginPenumpangState extends State<LoginPenumpang> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  // Fungsi Login
  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email dan Password tidak boleh kosong!'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost/app_aceh_travel/users/login_user.php'),
        body: {
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success']) {
          String role = data['user']['role'];

          if (role == 'penumpang') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavPelanggan(user: data['user']),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Login gagal. Anda bukan penumpang.'),
              backgroundColor: Colors.red,
            ));
          }
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN 🔑 PENUMPANG',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color(0xFFF472B6),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Gradient dengan warna Merah Muda
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF472B6), // Merah Muda
                  Color(0xFFFFB6C1), // Warna Pink Lembut
                ],
              ),
            ),
          ),

          // Konten Utama
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/img/login_image.jpg',
                          height: MediaQuery.of(context).size.height * 0.2,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Input Email
                    TextFormField(
                      controller: _emailController,
                      enabled: !_isLoading,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.email, color: Colors.blue),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Input Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      enabled: !_isLoading,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Tombol Login
                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _login,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[700],
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
