import 'package:flutter/material.dart';

class PeminjamanPage extends StatelessWidget {
  const PeminjamanPage({super.key});

  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: hijauMuda,
        elevation: 0,
        title: const Text('Peminjaman Alat'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // nanti untuk tambah peminjaman
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari peminjam',
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

            // List peminjaman (dummy)
            _peminjamanCard(
              nama: 'Ammelia',
              alat: 'Laptop',
              tanggal: '31 Jan 2026',
              status: 'Dipinjam',
            ),

            const SizedBox(height: 12),

            _peminjamanCard(
              nama: 'Rifky',
              alat: 'Keyboard',
              tanggal: '30 Jan 2026',
              status: 'Dipinjam',
            ),
          ],
        ),
      ),
    );
  }

  Widget _peminjamanCard({
    required String nama,
    required String alat,
    required String tanggal,
    required String status,
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
          Text('Tanggal: $tanggal'),
          Text('Status: $status'),

          const SizedBox(height: 12),

          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {},
                child: const Text('DETAIL'),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
