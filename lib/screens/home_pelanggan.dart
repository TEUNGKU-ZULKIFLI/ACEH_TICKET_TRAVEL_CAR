import '../pages/search_results_page.dart';
import 'package:flutter/material.dart';

class HomePelanggan extends StatefulWidget {
  @override
  _HomePelangganState createState() => _HomePelangganState();
}

class _HomePelangganState extends State<HomePelanggan> {
  final List<Map<String, String>> tiket = [
    {'gambar': 'assets/img/hiace_putih.png'},
    {'gambar': 'assets/img/hiace_modern.png'},
    {'gambar': 'assets/img/hiace_coklat.png'},
  ];

  String kotaAsalTerpilih = 'Pilih Kota Asal';
  String kotaTujuanTerpilih = 'Pilih Kota Tujuan';
  DateTime? tanggalTerpilih;
  String waktuBerangkatTerpilih = 'Pilih Shift';

  final List<String> kota = [
    'Banda Aceh',
    'Sigli',
    'Bireuen',
    'Lhokseumawe',
    'Medan'
  ];
  final List<String> waktuBerangkat = ['PAGI', 'SIANG', 'MALAM'];

  Future<void> pilihTanggal() async {
    final DateTime? tanggalDipilih = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (tanggalDipilih != null && tanggalDipilih != tanggalTerpilih) {
      setState(() {
        tanggalTerpilih = tanggalDipilih;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ANDA PUAS, KAMI UNTUNG 🚗',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color(0xFF6B21A8), // Ungu Tua
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6B21A8),
                Color(0xFFF472B6)
              ], // Gradasi Ungu Tua ke Merah Muda
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Gambar Kendaraan
              Container(
                height: 200,
                child: PageView(
                  children: tiket.map((t) {
                    return Container(
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          t['gambar']!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              // Kiri: Dropdown untuk "Dari" dan "Ke"
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dari:',
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                        GestureDetector(
                          onTap: () {
                            _showKotaDialog('Dari');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              kotaAsalTerpilih,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ke:',
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                        GestureDetector(
                          onTap: () {
                            _showKotaDialog('Ke');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              kotaTujuanTerpilih,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Pilih Tanggal
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Pilih Tanggal:',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: pilihTanggal,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          tanggalTerpilih != null
                              ? '${tanggalTerpilih!.toLocal()}'.split(' ')[0]
                              : 'Tanggal tidak dipilih',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Shift: Menggunakan GestureDetector dan Dialog
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Shift:',
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                        GestureDetector(
                          onTap: () {
                            _showShiftDialog();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              waktuBerangkatTerpilih,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              // Tombol "Cari Ticket"
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultsPage(
                          kotaAsal: kotaAsalTerpilih,
                          kotaTujuan: kotaTujuanTerpilih,
                          tanggal: tanggalTerpilih != null
                              ? '${tanggalTerpilih!.toLocal()}'.split(' ')[0]
                              : '',
                          waktuBerangkat: waktuBerangkatTerpilih,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'CARI TICKET',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF472B6), // Merah Muda
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Menampilkan dialog untuk memilih kota
  void _showKotaDialog(String jenis) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pilih Kota $jenis'),
          content: SingleChildScrollView(
            child: ListBody(
              children: kota.map((kota) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (jenis == 'Dari') {
                        kotaAsalTerpilih = kota;
                      } else {
                        kotaTujuanTerpilih = kota;
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(kota),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Menampilkan dialog untuk memilih shift
  void _showShiftDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pilih Shift'),
          content: SingleChildScrollView(
            child: ListBody(
              children: waktuBerangkat.map((waktu) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      waktuBerangkatTerpilih = waktu;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(waktu),
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
