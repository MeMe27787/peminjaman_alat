import 'package:flutter/material.dart';
import 'buat_peminjaman_page.dart';

class DetailPeminjamanPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailPeminjamanPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Color hijau = const Color(0xFF8BAE66);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: hijau,
        title: const Text('Detail Peminjaman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: hijau,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama : ${data['nama']}'),
              Text('Alat : ${data['alat']}'),
              Text(
                'Status : ${data['status']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: data['status'] == 'dipinjam'
                      ? Colors.red
                      : Colors.green,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BuatPeminjamanPage(
                            isEdit: true,
                            data: data,
                          ),
                        ),
                      );

                      if (result != null) {
                        Navigator.pop(context, result);
                      }
                    },
                    child: const Text('EDIT'),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context, 'DELETE');
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
