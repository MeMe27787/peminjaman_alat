import 'package:flutter/material.dart';
import '../models/alat_model.dart';
import 'package:peminjaman/pages/transaksi_page.dart';

class AlatDetailPage extends StatefulWidget {
  final AlatModel alat;

  const AlatDetailPage({super.key, required this.alat});

  @override
  State<AlatDetailPage> createState() => _AlatDetailPageState();
}

class _AlatDetailPageState extends State<AlatDetailPage> {
  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);

  // ================= EDIT =================
  void _editAlat() {
    final namaController = TextEditingController(text: widget.alat.nama);
    final stokController =
        TextEditingController(text: widget.alat.stok.toString());
    final deskripsiController =
        TextEditingController(text: widget.alat.deskripsi);
    String kondisi = widget.alat.kondisi;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Alat'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama Alat'),
              ),
              TextField(
                controller: stokController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Stok'),
              ),
              DropdownButtonFormField(
                value: kondisi,
                items: const [
                  DropdownMenuItem(value: 'Baik', child: Text('Baik')),
                  DropdownMenuItem(
                      value: 'Rusak Ringan', child: Text('Rusak Ringan')),
                  DropdownMenuItem(
                      value: 'Rusak Berat', child: Text('Rusak Berat')),
                ],
                onChanged: (v) => kondisi = v!,
                decoration: const InputDecoration(labelText: 'Kondisi'),
              ),
              TextField(
                controller: deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.alat.nama = namaController.text;
                widget.alat.stok = int.parse(stokController.text);
                widget.alat.kondisi = kondisi;
                widget.alat.deskripsi = deskripsiController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  // ================= DELETE =================
  void _hapusAlat() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Alat'),
        content: Text('Yakin hapus ${widget.alat.nama}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: hijauMuda,
        elevation: 0,
        title: const Text('Detail Alat'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: hijauMuda,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ICON & NAMA
              Center(
                child: Column(
                  children: [
                    const Icon(Icons.computer, size: 64),
                    const SizedBox(height: 8),
                    Text(
                      widget.alat.nama,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              _info('Stok Tersedia', '${widget.alat.stok} Unit'),
              _info('Kondisi', widget.alat.kondisi),

              const SizedBox(height: 16),

              // ===== DESKRIPSI (INI YANG DIBENAHI) =====
              const Text(
                'DESKRIPSI ALAT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.alat.deskripsi,
                  style: const TextStyle(fontSize: 14),
                ),
              ),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _editAlat,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('EDIT DATA'),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: _hapusAlat,
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(': $value'),
      ],
    );
  }
}
