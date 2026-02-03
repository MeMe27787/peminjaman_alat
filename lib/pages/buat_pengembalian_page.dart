import 'package:flutter/material.dart';

class BuatPengembalianPage extends StatefulWidget {
  final Map<String, dynamic>? data;

  const BuatPengembalianPage({super.key, this.data, required bool isEdit});

  @override
  State<BuatPengembalianPage> createState() => _BuatPengembalianPageState();
}

class _BuatPengembalianPageState extends State<BuatPengembalianPage> {
  final Color hijauMuda = const Color(0xFF8BAE66);

  late TextEditingController namaCtrl;
  late TextEditingController alatCtrl;
  late TextEditingController tanggalCtrl;

  String kondisi = 'Baik';

  @override
  void initState() {
    super.initState();
    namaCtrl = TextEditingController(text: widget.data?['nama'] ?? '');
    alatCtrl = TextEditingController(text: widget.data?['alat'] ?? '');
    tanggalCtrl = TextEditingController(text: widget.data?['tanggal'] ?? '');
    kondisi = widget.data?['kondisi'] ?? 'Baik';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: hijauMuda,
        title: Text(widget.data == null
            ? 'Buat Pengembalian'
            : 'Edit Pengembalian'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input('Nama Peminjam', namaCtrl),
            _input('Nama Alat', alatCtrl),
            _input('Tanggal Pengembalian', tanggalCtrl),

            // ===== KONDISI BARANG =====
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFE5ECD8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField<String>(
                value: kondisi,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                items: const [
                  DropdownMenuItem(value: 'Baik', child: Text('Baik')),
                  DropdownMenuItem(value: 'Rusak Ringan', child: Text('Rusak Ringan')),
                  DropdownMenuItem(value: 'Rusak Berat', child: Text('Rusak Berat')),
                  DropdownMenuItem(value: 'Hilang', child: Text('Hilang')),
                ],
                onChanged: (v) => setState(() => kondisi = v!),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: hijauMuda,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    'nama': namaCtrl.text,
                    'alat': alatCtrl.text,
                    'tanggal': tanggalCtrl.text,
                    'kondisi': kondisi,
                  });
                },
                child: const Text(
                  'SIMPAN DATA',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
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
