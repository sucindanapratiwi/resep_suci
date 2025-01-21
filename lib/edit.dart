import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class EditData extends StatefulWidget {
  final String? id;

  const EditData({Key? key, this.id}) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _gambarController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _hargaController = TextEditingController();
  final _alamatController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final response =
          await http.get(Uri.parse('${BaseUrl.edit}/${widget.id}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _namaController.text = data['nama'] ?? '';
          _gambarController.text = data['gambar'] ?? '';
          _deskripsiController.text = data['deskripsi'] ?? '';
          _hargaController.text = data['harga'] ?? '';
          _alamatController.text = data['alamat'] ?? '';
          _isLoading = false;
        });
      } else {
        _showErrorSnackbar(
            'Gagal memuat data: ${response.reasonPhrase ?? 'Unknown Error'}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      _showErrorSnackbar('Terjadi kesalahan: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final body = jsonEncode({
        'nama': _namaController.text,
        'gambar': _gambarController.text,
        'deskripsi': _deskripsiController.text,
        'harga': _hargaController.text,
        'alamat': _alamatController.text,
      });

      final response = await http.put(
        Uri.parse('${BaseUrl.edit}/${widget.id}'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        _showSuccessSnackbar('Data berhasil diperbarui');
        Navigator.pop(context, {
          'id': widget.id,
          'nama': _namaController.text,
          'gambar': _gambarController.text,
          'deskripsi': _deskripsiController.text,
          'harga': _hargaController.text,
          'alamat': _alamatController.text,
        });
      } else {
        final errorJson = jsonDecode(response.body);
        String errorMessage = errorJson['message'] ?? 'Gagal memperbarui data';
        _showErrorSnackbar('Error: $errorMessage');
      }
    } catch (e) {
      _showErrorSnackbar('Terjadi kesalahan: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Data"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    _buildTextField(
                      controller: _namaController,
                      label: 'Nama',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Nama tidak boleh kosong'
                          : null,
                    ),
                    _buildTextField(
                      controller: _gambarController,
                      label: 'URL Gambar',
                      validator: (value) => value == null || value.isEmpty
                          ? 'URL Gambar tidak boleh kosong'
                          : null,
                    ),
                    _buildTextField(
                      controller: _deskripsiController,
                      label: 'Deskripsi',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Deskripsi tidak boleh kosong'
                          : null,
                    ),
                    _buildTextField(
                      controller: _hargaController,
                      label: 'Harga',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Harga tidak boleh kosong'
                          : null,
                    ),
                    _buildTextField(
                      controller: _alamatController,
                      label: 'Alamat',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Alamat tidak boleh kosong'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitData,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: validator,
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _gambarController.dispose();
    _deskripsiController.dispose();
    _hargaController.dispose();
    _alamatController.dispose();
    super.dispose();
  }
}
