import 'package:flutter/material.dart';
import '../models/kategori_model.dart';
import 'kategori_detail_page.dart';

class KategoriPage extends StatefulWidget {
  const KategoriPage({super.key});

  @override
  State<KategoriPage> createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);

  int _idCounter = 3;

  final List<KategoriModel> kategoriList = [
    KategoriModel(
      id: 1,
      nama: 'Perangkat Utama',
      deskripsi: 'Perangkat utama praktikum',
      jumlah: 12,
    ),
    KategoriModel(
      id: 2,
      nama: 'Perangkat Input',
      deskripsi: 'Perangkat input komputer',
      jumlah: 7,
    ),
  ];

  // ================= TAMBAH / EDIT =================
  void _formKategori({KategoriModel? kategori}) {
    final namaController =
        TextEditingController(text: kategori?.nama ?? '');
    final deskripsiController =
        TextEditingController(text: kategori?.deskripsi ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(kategori == null ? 'Tambah Kategori' : 'Edit Kategori'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama Kategori'),
            ),
            TextField(
              controller: deskripsiController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (kategori == null) {
                  kategoriList.add(
                    KategoriModel(
                      id: _idCounter++,
                      nama: namaController.text,
                      deskripsi: deskripsiController.text,
                      jumlah: 0,
                    ),
                  );
                } else {
                  kategori.nama = namaController.text;
                  kategori.deskripsi = deskripsiController.text;
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Simpan Kategori'),
          ),
        ],
      ),
    );
  }

  // ================= HAPUS =================
  void _hapusKategori(KategoriModel kategori) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Yakin ingin menghapus?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                kategoriList.remove(kategori);
              });
              Navigator.pop(context);
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.red),
            ),
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
        title: const Text('Data Kategori'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _formKategori(),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: kategoriList.length,
          itemBuilder: (context, index) {
            final kategori = kategoriList[index];
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
                  Row(
                    children: [
                      Text(
                        '#${kategori.id.toString().padLeft(2, '0')}  ${kategori.nama}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _hapusKategori(kategori),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('JUMLAH : ${kategori.jumlah}'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: hijauTua,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                         Navigator.push(
                           context,
                        MaterialPageRoute(
                           builder: (_) => KategoriDetailPage(
                            kategori: kategori,
                        onUpdate: (_) => setState(() {}),
                            onDelete: (kat) {
                             setState(() {
                             kategoriList.remove(kat);
                         });
                       },
                    ),
                 ),
              );
                          },
                          child: const Text('DETAIL'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _formKategori(kategori: kategori),
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
