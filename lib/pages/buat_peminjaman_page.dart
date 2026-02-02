import 'package:flutter/material.dart';

class BuatPeminjamanPage extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? data;

  const BuatPeminjamanPage({
    super.key,
    this.isEdit = false,
    this.data,
  });

  @override
  State<BuatPeminjamanPage> createState() => _BuatPeminjamanPageState();
}

class _BuatPeminjamanPageState extends State<BuatPeminjamanPage> {
  final Color hijauMuda = const Color(0xFF8BAE66);

  late TextEditingController namaCtrl;
  late TextEditingController alatCtrl;
  late TextEditingController tanggalCtrl;

  @override
  void initState() {
    super.initState();
    namaCtrl = TextEditingController(text: widget.data?['nama'] ?? '');
    alatCtrl = TextEditingController(text: widget.data?['alat'] ?? '');
    tanggalCtrl = TextEditingController(text: widget.data?['tanggal'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hijauMuda,
        title: Text(widget.isEdit ? 'Edit Peminjaman' : 'Buat Peminjaman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input('Nama Peminjam', namaCtrl),
            _input('Nama Alat', alatCtrl),
            _input('Tanggal', tanggalCtrl),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'nama': namaCtrl.text,
                    'alat': alatCtrl.text,
                    'tanggal': tanggalCtrl.text,
                    'status': widget.data?['status'] ?? 'dipinjam',
                  });
                },
                child: const Text('SIMPAN'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          hintText: label,
          filled: true,
          fillColor: const Color(0xFFE5ECD8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
