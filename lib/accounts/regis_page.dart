import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../pages/landing_page.dart';

class RegisPage extends StatefulWidget {
  @override
  _RegisPageState createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _noHpController = TextEditingController();

  String _selectedRole = 'penumpang'; // Default role
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost/app_aceh_travel/users/register_user.php'),
        body: {
          'nama': _namaController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'no_hp': _noHpController.text,
          'role': _selectedRole, // Kirim role ke backend
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LandingPage()),
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
        title: Text('REGISTER ✍️',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Nama field with icon
                    TextFormField(
                      controller: _namaController,
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Email field with icon
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Email tidak valid';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Password field with icon
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        } else if (value.length < 6) {
                          return 'Password harus lebih dari 6 karakter';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // No HP field with icon
                    TextFormField(
                      controller: _noHpController,
                      decoration: InputDecoration(
                        labelText: 'No HP',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor HP tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Role dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      items: [
                        DropdownMenuItem(
                            value: 'penumpang', child: Text('Penumpang')),
                        DropdownMenuItem(value: 'sopir', child: Text('Sopir')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Role',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.group),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Register button with text color adjustment
                    ElevatedButton(
                      onPressed: _register,
                      child: Text('Register',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        backgroundColor: Colors.blue, // Button background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    // Login redirect
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingPage()),
                        );
                      },
                      child: Text('Sudah punya akun? Login',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
