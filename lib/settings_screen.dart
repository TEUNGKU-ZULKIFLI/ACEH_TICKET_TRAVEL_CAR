import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SettingsScreen(),
  ));
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool _notificationsEnabled = true; // Notifikasi aktif

  String _selectedLanguage = 'Indonesia'; // Bahasa default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 1. Keamanan
          ListTile(
            title: const Text('Keamanan'),
            leading: const Icon(Icons.security),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecuritySettingsPage()),
              );
            },
          ),
          const Divider(),

          // 2. Pengaturan Pembayaran
          ListTile(
            title: const Text('Pengaturan Pembayaran'),
            leading: const Icon(Icons.payment),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentSettingsPage()),
              );
            },
          ),
          const Divider(),

          // 3. Bantuan & Dukungan
          ListTile(
            title: const Text('Bantuan dan Dukungan'),
            leading: const Icon(Icons.help),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpSupportPage()),
              );
            },
          ),
          const Divider(),

          // 4. Bahasa & Wilayah
          ListTile(
            title: const Text('Bahasa'),
            trailing: const Icon(Icons.language),
            onTap: () {
              _showLanguageSelectionDialog();
            },
          ),
          const Divider(),

          // 5. Notifikasi
          SwitchListTile(
            title: const Text('Notifikasi Hidup'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          const Divider(),

          // 6. Tentang Aplikasi
          ListTile(
            title: const Text('Tentang Aplikasi'),
            subtitle: const Text('Versi 1.0.0'),
          ),
        ],
      ),
    );
  }

  // Dialog untuk memilih bahasa
  void _showLanguageSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Bahasa'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RadioListTile<String>(
                  title: const Text('English'),
                  value: 'English',
                  groupValue: _selectedLanguage,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Cina'),
                  value: 'Cina',
                  groupValue: _selectedLanguage,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Indonesia'),
                  value: 'Indonesia',
                  groupValue: _selectedLanguage,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Halaman Keamanan
class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  State<SecuritySettingsPage> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Keamanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Kata Sandi Baru',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Konfirmasi Kata Sandi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_newPasswordController.text == _confirmPasswordController.text) {
                  // Logika untuk menyimpan kata sandi baru
                  print('Kata Sandi Baru: ${_newPasswordController.text}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Kata sandi berhasil diubah!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Kata sandi tidak cocok!')),
                  );
                }
              },
              child: const Text('Ubah Kata Sandi'),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Pengaturan Pembayaran
class PaymentSettingsPage extends StatefulWidget {
  const PaymentSettingsPage({super.key});

  @override
  State<PaymentSettingsPage> createState() => _PaymentSettingsPageState();
}

class _PaymentSettingsPageState extends State<PaymentSettingsPage> {
  String _selectedPaymentMethod = 'Dana'; // Metode pembayaran default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Pembayaran'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Pilih Metode Pembayaran:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),

          // Pilihan Metode Pembayaran
          RadioListTile<String>(
            title: const Text('Dana'),
            value: 'Dana',
            groupValue: _selectedPaymentMethod,
            onChanged: (String? value) {
              setState(() {
                _selectedPaymentMethod = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('GoPay'),
            value: 'GoPay',
            groupValue: _selectedPaymentMethod,
            onChanged: (String? value) {
              setState(() {
                _selectedPaymentMethod = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('iBanking'),
            value: 'iBanking',
            groupValue: _selectedPaymentMethod,
            onChanged: (String? value) {
              setState(() {
                _selectedPaymentMethod = value!;
              });
            },
          ),
          const Divider(),

          // Tombol Simpan
          ElevatedButton(
            onPressed: () {
              // Logika untuk menyimpan metode pembayaran yang dipilih
              print('Metode Pembayaran Terpilih: $_selectedPaymentMethod');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Metode Pembayaran: $_selectedPaymentMethod disimpan!')),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}

// Halaman Bantuan dan Dukungan
class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bantuan dan Dukungan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildListTile(
            context,
            title: 'FAQ',
            description: 'Akses cepat ke pertanyaan yang sering diajukan.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQPage()),
              );
            },
          ),
          _buildListTile(
            context,
            title: 'Kontak Dukungan',
            description: 'Informasi kontak untuk bantuan pelanggan.',
            onTap: () {
              // Tambahkan logika untuk menampilkan kontak dukungan
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Hubungi kami di: support@example.com')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, {required String title, required String description, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text(title),
          subtitle: Text(description),
        ),
      ),
    );
  }
}

// Halaman FAQ
class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Pertanyaan 1'),
              subtitle: const Text('Jawaban untuk pertanyaan 1.'),
            ),
            ListTile(
              title: const Text('Pertanyaan 2'),
              subtitle: const Text('Jawaban untuk pertanyaan 2.'),
            ),
            // Tambahkan lebih banyak pertanyaan sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
