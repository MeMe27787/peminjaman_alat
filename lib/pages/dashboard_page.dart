import 'package:flutter/material.dart';
import 'package:peminjaman/pages/user_page.dart';
import 'package:peminjaman/pages/alat_page.dart';
import 'package:peminjaman/pages/kategori_page.dart';
import 'package:peminjaman/pages/transaksi_page.dart';
import 'package:peminjaman/pages/riwayat_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);

  int _currentIndex = 0;

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
                    Text('admin', style: TextStyle(fontSize: 12)),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.notifications),
                const SizedBox(width: 12),
                const Icon(Icons.logout),
              ],
            ),
          ),
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Beranda',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  _statCard(
                    icon: Icons.person,
                    title: 'USER',
                    value: '12',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const UserPage()),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  _statCard(
                    icon: Icons.computer,
                    title: 'ALAT',
                    value: '29',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AlatPage()),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  _statCard(
                    icon: Icons.receipt_long,
                    title: 'TRANSAKSI',
                    value: '75',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TransaksiPage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  _statCard(
                    icon: Icons.category,
                    title: 'KATEGORI',
                    value: '14',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const KategoriPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              // ======== INI YANG KAMU MINTA DITAMBAHKAN ========
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: hijauMuda,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Aktifitas terkini',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Ada 2 peminjaman baru hari ini'),
                    const SizedBox(height: 12),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RiwayatPage(),
                            ),
                          );
                        },
                        child: const Text('CEK LAPORAN'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: hijauMuda,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == _currentIndex) return;

          setState(() => _currentIndex = index);

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UserPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TransaksiPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RiwayatPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Admin'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Transaksi'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        ],
      ),
    );
  }

  // ================= STAT CARD =================
  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: hijauTua,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(height: 8),
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
