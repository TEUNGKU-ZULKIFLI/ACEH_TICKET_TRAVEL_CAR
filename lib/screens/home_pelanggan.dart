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

  final List<String> waktuBerangkat = [
    'PAGI',
    'SIANG',
    'MALAM',
  ];

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
            fontWeight: FontWeight.bold, // Menebalkan teks
            fontSize: 20, // Ukuran font
          ),
        ),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.all(1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: PageView(
                children: tiket.map((t) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dari:',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                DropdownButton<String>(
                  value: kotaAsalTerpilih,
                  onChanged: (String? nilaiBaru) {
                    setState(() {
                      kotaAsalTerpilih = nilaiBaru!;
                    });
                  },
                  items: ['Pilih Kota Asal', ...kota]
                      .map<DropdownMenuItem<String>>((String kota) {
                    return DropdownMenuItem<String>(
                      value: kota,
                      child: Text(kota),
                    );
                  }).toList(),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ke:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                DropdownButton<String>(
                  value: kotaTujuanTerpilih,
                  onChanged: (String? nilaiBaru) {
                    setState(() {
                      kotaTujuanTerpilih = nilaiBaru!;
                    });
                  },
                  items: ['Pilih Kota Tujuan', ...kota]
                      .map<DropdownMenuItem<String>>((String kota) {
                    return DropdownMenuItem<String>(
                      value: kota,
                      child: Text(kota),
                    );
                  }).toList(),
                ),
              ],
            ),
            Text('Pilih Tanggal:'),
            TextButton(
              onPressed: pilihTanggal,
              child: Text(
                tanggalTerpilih != null
                    ? '${tanggalTerpilih!.toLocal()}'.split(' ')[0]
                    : 'Tanggal tidak dipilih',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shift:',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                DropdownButton<String>(
                  value: waktuBerangkatTerpilih,
                  onChanged: (String? nilaiBaru) {
                    setState(() {
                      waktuBerangkatTerpilih = nilaiBaru!;
                    });
                  },
                  items: ['Pilih Shift', ...waktuBerangkat]
                      .map<DropdownMenuItem<String>>((String waktu) {
                    return DropdownMenuItem<String>(
                      value: waktu,
                      child: Text(waktu),
                    );
                  }).toList(),
                ),
              ],
            ),
            Center(),
            TextButton(
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
                textAlign: TextAlign.center,
                selectionColor: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
