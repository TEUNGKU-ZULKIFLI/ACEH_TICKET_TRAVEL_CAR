import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeSopir extends StatefulWidget {
  const HomeSopir({super.key});

  @override
  State<HomeSopir> createState() => _HomeSopirState();
}

class _HomeSopirState extends State<HomeSopir> {
  final _kotaAsalController = TextEditingController();
  final _kotaTujuanController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _hargaController = TextEditingController();
  final _jumlahKursiController =
      TextEditingController(); // Controller untuk jumlah kursi

  String? _selectedWaktuBerangkat;
  final List<String> _waktuBerangkatOptions = ['PAGI', 'SIANG', 'MALAM'];

  Future<void> _createTicket() async {
    if (_kotaAsalController.text.isEmpty ||
        _kotaTujuanController.text.isEmpty ||
        _tanggalController.text.isEmpty ||
        _selectedWaktuBerangkat == null ||
        _hargaController.text.isEmpty ||
        _jumlahKursiController.text.isEmpty) {
      // Cek apakah jumlah kursi terisi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua field harus diisi!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost/app_aceh_travel/tickets/create_ticket.php'),
        body: {
          'kota_asal': _kotaAsalController.text,
          'kota_tujuan': _kotaTujuanController.text,
          'tanggal': _tanggalController.text,
          'waktu_berangkat': _selectedWaktuBerangkat ?? '',
          'harga': _hargaController.text,
          'jumlah_kursi':
              _jumlahKursiController.text, // Mengirimkan jumlah kursi
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to connect to server'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Tiket Baru 🚗'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.lightBlue[50],
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/img/login_image.jpg', // Ganti sesuai path gambar
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _kotaAsalController,
                decoration: const InputDecoration(
                  labelText: 'Kota Asal',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _kotaTujuanController,
                decoration: const InputDecoration(
                  labelText: 'Kota Tujuan',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tanggalController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Tanggal (YYYY-MM-DD)',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100), // Memperbaiki batas akhir tahun
                  );
                  if (pickedDate != null) {
                    _tanggalController.text =
                        pickedDate.toString().split(' ')[0];
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedWaktuBerangkat,
                decoration: const InputDecoration(
                  labelText: 'Shift',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                items: _waktuBerangkatOptions
                    .map((String waktu) => DropdownMenuItem<String>(
                          value: waktu,
                          child: Text(waktu),
                        ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedWaktuBerangkat = newValue;
                  });
                },
                hint: const Text('Pilih Shift'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga (Rp)',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _jumlahKursiController, // Input jumlah kursi
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Kursi',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createTicket,
                child: const Text('Buat Tiket'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
