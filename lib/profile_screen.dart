import 'package:flutter/material.dart';

// Model User
class User {
  String name;
  String email;
  String phone;
  String password;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiket Travel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

// Halaman Utama dengan Drawer dan Bottom Navigation Bar
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Riwayat Pemesanan', style: TextStyle(fontSize: 24))),
    Center(child: Text('Pengaturan', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tiket Travel'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Halaman Profil Pengguna
class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  User user = User(
    name: 'Rahmat',
    email: 'john.doe@example.com',
    phone: '+62 812 3456 7890',
    password: 'password123',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            SizedBox(height: 20),
            buildUserInfoRow('Nama:', user.name),
            buildUserInfoRow('Email:', user.email),
            buildUserInfoRow('Nomor Telepon:', user.phone),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () => _editProfile(context),
                child: Text('Edit Profil'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => _changePassword(context),
                child: Text('Ubah Kata Sandi'),
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _editProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _formKey = GlobalKey<FormState>();
        String? newName = user.name;
        String? newEmail = user.email;
        String? newPhone = user.phone;
        String? newPassword; // Tambahkan variabel untuk kata sandi baru

        return AlertDialog(
          title: Text('Edit Profil'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: user.name,
                  decoration: InputDecoration(labelText: 'Nama'),
                  onSaved: (value) => newName = value,
                ),
                TextFormField(
                  initialValue: user.email,
                  decoration: InputDecoration(labelText: 'Email'),
                  onSaved: (value) => newEmail = value,
                ),
                TextFormField(
                  initialValue: user.phone,
                  decoration: InputDecoration(labelText: 'Nomor Telepon'),
                  onSaved: (value) => newPhone = value,
                ),
                TextFormField(
                  obscureText: true,
                  decoration:
                      InputDecoration(labelText: 'Kata Sandi Baru (Opsional)'),
                  onSaved: (value) => newPassword = value,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() {
                    user.name = newName!;
                    user.email = newEmail!;
                    user.phone = newPhone!;
                    if (newPassword != null && newPassword!.isNotEmpty) {
                      user.password =
                          newPassword!; // Simpan kata sandi baru jika ada
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  void _changePassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _formKey = GlobalKey<FormState>();
        String? newPassword;

        return AlertDialog(
          title: Text('Ubah Kata Sandi'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Kata Sandi Baru'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Masukkan kata sandi baru';
                }
                return null;
              },
              onSaved: (value) => newPassword = value,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  setState(() {
                    user.password = newPassword!;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }
}
