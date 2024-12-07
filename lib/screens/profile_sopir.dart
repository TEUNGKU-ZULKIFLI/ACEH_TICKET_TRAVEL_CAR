import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileSopir extends StatefulWidget {
  final Map<String, dynamic> user;

  const ProfileSopir({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileSopirState createState() => _ProfileSopirState();
}

class _ProfileSopirState extends State<ProfileSopir> {
  List<Map<String, dynamic>> tickets = [];
  bool isLoading = true;

  Future<void> fetchTickets() async {
    try {
      final url = Uri.parse(
          'http://localhost/app_aceh_travel/tickets/get_user_tickets.php?user_id=${widget.user['id']}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          setState(() {
            tickets = List<Map<String, dynamic>>.from(data['tickets']);
          });
        }
      }
    } catch (e) {
      print("Error fetching tickets: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SOPIR ${widget.user['nama']}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama: ${widget.user['nama']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${widget.user['email']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'No HP: ${widget.user['no_hp']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'STATUS : ${widget.user['role']}',
            ),
            SizedBox(height: 8),
            Text(
              'Bergabung: ${widget.user['created_at']}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
