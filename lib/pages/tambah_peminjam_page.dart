import 'package:flutter/material.dart';

class TambahPeminjamanPage extends StatelessWidget {
  const TambahPeminjamanPage({super.key});

  final Color hijau = const Color(0xFF8BAE66);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hijau,
        title: const Text('Buat Peminjaman'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input('ID User / Nama Peminjam'),
            _input('Kelas'),
            _input('ID Alat / Nama Alat'),
            _input('Jumlah Pinjam'),
            _input('Tanggal Pinjam'),
            _input('Batas Pengembalian'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Simpan Data'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _input(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}