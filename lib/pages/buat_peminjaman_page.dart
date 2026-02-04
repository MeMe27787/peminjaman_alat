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
  late TextEditingController kelasCtrl;
  late TextEditingController alatCtrl;
  late TextEditingController jumlahCtrl;
  late TextEditingController tanggalCtrl;
  late TextEditingController batasCtrl;

  @override
  void initState() {
    super.initState();

    // PREFILL SAAT EDIT
    namaCtrl = TextEditingController(text: widget.data?['nama'] ?? '');
    kelasCtrl = TextEditingController(text: widget.data?['kelas'] ?? '');
    alatCtrl = TextEditingController(text: widget.data?['alat'] ?? '');
    jumlahCtrl = TextEditingController(text: widget.data?['jumlah'] ?? '');
    tanggalCtrl =
        TextEditingController(text: widget.data?['tanggal'] ?? '');
    batasCtrl =
        TextEditingController(text: widget.data?['batas'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: hijauMuda,
        title:
            Text(widget.isEdit ? 'Edit Peminjaman' : 'Buat Peminjaman'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _input('Nama Peminjam', namaCtrl),
            _input('Kelas', kelasCtrl),
            _input('Nama Alat', alatCtrl),
            _input('Jumlah Pinjam', jumlahCtrl,
                keyboard: TextInputType.number),
            _input('Tanggal Pinjam', tanggalCtrl),
            _input('Batas Pengembalian', batasCtrl),

            const SizedBox(height: 20),

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
                    'kelas': kelasCtrl.text,
                    'alat': alatCtrl.text,
                    'jumlah': jumlahCtrl.text,
                    'tanggal': tanggalCtrl.text,
                    'batas': batasCtrl.text,
                    'status':
                        widget.data?['status'] ?? 'dipinjam',
                  });
                },
                child: const Text(
                  'SIMPAN DATA',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _input(
    String label,
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
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