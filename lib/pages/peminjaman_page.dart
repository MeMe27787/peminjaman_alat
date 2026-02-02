import 'package:flutter/material.dart';
import 'buat_peminjaman_page.dart';
import 'detail_peminjaman_page.dart';

class PeminjamanPage extends StatefulWidget {
  const PeminjamanPage({super.key});

  @override
  State<PeminjamanPage> createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> {
  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);

  // ================= DATA =================
  List<Map<String, dynamic>> peminjamanList = [
    {
      'nama': 'Ammelia',
      'alat': 'Laptop',
      'tanggal': '2026-01-29',
      'status': 'dikembalikan',
    },
    {
      'nama': 'Rifky',
      'alat': 'Keyboard',
      'tanggal': '2026-01-29',
      'status': 'dipinjam',
    },
  ];

  // ================= DELETE =================
  void _hapusPeminjaman(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Data'),
        content: const Text('Yakin ingin menghapus data peminjaman ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                peminjamanList.removeAt(index);
              });
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

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: hijauMuda,
        elevation: 0,
        title: const Text('Data Peminjaman'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // ===== TAMBAH PEMINJAMAN =====
          IconButton(
            icon: const Icon(Icons.add),
           onPressed: () async {
             final result = await Navigator.push(
            context,
            MaterialPageRoute(
          builder: (_) => const BuatPeminjamanPage(),
           ),
         );
         if (result != null) {
           setState(() => peminjamanList.add(result));
           }
          },
          ),
        ],
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: peminjamanList.length,
          itemBuilder: (context, index) {
            final data = peminjamanList[index];
            final bool dikembalikan = data['status'] == 'dikembalikan';

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: hijauMuda,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== HEADER =====
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: hijauTua,
                        child: Text(
                          data['nama'][0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['nama'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(data['alat']),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ===== INFO =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tanggal\n${data['tanggal']}'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Status'),
                          Text(
                            data['status'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  dikembalikan ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ===== BUTTON =====
                  Row(
                    children: [
                      // ===== LIHAT DETAIL =====
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                       onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPeminjamanPage(data: data),
                        ),
                      );

                      if (result == 'DELETE') {
                        setState(() => peminjamanList.removeAt(index));
                      } else if (result != null) {
                        setState(() => peminjamanList[index] = result);
                      }
                    },
                        child: const Text('LIHAT DETAIL'),
                      ),
                      const Spacer(),

                      // ===== EDIT =====
                      IconButton(
                        icon: const Icon(Icons.edit),
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
                            setState(() => peminjamanList[index] = result);
                          }
                        },
                      ),

                      // ===== DELETE =====
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _hapusPeminjaman(index),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
