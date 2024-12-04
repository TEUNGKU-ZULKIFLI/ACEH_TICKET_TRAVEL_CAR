import 'package:flutter/material.dart';

class SelectChair extends StatefulWidget {
  const SelectChair({super.key});

  @override
  State<SelectChair> createState() => _SelectChairState();
}

class _SelectChairState extends State<SelectChair> {
  // Daftar kursi
  int jumlahKursiTerpilih = 1;
  List<Map<String, dynamic>> kursi = List.generate(
    15,
    (index) => {
      'nomor': (index + 1).toString(),
      'tersedia': true,
      'terpilih': false,
    },
  );

  void pilihKursi(int index) {
    final terpilih = kursi.where((k) => k['terpilih'] == true).length;

    setState(() {
      if (kursi[index]['terpilih']) {
        kursi[index]['terpilih'] = false;
      } else if (terpilih < jumlahKursiTerpilih) {
        kursi[index]['terpilih'] = true;
      }
    });
  }

  Widget buildKursi() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: kursi.map((k) {
        final index = kursi.indexOf(k);
        return GestureDetector(
          onTap: k['tersedia'] ? () => pilihKursi(index) : null,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: k['terpilih']
                  ? Colors.blue
                  : (k['tersedia'] ? Colors.green : Colors.red),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                k['nomor'],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Kursi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Silakan pilih kursi Anda:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            buildKursi(),
          ],
        ),
      ),
    );
  }
}
