import 'package:flutter/material.dart';

class PengembalianPage extends StatelessWidget {
  const PengembalianPage({super.key});

  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: hijauMuda,
        elevation: 0,
        title: const Text('Pengembalian Alat'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari pengembalian',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: hijauMuda,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // List pengembalian (dummy)
            _pengembalianCard(
              nama: 'Ammelia',
              alat: 'Laptop',
              tanggalKembali: '02 Feb 2026',
              kondisi: 'Baik',
            ),

            const SizedBox(height: 12),

            _pengembalianCard(
              nama: 'Rifky',
              alat: 'Keyboard',
              tanggalKembali: '01 Feb 2026',
              kondisi: 'Rusak Ringan',
            ),
          ],
        ),
      ),
    );
  }

  Widget _pengembalianCard({
    required String nama,
    required String alat,
    required String tanggalKembali,
    required String kondisi,
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
          Text(
            nama,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text('Alat: $alat'),
          Text('Tanggal kembali: $tanggalKembali'),
          Text('Kondisi: $kondisi'),

          const SizedBox(height: 12),

          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {},
                child: const Text('KONFIRMASI'),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.info_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}