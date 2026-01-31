import 'package:flutter/material.dart';
import '../models/alat_model.dart';
import 'alat_detail_page.dart';

class AlatPage extends StatefulWidget {
  const AlatPage({super.key});

  @override
  State<AlatPage> createState() => _AlatPageState();
}

class _AlatPageState extends State<AlatPage> {
  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);

  int _idCounter = 3;

  // ================= DATA DUMMY =================
  final List<AlatModel> alatList = [
    AlatModel(
      id: 1,
      nama: 'Laptop',
      kategori: 'Perangkat Utama',
      stok: 9,
      kondisi: 'Baik',
      deskripsi: 'Digunakan untuk kegiatan praktikum',
    ),
    AlatModel(
      id: 2,
      nama: 'Keyboard',
      kategori: 'Perangkat Input',
      stok: 7,
      kondisi: 'Rusak Ringan',
      deskripsi: 'Beberapa tombol kurang responsif',
    ),
  ];

  // ================= TAMBAH ALAT =================
  void _tambahAlat() {
    final namaController = TextEditingController();
    final kategoriController = TextEditingController();
    final stokController = TextEditingController();
    final deskripsiController = TextEditingController();
    String kondisi = 'Baik';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Alat'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama Alat'),
              ),
              TextField(
                controller: kategoriController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              TextField(
                controller: stokController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Stok Awal'),
              ),
              DropdownButtonFormField(
                value: kondisi,
                items: const [
                  DropdownMenuItem(value: 'Baik', child: Text('Baik')),
                  DropdownMenuItem(
                      value: 'Rusak Ringan', child: Text('Rusak Ringan')),
                  DropdownMenuItem(
                      value: 'Rusak Berat', child: Text('Rusak Berat')),
                ],
                onChanged: (v) => kondisi = v!,
                decoration: const InputDecoration(labelText: 'Kondisi'),
              ),
              TextField(
                controller: deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                alatList.add(
                  AlatModel(
                    id: _idCounter++,
                    nama: namaController.text,
                    kategori: kategoriController.text,
                    stok: int.parse(stokController.text),
                    kondisi: kondisi,
                    deskripsi: deskripsiController.text,
                  ),
                );
              });
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  // ================= DELETE =================
  void _hapusAlat(AlatModel alat) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Alat'),
        content: Text('Yakin hapus ${alat.nama}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                alatList.remove(alat);
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

      appBar: AppBar(
        backgroundColor: hijauMuda,
        elevation: 0,
        title: const Text('Data Alat'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _tambahAlat, // ✅ FUNGSI DITAMBAHKAN
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari',
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

            Expanded(
              child: ListView.builder(
                itemCount: alatList.length,
                itemBuilder: (context, index) {
                  final alat = alatList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _alatCard(alat),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _alatCard(AlatModel alat) {
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
            '${alat.id.toString().padLeft(2, '0')}. ${alat.nama}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Stok: ${alat.stok} Unit'),
          Text('Kondisi: ${alat.kondisi}'),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AlatDetailPage(alat: alat),
                    ),
                  );
                },
                child: const Text('LIHAT DETAIL'),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AlatDetailPage(alat: alat),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _hapusAlat(alat),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
