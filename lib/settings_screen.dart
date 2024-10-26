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
  // Variabel untuk menyimpan status pengaturan
  bool _notificationsEnabled = true; // Notifikasi aktif
  bool _darkTheme = false; // Tema gelap
  String _selectedLanguage = 'English'; // Bahasa default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 1. Pengaturan Akun
          ListTile(
            title: const Text('Pengaturan Akun'),
            leading: const Icon(Icons.account_circle),
            onTap: () {
              // Tindakan saat akun dipilih
            },
          ),
          const Divider(),

          // 2. Keamanan
          ListTile(
            title: const Text('Keamanan'),
            leading: const Icon(Icons.security),
            onTap: () {
              // Tindakan saat keamanan dipilih
            },
          ),
          const Divider(),

          // 3. Pengaturan Pembayaran
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

          // 4. Bantuan & Dukungan
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

          // 5. Pengaturan Privasi
          ListTile(
            title: const Text('Pengaturan Privasi'),
            leading: const Icon(Icons.privacy_tip),
            onTap: () {
              // Tindakan saat privasi dipilih
            },
          ),
          const Divider(),

          // 6. Bahasa & Wilayah
          ListTile(
            title: const Text('Bahasa & Wilayah'),
            trailing: const Icon(Icons.language),
            onTap: () {
              _showLanguageSelectionDialog();
            },
          ),
          const Divider(),

          // 7. Mode Gelap atau Terang
          SwitchListTile(
            title: const Text('Mode Gelap'),
            value: _darkTheme,
            onChanged: (bool value) {
              setState(() {
                _darkTheme = value;
              });
            },
          ),
          const Divider(),

          // 8. Notifikasi
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

          // 9. Tentang Aplikasi
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactSupportPage()),
              );
            },
          ),
          _buildListTile(
            context,
            title: 'Umpan Balik',
            description: 'Kirim umpan balik tentang pengalaman pengguna.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedbackPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, {required String title, required String description, required Function() onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Apa itu sistem tiket travel?'),
            subtitle: const Text('Sistem untuk memesan tiket travel dengan mudah.'),
          ),
          // Tambahkan pertanyaan lain di sini
        ],
      ),
    );
  }
}

// Halaman Kontak Dukungan
class ContactSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kontak Dukungan'),
      ),
      body: Center(
        child: const Text(
          'Hubungi kami di: support@example.com\nTelepon: (021) 12345678',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// Halaman Umpan Balik
class FeedbackPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Umpan Balik'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Silakan kirim umpan balik Anda:'),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tulis umpan balik...',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Logika untuk mengirim umpan balik
                print('Umpan balik: ${_controller.text}');
                _controller.clear(); // Menghapus teks setelah pengiriman
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Umpan balik terkirim!')),
                );
              },
              child: const Text('Kirim'),
            ),
          ],
        ),
      ),
    );
  }
}
