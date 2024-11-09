import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> tiket = [
    {'gambar': 'assets/img/hiace_modern.png'},
    {'gambar': 'assets/img/hiace_coklat.png'},
    {'gambar': 'assets/img/hiace_putih.png'},
  ];

  String kotaAsalTerpilih = 'Pilih Kota Asal';
  String kotaTujuanTerpilih = 'Pilih Kota Tujuan';
  int jumlahKursiTerpilih = 1;
  DateTime? tanggalTerpilih;

  final List<String> kota = [
    'Kota Lhoksemawe',
    'Kota Lhoksukon',
    'Sigli',
    'Perulak',
    'Idi'
  ];

  final List<Map<String, dynamic>> riwayatPencarian = [];
  final List<Map<String, dynamic>> riwayatPembayaran = [];

  void tampilkanHasilPencarian() {
    final tiketTersedia = kotaAsalTerpilih != 'Pilih Kota Asal' &&
        kotaTujuanTerpilih != 'Pilih Kota Tujuan' &&
        kotaAsalTerpilih != kotaTujuanTerpilih;

    if (tiketTersedia) {
      riwayatPencarian.add({
        'asal': kotaAsalTerpilih,
        'tujuan': kotaTujuanTerpilih,
        'tanggal': tanggalTerpilih,
        'jumlahKursi': jumlahKursiTerpilih,
      });
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hasil Pencarian Tiket'),
          content: tiketTersedia
              ? Text(
                  'Tiket tersedia dari $kotaAsalTerpilih ke $kotaTujuanTerpilih pada ${tanggalTerpilih != null ? tanggalTerpilih!.toLocal().toString().split(' ')[0] : 'Tanggal tidak dipilih'}.\n'
                  'Jumlah Kursi: $jumlahKursiTerpilih',
                )
              : Text('Maaf, tiket tidak tersedia untuk pilihan Anda.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                tampilkanMetodePembayaran(); // Panggil metode pembayaran
              },
              child: Text('Bayar'),
            ),
          ],
        );
      },
    );
  }

  void tampilkanMetodePembayaran() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Metode Pembayaran'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.monetization_on),
                title: Text('Transfer Bank'),
                onTap: () {
                  Navigator.of(context).pop();
                  konfirmasiPembayaran('Transfer Bank');
                },
              ),
              ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('Kartu Kredit'),
                onTap: () {
                  Navigator.of(context).pop();
                  konfirmasiPembayaran('Kartu Kredit');
                },
              ),
              ListTile(
                leading: Icon(Icons.paypal),
                title: Text('PayPal'),
                onTap: () {
                  Navigator.of(context).pop();
                  konfirmasiPembayaran('PayPal');
                },
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

  void konfirmasiPembayaran(String metode) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembayaran'),
          content: Text(
              'Anda telah memilih metode pembayaran: $metode. Apakah Anda yakin ingin melanjutkan?'),
          actions: [
            TextButton(
              onPressed: () {
                // Simpan ke riwayat pembayaran
                riwayatPembayaran.add({
                  'metode': metode,
                  'jumlahKursi': jumlahKursiTerpilih,
                  'tanggal': DateTime.now(),
                });
                Navigator.of(context).pop();
                tampilkanRiwayatPembayaran(); // Tampilkan riwayat pembayaran
              },
              child: Text('Ya'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tidak'),
            ),
          ],
        );
      },
    );
  }

  void tampilkanRiwayatPembayaran() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Riwayat Pembayaran'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: riwayatPembayaran.length,
              itemBuilder: (context, index) {
                final pembayaran = riwayatPembayaran[index];
                return ListTile(
                  title: Text('Metode: ${pembayaran['metode']}'),
                  subtitle: Text(
                      'Jumlah Kursi: ${pembayaran['jumlahKursi']}\nTanggal: ${pembayaran['tanggal']}'),
                );
              },
            ),
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
                title: Text('WhatsApp: 0895600771006'),
                onTap: () => bukaWhatsApp('0895600771006'),
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

  void navigasiKeRiwayat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RiwayatScreen(
          riwayatPencarian: riwayatPencarian,
          riwayatPembayaran: riwayatPembayaran,
        ),
      ),
    );
  }

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
        title: Text('ANDA PUAS KAMI LABA'),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: Icon(Icons.support_agent),
            onPressed: tampilkanLayananPelanggan,
            tooltip: 'Layanan Pelanggan',
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: navigasiKeRiwayat,
            tooltip: 'Riwayat',
          ),
        ],
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
                style: TextStyle(fontSize: 20),
              ),
            ),
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
                Text('$jumlahKursiTerpilih', style: TextStyle(fontSize: 24)),
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
            Center(
              child: ElevatedButton(
                onPressed: tampilkanHasilPencarian,
                child: Text('Cari Tiket',
                    style: TextStyle(fontSize: 18, color: Colors.black)),
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

class RiwayatScreen extends StatelessWidget {
  final List<Map<String, dynamic>> riwayatPencarian;
  final List<Map<String, dynamic>> riwayatPembayaran;

  RiwayatScreen(
      {required this.riwayatPencarian, required this.riwayatPembayaran});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Tujuan dan Pembayaran'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Text('Riwayat Pencarian Tiket',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...riwayatPencarian.map((pencarian) {
              return Card(
                child: ListTile(
                  title: Text('${pencarian['asal']} ke ${pencarian['tujuan']}'),
                  subtitle: Text(
                    'Tanggal: ${pencarian['tanggal'] != null ? pencarian['tanggal']!.toLocal().toString().split(' ')[0] : 'Tidak dipilih'}\n'
                    'Jumlah Kursi: ${pencarian['jumlahKursi']}',
                  ),
                ),
              );
            }).toList(),
            Text('Riwayat Pembayaran',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...riwayatPembayaran.map((pembayaran) {
              return Card(
                child: ListTile(
                  title: Text('Metode: ${pembayaran['metode']}'),
                  subtitle: Text(
                      'Jumlah Kursi: ${pembayaran['jumlahKursi']}\nTanggal: ${pembayaran['tanggal']}'),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
