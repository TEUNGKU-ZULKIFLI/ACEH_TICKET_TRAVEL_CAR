import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> tiket = [
    {
      'gambar': 'assets/img/hiace_modern.png',
    },
    {
      'gambar': 'assets/img/hiace_coklat.png',
    },
    {
      'gambar': 'assets/img/hiace_putih.png',
    },
  ];

  String kotaAsalTerpilih = 'Pilih Kota Asal';
  String kotaTujuanTerpilih = 'Pilih Kota Tujuan';
  int jumlahKursiTerpilih = 1;

  final List<String> kota = [
    'Kota Lhoksemawe',
    'Kota Lhoksukon',
    'Sigli',
    'Perulak',
    'Idi'
  ];

  void tampilkanHasilPencarian() {
    final tiketTersedia = kotaAsalTerpilih != 'Pilih Kota Asal' &&
        kotaTujuanTerpilih != 'Pilih Kota Tujuan' &&
        kotaAsalTerpilih != kotaTujuanTerpilih;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hasil Pencarian Tiket'),
          content: tiketTersedia
              ? Text(
                  'Tiket tersedia dari $kotaAsalTerpilih ke $kotaTujuanTerpilih.\n'
                  'Jumlah Kursi: $jumlahKursiTerpilih',
                )
              : Text(
                  'Maaf, tiket tidak tersedia untuk pilihan Anda.',
                ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void tampilkanLayananPelanggan() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Layanan Pelanggan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('WhatsApp: +62 123 4567 890'),
                onTap: () => bukaWhatsApp('+621234567890'),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Email: support@travelmobilaceh.com'),
                onTap: () => kirimEmail('support@travelmobilaceh.com'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  Future<void> bukaWhatsApp(String nomorTelepon) async {
    final url = 'https://wa.me/$nomorTelepon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka WhatsApp';
    }
  }

  Future<void> kirimEmail(String email) async {
    final url = 'mailto:$email';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka aplikasi email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRAVEL MOBIL ACEH.COM'),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: Icon(Icons.support_agent),
            onPressed: tampilkanLayananPelanggan,
            tooltip: 'Layanan Pelanggan',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
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
            
            SizedBox(height: 10),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dari:',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                DropdownButton<String>(
                  value: kotaAsalTerpilih,
                  onChanged: (String? nilaiBaru) {
                    setState(() {
                      kotaAsalTerpilih = nilaiBaru!;
                    });
                  },
                  items: ['Pilih Kota Asal', ...kota].map<DropdownMenuItem<String>>((String kota) {
                    return DropdownMenuItem<String>(
                      value: kota,
                      child: Text(kota),
                    );
                  }).toList(),
                ),
              ],
            ),
            
            SizedBox(height: 10),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ke:',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                DropdownButton<String>(
                  value: kotaTujuanTerpilih,
                  onChanged: (String? nilaiBaru) {
                    setState(() {
                      kotaTujuanTerpilih = nilaiBaru!;
                    });
                  },
                  items: ['Pilih Kota Tujuan', ...kota].map<DropdownMenuItem<String>>((String kota) {
                    return DropdownMenuItem<String>(
                      value: kota,
                      child: Text(kota),
                    );
                  }).toList(),
                ),
              ],
            ),

            SizedBox(height: 10),

            Text('Pilih Jumlah Kursi:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (jumlahKursiTerpilih > 1) {
                        jumlahKursiTerpilih--;
                      }
                    });
                  },
                ),
                Text(
                  '$jumlahKursiTerpilih',
                  style: TextStyle(fontSize: 24),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (jumlahKursiTerpilih < 10) {
                        jumlahKursiTerpilih++;
                      }
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 10),

            Center(
              child: ElevatedButton(
                onPressed: tampilkanHasilPencarian,
                child: Text('Cari Tiket'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
