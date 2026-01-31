import 'package:flutter/material.dart';

class TransaksiPage extends StatelessWidget {
  const TransaksiPage({super.key});

  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: hijauMuda,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ammelia Agustin',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'admin',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(Icons.notifications),
                const SizedBox(width: 12),
                Icon(Icons.logout),
              ],
            ),
          ),
        ),
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'TRANSAKSI',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // ===== MENU PEMINJAMAN =====
            _menuTransaksi(
              context,
              icon: Icons.compare_arrows,
              title: 'Peminjaman Alat',
              subtitle: 'Catatan alat keluar',
              onTap: () {
                // NANTI: ke halaman peminjaman
              },
            ),

            const SizedBox(height: 16),

            // ===== MENU PENGEMBALIAN =====
            _menuTransaksi(
              context,
              icon: Icons.assignment_turned_in,
              title: 'Pengembalian',
              subtitle: 'Verifikasi alat kembali',
              onTap: () {
                // NANTI: ke halaman pengembalian
              },
            ),
          ],
        ),
      ),

       // ================= BOTTOM NAV =================
   bottomNavigationBar: BottomNavigationBar(
  currentIndex: 2,
  backgroundColor: hijauMuda,
  selectedItemColor: Colors.black,
  unselectedItemColor: Colors.black54,
  type: BottomNavigationBarType.fixed,
  onTap: (index) {
    if (index == 0) {
      Navigator.pop(context); // balik ke dashboard
    }
    if (index == 1) {
      Navigator.pop(context); // balik ke admin
    }
    if (index == 2) {
      // sedang di transaksi → diam
    }
    if (index == 3) {
      // nanti ke halaman riwayat
    }
  },
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.group),
      label: 'Admin',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.receipt_long),
      label: 'Transaksi',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.history),
      label: 'Riwayat',
    ),
  ],
),

      );
  }

  // ================= CARD MENU =================
  Widget _menuTransaksi(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: hijauTua,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.black),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
