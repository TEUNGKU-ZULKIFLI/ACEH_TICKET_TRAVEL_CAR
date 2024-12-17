import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../pages/bottom_nav_sopir_page.dart'; // Ganti dengan halaman yang sesuai untuk sopir

class LoginSopir extends StatefulWidget {
  @override
  _LoginSopirState createState() => _LoginSopirState();
}

class _LoginSopirState extends State<LoginSopir> {
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

          if (role == 'sopir') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavSopir(user: data['user']),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Login gagal. Anda bukan sopir.'),
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
          'LOGIN 🔑 SOPIR',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color(0xFF6B21A8), // Ungu Tua
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Gradient dengan Gradasi Ungu dan Biru
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6B21A8), // Ungu Tua
                  Color(0xFF9D4EDD), // Ungu Muda
                  Color(0xFF4F73A1), // Biru Muda
                ],
              ),
            ),
          ),

          // Form Login di Tengah
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Aplikasi
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/img/login_image.jpg', // Path logo
                          height: MediaQuery.of(context).size.height * 0.2,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Input Email
                    TextFormField(
                      controller: _emailController,
                      enabled: !_isLoading, // Disable saat loading
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

                    // Tombol Login atau Loading
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
                              backgroundColor: Color(0xFF4F73A1), // Biru Muda
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
