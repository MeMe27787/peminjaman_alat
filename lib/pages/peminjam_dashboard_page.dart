import 'package:flutter/material.dart';
import '../services/alat_services.dart';
import '../services/peminjaman_service.dart';

class PeminjamDashboardPage extends StatefulWidget {
  const PeminjamDashboardPage({super.key});

  @override
  State<PeminjamDashboardPage> createState() => _PeminjamDashboardPageState();
}

class _PeminjamDashboardPageState extends State<PeminjamDashboardPage> {
  int _currentIndex = 0;
  
  // WARNA DISAMAKAN DENGAN ADMIN & PETUGAS
  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildBeranda(),
      _buildCari(),
      _buildKeranjang(),
      _buildRiwayat(),
      const Center(child: Text("Profil")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: hijauTua,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Keranjang'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }

  // ================= 1. HALAMAN BERANDA =================
  Widget _buildBeranda() {
    return Column(
      children: [
        _headerUser("Azura Aulia"),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildCategoryRow(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Alat tersedia", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("Lihat Semua", style: TextStyle(color: hijauTua, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 15),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 0.8,
                ),
                itemCount: 4,
                itemBuilder: (context, index) => _cardAlatGrid(),
              ),
              const SizedBox(height: 20),
              _bannerKembalikan(),
            ],
          ),
        ),
      ],
    );
  }

  // ================= 2. HALAMAN CARI =================
  Widget _buildCari() {
    return Column(
      children: [
        _headerUser("Azura Aulia"),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Cari alat...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: hijauMuda.withOpacity(0.3),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 5,
            itemBuilder: (context, index) => _cardAlatList(),
          ),
        )
      ],
    );
  }

  // ================= 3. HALAMAN KERANJANG =================
  Widget _buildKeranjang() {
    return Column(
      children: [
        _headerUser("Azura Aulia"),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text("Keranjang Peminjaman", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_bag_outlined, size: 100, color: hijauMuda.withOpacity(0.5)),
              const Text("Belum ada alat yang dipilih", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  // ================= 4. HALAMAN RIWAYAT =================
  Widget _buildRiwayat() {
    return Column(
      children: [
        _headerUser("Azura Aulia"),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text("Riwayat Peminjaman", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _cardRiwayat("Peminjaman #012", "Laptop", "12 Jan 2026", Colors.blue),
              _cardRiwayat("Peminjaman #011", "Obeng", "10 Jan 2026", hijauTua),
              _cardRiwayat("Peminjaman #010", "Multimeter", "08 Jan 2026", Colors.red),
            ],
          ),
        )
      ],
    );
  }

  // ================= REUSABLE WIDGETS =================

  Widget _headerUser(String nama) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: hijauMuda,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Selamat Pagi,", style: TextStyle(color: Colors.black54, fontSize: 12)),
              Text(nama, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.notifications_none, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildCategoryRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _iconCategory(Icons.handyman, "Tangan"),
        _iconCategory(Icons.straighten, "Ukur"),
        _iconCategory(Icons.electric_bolt, "Listrik"),
        _iconCategory(Icons.settings, "Angkut"),
      ],
    );
  }

  Widget _iconCategory(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: hijauMuda.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: hijauTua),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _cardAlatGrid() {
    return Container(
      decoration: BoxDecoration(color: hijauMuda.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Center(child: Icon(Icons.computer, color: hijauTua, size: 40))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Alat tersedia", style: TextStyle(fontWeight: FontWeight.bold)),
                const Text("Tersedia", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 12, backgroundColor: hijauTua,
                    child: const Icon(Icons.add, size: 15, color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _cardAlatList() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: hijauMuda.withOpacity(0.5)), 
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          Container(width: 50, height: 50, decoration: BoxDecoration(color: hijauMuda.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Icon(Icons.handyman, color: hijauTua)),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nama Alat", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Tersedia", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: hijauMuda, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: const Text("Pinjam", style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _cardRiwayat(String id, String alat, String tgl, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: statusColor, width: 5)),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(id, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(tgl, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
          const Divider(),
          Text("Alat: $alat", style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
          Text("Status: Diproses", style: TextStyle(fontSize: 12, color: statusColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _bannerKembalikan() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: hijauTua,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Kembalikan Tepat Waktu!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("Pastikan alat dalam kondisi baik.", style: TextStyle(color: Colors.white70, fontSize: 10)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {}, 
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: hijauTua),
            child: const Text("Cek"),
          ),
        ],
      ),
    );
  }
}