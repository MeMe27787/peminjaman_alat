import 'package:flutter/material.dart';
import 'buat_pengembalian_page.dart';

class DetailPengembalianPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailPengembalianPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final Color hijauMuda = const Color(0xFF8BAE66);
    final Color hijauTua = const Color(0xFF628141);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: hijauMuda,
        title: const Text('Detail Pengembalian'),
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
                    child: Text(
                      data['nama'][0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                      Text(data['alat']),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ===== INFO =====
              _infoRow('Tanggal Kembali', data['tanggal']),
              const SizedBox(height: 8),
              _infoRow('Kondisi Barang', data['kondisi']),
              const SizedBox(height: 8),
              _infoRow('Disetujui Oleh', 'Admin (ID: 12)'),

              const Spacer(),

              // ===== BUTTON ROW (INI YANG DIPERBAIKI) =====
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
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BuatPengembalianPage(
                              isEdit: true,
                              data: data,
                            ),
                          ),
                        );

                        if (result != null) {
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('EDIT DATA'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      Navigator.pop(context, 'DELETE');
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

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}