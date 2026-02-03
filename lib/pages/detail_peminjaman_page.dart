import 'package:flutter/material.dart';

class DetailPeminjamanPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailPeminjamanPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final Color hijauMuda = const Color(0xFF8BAE66);
    final Color hijauTua = const Color(0xFF628141);

    final bool dikembalikan = data['status'] == 'dikembalikan';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: hijauMuda,
        title: const Text('Detail Peminjaman'),
        leading: const BackButton(),
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
              // ===== HEADER =====
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: hijauTua,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['nama'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(data['kelas'] ?? '-'),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _info('Nama Alat', data['alat']),
              _info('Jumlah', data['jumlah'] ?? '-'),
              _info('Tanggal Pinjam', data['tanggal']),
              _info('Batas Kembali', data['batas'] ?? '-'),
              _info(
                'Status',
                data['status'],
                valueColor: dikembalikan ? Colors.green : Colors.red,
              ),

              const Spacer(),

              // ===== BUTTON =====
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('DETAIL'),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // ===== EDIT =====
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pop(context, {
                        'action': 'edit',
                        'data': data,
                      });
                    },
                  ),

                  // ===== DELETE =====
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Hapus Peminjaman'),
                          content: const Text(
                              'Yakin ingin menghapus data ini?'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context),
                              child: const Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // dialog
                                Navigator.pop(context, {
                                  'action': 'delete'
                                });
                              },
                              child: const Text('Hapus'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(String label, String value,
      {Color valueColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
