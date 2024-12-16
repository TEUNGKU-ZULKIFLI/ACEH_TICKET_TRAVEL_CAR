import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeSopir extends StatefulWidget {
  const HomeSopir({super.key});

  @override
  State<HomeSopir> createState() => _HomeSopirState();
}

class _HomeSopirState extends State<HomeSopir> {
  String? _kotaAsalController;
  String? _kotaTujuanController;
  final _tanggalController = TextEditingController();
  final _hargaController = TextEditingController();
  final _jumlahKursiController = TextEditingController();
  String? _selectedWaktuBerangkat;
  final List<String> _waktuBerangkatOptions = ['PAGI', 'SIANG', 'MALAM'];
  final List<String> _kotaAsalOptions = [
    'Banda Aceh',
    'Sigli',
    'Bireuen',
    'Lhokseumawe',
    'Medan'
  ];
  final List<String> _kotaTujuanOptions = [
    'Banda Aceh',
    'Sigli',
    'Bireuen',
    'Lhokseumawe',
    'Medan'
  ];

  Future<void> _createTicket() async {
    if (_kotaAsalController == null ||
        _kotaTujuanController == null ||
        _tanggalController.text.isEmpty ||
        _selectedWaktuBerangkat == null ||
        _hargaController.text.isEmpty ||
        _jumlahKursiController.text.isEmpty) {
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
          'kota_asal': _kotaAsalController ?? '',
          'kota_tujuan': _kotaTujuanController ?? '',
          'tanggal': _tanggalController.text,
          'waktu_berangkat': _selectedWaktuBerangkat ?? '',
          'harga': _hargaController.text,
          'jumlah_kursi': _jumlahKursiController.text,
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
        title: const Text(
          'BUAT TIKET BARU 🚗',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white, // Mengubah warna font menjadi putih
          ),
        ),
        backgroundColor: Color(0xFF6B21A8),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6B21A8), Color(0xFFF472B6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/img/login_image.jpg',
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              // Row untuk dropdown dan tombol
              Row(
                children: [
                  // Gesture untuk memilih Kota Asal
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _showKotaDialog('Dari');
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Dari Kota',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _kotaAsalController ?? 'Pilih Kota',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight:
                                  FontWeight.bold), // Menyesuaikan warna font
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Gesture untuk memilih Kota Tujuan
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _showKotaDialog('Ke');
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Ke Kota',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _kotaTujuanController ?? 'Pilih Kota',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight:
                                  FontWeight.bold), // Menyesuaikan warna font
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Input Tanggal
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
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    _tanggalController.text =
                        pickedDate.toString().split(' ')[0];
                  }
                },
              ),
              const SizedBox(height: 20),
              // Gesture untuk memilih Shift
              GestureDetector(
                onTap: () {
                  _showShiftDialog();
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Shift',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _selectedWaktuBerangkat ?? 'Pilih Shift',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold), // Menyesuaikan warna font
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Row untuk Harga dan Jumlah Kursi
              Row(
                children: [
                  // Input Harga
                  Expanded(
                    child: TextFormField(
                      controller: _hargaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Harga (Rp)',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Input Jumlah Kursi
                  Expanded(
                    child: TextFormField(
                      controller: _jumlahKursiController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Jumlah Kursi',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // Tombol untuk submit
              ElevatedButton(
                onPressed: _createTicket,
                child: const Text(
                  'Buat Tiket',
                  style: TextStyle(
                      color: Colors.white), // Tombol dengan teks putih
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF472B6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Dialog untuk memilih Kota
  void _showKotaDialog(String jenis) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Pilih Kota $jenis',
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold), // Menyesuaikan warna font
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children:
                  (jenis == 'Dari' ? _kotaAsalOptions : _kotaTujuanOptions)
                      .map((kota) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (jenis == 'Dari') {
                        _kotaAsalController = kota;
                      } else {
                        _kotaTujuanController = kota;
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(kota,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Dialog untuk memilih Shift
  void _showShiftDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Pilih Shift',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold), // Menyesuaikan warna font
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: _waktuBerangkatOptions.map((waktu) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedWaktuBerangkat = waktu;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(waktu,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
