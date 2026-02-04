import 'package:flutter/material.dart';
import '../services/peminjaman_service.dart';
import '../services/pengembalian_service.dart';
import '../models/peminjaman_model.dart';

class PetugasDashboardPage extends StatefulWidget {
  const PetugasDashboardPage({super.key});

  @override
  State<PetugasDashboardPage> createState() => _PetugasDashboardPageState();
}

class _PetugasDashboardPageState extends State<PetugasDashboardPage> {
  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);
  
  final PeminjamanService _peminjamanService = PeminjamanService();
  final PengembalianService _pengembalianService = PengembalianService();

  int _selectedIndex = 0;

  // ================= LOGIKA CRUD =================
  
  // Fungsi Setujui Peminjaman
  Future<void> _handleApproval(int id, String status) async {
    try {
      // Mengupdate status di database via service
      // Asumsi: updatePeminjaman membutuhkan parameter yang sesuai
      await _peminjamanService.updatePeminjaman(
        idPeminjaman: id,
        status: status, // 'disetujui' atau 'ditolak'
        jumlah: 1, // Sesuaikan dengan data asli jika ada
        waktuMulai: DateTime.now().toIso8601String(),
        waktuSelesai: DateTime.now().add(const Duration(days: 3)).toIso8601String(),
      );
      if (mounted) setState(() {}); // Refresh UI
    } catch (e) {
      print("Error update status: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER (Sesuai Desain)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: hijauMuda,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(radius: 25, child: Icon(Icons.person)),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Selamat Siang,", style: TextStyle(fontSize: 12)),
                          Text("Ammelia Agustin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.notifications),
                      const SizedBox(width: 10),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Cari nama siswa...",
                      prefixIcon: const Icon(Icons.search),
                      fillColor: Colors.white.withOpacity(0.5),
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // CARD STATISTIK
                  Row(
                    children: [
                      _buildStatCard("8", "DIPINJAM", Icons.book),
                      const SizedBox(width: 15),
                      _buildStatCard("2", "TERLAMBAT", Icons.priority_high, color: Colors.red),
                    ],
                  )
                ],
              ),
            ),

            // BODY BERDASARKAN TAB
            Expanded(
              child: _selectedIndex == 0 
                ? _buildApprovalList() 
                : (_selectedIndex == 1 ? _buildMonitoringList() : _buildLaporanView()),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ================= WIDGET COMPONENT (SESUAI GAMBAR) =================

  Widget _buildStatCard(String count, String label, IconData icon, {Color color = Colors.black}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(count, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildApprovalList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("Butuh Persetujuan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 15),
        // Contoh Card Persetujuan (Gunakan FutureBuilder untuk data asli)
        _itemApprovalCard("Ammelia", "Laptop", 123),
        _itemApprovalCard("Arianto", "PC", 124),
      ],
    );
  }

  Widget _itemApprovalCard(String nama, String alat, int id) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: hijauMuda, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(child: Text("A")),
              const SizedBox(width: 10),
              Text(nama, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              const Text("29 JAN 2026", style: TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const Icon(Icons.computer),
                const SizedBox(width: 10),
                Text(alat),
                const Spacer(),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: () => _handleApproval(id, 'ditolak'), style: ElevatedButton.styleFrom(backgroundColor: Colors.white), child: const Text("Tolak", style: TextStyle(color: Colors.black)))),
              const SizedBox(width: 10),
              Expanded(child: ElevatedButton(onPressed: () => _handleApproval(id, 'disetujui'), style: ElevatedButton.styleFrom(backgroundColor: hijauTua), child: const Text("Setujui", style: TextStyle(color: Colors.white)))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMonitoringList() {
    return const Center(child: Text("Halaman Monitoring (Sesuai desain ke-2)"));
  }

  Widget _buildLaporanView() {
    return const Center(child: Text("Halaman Laporan (Sesuai desain ke-3)"));
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      selectedItemColor: hijauTua,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Pantau"),
        BottomNavigationBarItem(icon: Icon(Icons.description), label: "Laporan"),
      ],
    );
  }
}