import 'package:flutter/material.dart';
import 'buat_pengembalian_page.dart';
import 'detail_pengembalian_page.dart';

class PengembalianPage extends StatefulWidget {
  const PengembalianPage({super.key});

  @override
  State<PengembalianPage> createState() => _PengembalianPageState();
}

class _PengembalianPageState extends State<PengembalianPage> {
  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);

  List<Map<String, dynamic>> pengembalianList = [
    {
      'nama': 'Ammelia',
      'alat': 'Laptop',
      'tanggal': '12-02-2026',
      'kondisi': 'Baik',
      'admin': 'Admin',
      'admin_id': '12',
    },
    {
      'nama': 'Rifky',
      'alat': 'Keyboard',
      'tanggal': '01-02-2026',
      'kondisi': 'Rusak Ringan',
      'admin': 'Admin',
      'admin_id': '12',
    },
  ];

  void _hapusData(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => pengembalianList.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hijauMuda,
        title: const Text('Pengembalian Alat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push<Map<String, dynamic>>(
                context,
                MaterialPageRoute(
                  builder: (_) => const BuatPengembalianPage(isEdit: false),
                ),
              );
              if (result != null) {
                setState(() => pengembalianList.add(result));
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pengembalianList.length,
        itemBuilder: (context, index) {
          final data = pengembalianList[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: hijauMuda,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: hijauTua,
                      child: Text(
                        data['nama'][0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['nama'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(data['alat']),
                      ],
                    ),
                  ],
                ),

                const Divider(),

                Text('Tanggal : ${data['tanggal']}'),
                Text(
                  'Kondisi : ${data['kondisi']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPengembalianPage(data: data),
                          ),
                        );
                      },
                      child: const Text('LIIHAT DATA'),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _hapusData(index),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}