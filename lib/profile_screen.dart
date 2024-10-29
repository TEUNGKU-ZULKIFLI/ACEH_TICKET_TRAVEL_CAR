import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'Rahmat';
  String _email = 'rahmat@example.com';
  String _phoneNumber = '+62 812-3456-7890';

  DateTime _joinDate = DateTime.now();
  String _accountStatus = 'Aktif';

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _name);
    _emailController = TextEditingController(text: _email);
    _phoneController = TextEditingController(text: _phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    setState(() {
      _name = _nameController.text;
      _email = _emailController.text;
      _phoneNumber = _phoneController.text;
      _isEditing = false;
    });
  }

  void _changeJoinDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _joinDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _joinDate) {
      setState(() {
        _joinDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Akun'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Nama:', style: TextStyle(fontSize: 18)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _isEditing
                                  ? TextField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Edit Nama'),
                                    )
                                  : Text(
                                      _name,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text('Email:',
                                style: TextStyle(fontSize: 18)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _isEditing
                                  ? TextField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Edit Email'),
                                    )
                                  : Text(
                                      _email,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text('Nomor Handphone:',
                                style: TextStyle(fontSize: 18)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _isEditing
                                  ? TextField(
                                      controller: _phoneController,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Edit Nomor'),
                                    )
                                  : Text(
                                      _phoneNumber,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Tanggal Bergabung:'),
                        subtitle: Text(
                            '${_joinDate.day}/${_joinDate.month}/${_joinDate.year}'),
                        trailing: _isEditing
                            ? IconButton(
                                icon: const Icon(Icons.calendar_today,
                                    color: Colors.blueAccent),
                                onPressed: _changeJoinDate,
                              )
                            : null,
                      ),
                      ListTile(
                        title: const Text('Status Akun:'),
                        subtitle: Text(_accountStatus),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/img/profile_picture.ico'),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: FloatingActionButton.extended(
              backgroundColor: _isEditing ? Colors.green : Colors.blueAccent,
              onPressed: () {
                setState(() {
                  if (_isEditing) {
                    _saveChanges();
                  } else {
                    _isEditing = true;
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
}
