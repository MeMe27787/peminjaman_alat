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

  List<Map<String, dynamic>> peminjamanList = [
    {
      'nama': 'Ammelia',
      'kelas': 'XII RPL 3',
      'alat': 'Laptop',
      'jumlah': '1',
      'tanggal': '2026-01-29',
      'batas': '2026-02-02',
      'status': 'dikembalikan',
    },
    {
      'nama': 'Rifky',
      'kelas': 'XII DKV 2',
      'alat': 'Keyboard',
      'jumlah': '1',
      'tanggal': '2026-01-29',
      'batas': '2026-02-01',
      'status': 'dipinjam',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: hijauMuda,
        title: const Text('Data Peminjaman'),
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push<Map<String, dynamic>>(
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: peminjamanList.length,
        itemBuilder: (context, index) {
          final data = peminjamanList[index];
          final dikembalikan = data['status'] == 'dikembalikan';

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
                // HEADER
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

                Row(
                  children: [
                    // ===== DETAIL =====
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailPeminjamanPage(data: data),
                          ),
                        );

                        if (result == null) return;

                        if (result['action'] == 'delete') {
                          setState(() => peminjamanList.removeAt(index));
                        }

                        if (result['action'] == 'edit') {
                          final edited =
                              await Navigator.push<Map<String, dynamic>>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BuatPeminjamanPage(
                                isEdit: true,
                                data: data,
                              ),
                            ),
                          );

                          if (edited != null) {
                            setState(
                                () => peminjamanList[index] = edited);
                          }
                        }
                      },
                      child: const Text('LIHAT DETAIL'),
                    ),
                    const Spacer(),

                    // ===== EDIT =====
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final edited =
                            await Navigator.push<Map<String, dynamic>>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BuatPeminjamanPage(
                              isEdit: true,
                              data: data,
                            ),
                          ),
                        );

                        if (edited != null) {
                          setState(() => peminjamanList[index] = edited);
                        }
                      },
                    ),

                    // ===== DELETE =====
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Hapus Data'),
                            content: const Text(
                                'Yakin ingin menghapus peminjaman ini?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context),
                                child: const Text('Batal'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() =>
                                      peminjamanList.removeAt(index));
                                  Navigator.pop(context);
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
          );
        },
      ),
    );
  }
}