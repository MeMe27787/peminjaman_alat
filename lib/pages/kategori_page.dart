import 'package:flutter/material.dart';

class KategoriPage extends StatelessWidget {
  const KategoriPage({super.key});

  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: hijauMuda,
        elevation: 0,
        title: const Text('Data Kategori'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // NANTI: tambah kategori
            },
          )
        ],
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _kategoriCard(
              context,
              no: '01',
              nama: 'Perangkat Utama',
              jumlah: '12',
            ),
            const SizedBox(height: 12),
            _kategoriCard(
              context,
              no: '02',
              nama: 'Perangkat Input',
              jumlah: '7',
            ),
          ],
        ),
      ),
    );
  }

  // ================= CARD KATEGORI =================
  Widget _kategoriCard(
    BuildContext context, {
    required String no,
    required String nama,
    required String jumlah,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: hijauMuda,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== HEADER =====
          Row(
            children: [
              Text(
                '#$no',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _konfirmasiHapus(context);
                },
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ===== JUMLAH =====
          Text('JUMLAH : $jumlah'),

          const SizedBox(height: 12),

          // ===== TOMBOL =====
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hijauTua,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    // NANTI: detail kategori
                  },
                  child: const Text('DETAIL'),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // NANTI: edit kategori
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= DIALOG HAPUS =================
  void _konfirmasiHapus(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Yakin ingin menghapus?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // NANTI: hapus kategori
              },
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
