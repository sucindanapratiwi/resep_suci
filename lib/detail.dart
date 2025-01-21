import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String nama;
  final String gambar;
  final String deskripsi;
  final String harga;
  final String alamat;

  const Detail({
    Key? key,
    required this.nama,
    required this.gambar,
    required this.deskripsi,
    required this.harga,
    required this.alamat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          nama,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with border radius and shadow
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.network(
                      gambar,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 50,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Description Section
              const Text(
                "Deskripsi:",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const Divider(color: Colors.grey),
              Text(
                deskripsi,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Harga Section
              const Text(
                "Harga:",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const Divider(color: Colors.grey),
              Text(
                harga,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Alamat Section
              const Text(
                "Alamat:",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const Divider(color: Colors.grey),
              Text(
                alamat,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
