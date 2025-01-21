import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gambar latar belakang
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff4d90b6), Colors.teal.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Konten utama
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 50), // Untuk memberikan ruang untuk status bar
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      'https://tse2.mm.bing.net/th?id=OIP.NZA1sRZ7dVMwQMz7Sfd0uAHaFj&pid=Api&P=0&h=220',
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Suci ndana pratiwi',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'NIM: 22TI017',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Kelas: TI A1',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Alamat: Dompu',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  SizedBox(height: 32),
                  _buildActionCard(
                    icon: Icons.person,
                    title: 'Tentang Saya',
                    onTap: () {
                      // Aksi ketika diklik
                    },
                  ),
                  SizedBox(height: 16),
                  _buildActionCard(
                    icon: Icons.settings,
                    title: 'Pengaturan',
                    onTap: () {
                      // Aksi ketika diklik
                    },
                  ),
                  SizedBox(height: 16),
                  _buildActionCard(
                    icon: Icons.logout,
                    title: 'Keluar',
                    onTap: () {
                      // Aksi ketika diklik
                    },
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // Aksi ketika tombol diklik
                    },
                    child: Text('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[
                          700], // Mengganti 'primary' dengan 'backgroundColor'
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
      {required IconData icon, required String title, void Function()? onTap}) {
    return Card(
      elevation: 4,
      color: Color(0xff3bff3b), // Mengubah warna kartu menjadi kuning
      child: ListTile(
        leading: Icon(icon,
            color: Colors.black), // Mengubah warna ikon menjadi hitam
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        onTap: onTap,
      ),
    );
  }
}
