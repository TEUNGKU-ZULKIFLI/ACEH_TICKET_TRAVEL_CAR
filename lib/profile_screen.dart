import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Data profil pengguna
  String _name = 'Rahmat';
  String _email = 'rahmat@example.com';
  String _phoneNumber = '+62 812-3456-7890';

  DateTime _joinDate = DateTime.now();
  String _accountStatus = 'Aktif';

  // Controller untuk TextField
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data awal
    _nameController = TextEditingController(text: _name);
    _emailController = TextEditingController(text: _email);
    _phoneController = TextEditingController(text: _phoneNumber);
  }

  @override
  void dispose() {
    // Pastikan untuk membuang controller saat tidak lagi digunakan
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Simpan perubahan yang dibuat
  void _saveChanges() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      // Tampilkan snackbar jika ada field yang kosong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi!')),
      );
      return;
    }

    setState(() {
      _name = _nameController.text;
      _email = _emailController.text;
      _phoneNumber = _phoneController.text;
      _isEditing = false; // Kembali ke mode tampilan
    });
  }

  // Ubah tanggal bergabung
  void _changeJoinDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _joinDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _joinDate) {
      setState(() {
        _joinDate = picked; // Perbarui tanggal bergabung
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Akun'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_picture.png'),
                    backgroundColor: Colors.indigo.shade100,
                  ),
                ),
                const SizedBox(height: 20),
                // Kartu untuk menampilkan data profil
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.indigo.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildEditableRow(
                            'Nama:', _nameController, _name, Icons.person),
                        const SizedBox(height: 12),
                        _buildEditableRow(
                            'Email:', _emailController, _email, Icons.email),
                        const SizedBox(height: 12),
                        _buildEditableRow('Nomor HP:', _phoneController,
                            _phoneNumber, Icons.phone),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Kartu untuk menampilkan informasi tambahan
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.indigo.shade50,
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Tanggal Bergabung:',
                            style: TextStyle(fontSize: 16)),
                        subtitle: Text(
                          '${_joinDate.day}/${_joinDate.month}/${_joinDate.year}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        trailing: _isEditing
                            ? IconButton(
                                icon: const Icon(Icons.calendar_today,
                                    color: Colors.indigo),
                                onPressed: _changeJoinDate,
                              )
                            : null,
                      ),
                      ListTile(
                        title: const Text('Status Akun:',
                            style: TextStyle(fontSize: 16)),
                        subtitle: Text(_accountStatus,
                            style: TextStyle(color: Colors.green)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tombol untuk mengedit atau menyimpan
          Positioned(
            left: 16,
            bottom: 16,
            child: FloatingActionButton.extended(
              backgroundColor: _isEditing ? Colors.green : Colors.indigoAccent,
              onPressed: () {
                setState(() {
                  if (_isEditing) {
                    _saveChanges(); // Simpan perubahan jika dalam mode edit
                  } else {
                    _isEditing = true; // Masuk ke mode edit
                  }
                });
              },
              label: Text(_isEditing ? 'Simpan' : 'Edit Profil'),
              icon: Icon(_isEditing ? Icons.save : Icons.edit),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun baris editable dengan ikon
  Widget _buildEditableRow(String label, TextEditingController controller,
      String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue), // Menambahkan ikon
        const SizedBox(width: 8),
        Text(label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Expanded(
          child: _isEditing
              ? TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  style: const TextStyle(fontSize: 16),
                )
              : Text(
                  value,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
        ),
      ],
    );
  }
}
