import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'add.dart';
import 'api.dart';
import 'detail.dart';
import 'edit.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Future<List<dynamic>> _fetchDataApi() async {
    try {
      var result = await http.get(Uri.parse(BaseUrl.resepkue_suci));
      if (result.statusCode == 200) {
        var data = json.decode(result.body);
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  List<dynamic> _allData = [];
  List<dynamic> _filteredData = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _fetchDataApi().then((data) {
      setState(() {
        _allData = data;
        _filteredData = data;
      });
    });
  }

  void _filterData(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredData = _allData;
      } else {
        _filteredData = _allData
            .where((item) => (item['nama'] ?? "")
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) => _filterData(value),
              decoration: InputDecoration(
                labelText: "Cari",
                hintText: "Masukkan nama kue",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredData.isEmpty
                ? const Center(
                    child: Text(
                      "Tidak ada data yang ditemukan.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: _filteredData.length,
                      itemBuilder: (context, index) {
                        var item = _filteredData[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detail(
                                  nama: item['nama'] ?? "Nama tidak tersedia",
                                  gambar: item['gambar'] ?? "",
                                  deskripsi:
                                      item['deskripsi'] ?? "Deskripsi kosong",
                                  harga:
                                      item['harga'] ?? "Harga tidak tersedia",
                                  alamat:
                                      item['alamat'] ?? "Alamat tidak tersedia",
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Image.network(
                                      item['gambar'] ??
                                          'https://via.placeholder.com/150',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            color: Colors.grey,
                                            size: 50,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        item['nama'] ?? 'Nama tidak tersedia',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Flexible(
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                final updatedData =
                                                    await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditData(
                                                      id: item['id'].toString(),
                                                    ),
                                                  ),
                                                );

                                                if (updatedData != null) {
                                                  setState(() {
                                                    int index = _allData
                                                        .indexWhere((data) =>
                                                            data['id'] ==
                                                            item['id']);
                                                    if (index != -1) {
                                                      _allData[index] =
                                                          updatedData;
                                                      _filterData(_searchQuery);
                                                    }
                                                  });
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: const Size(50, 30),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 11,
                                                        horizontal: 14),
                                              ),
                                              child: const Text("Edit",
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                            ),
                                          ),
                                          Flexible(
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                try {
                                                  var result =
                                                      await http.delete(
                                                    Uri.parse(BaseUrl.hapus +
                                                        "/" +
                                                        item['id'].toString()),
                                                  );
                                                  if (result.statusCode ==
                                                      200) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                            "Berhasil"),
                                                        content: const Text(
                                                            "Data berhasil dihapus."),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {
                                                                _allData.remove(
                                                                    item);
                                                                _filterData(
                                                                    _searchQuery);
                                                              });
                                                            },
                                                            child: const Text(
                                                                "OK"),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    throw Exception(
                                                        'Gagal menghapus data.');
                                                  }
                                                } catch (e) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Error: Gagal menghapus data')),
                                                  );
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: const Size(50, 30),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 11,
                                                        horizontal: 10),
                                              ),
                                              child: const Text("Hapus",
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahData()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
