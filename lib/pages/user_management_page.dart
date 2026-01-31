import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);

  final List<UserModel> users = [
    UserModel(
      id: 1,
      nama: 'Ammelia',
      kelas: 'XII RPL 3',
      peran: 'Admin',
      status: 'Aktif',
    ),
    UserModel(
      id: 2,
      nama: 'Rifky',
      kelas: 'XII DKV 2',
      peran: 'Petugas',
      status: 'Tidak Aktif',
    ),
  ];

  int _idCounter = 3;

  // ================= FORM (CREATE & UPDATE) =================
  void _showForm({UserModel? user}) {
    final namaController = TextEditingController(text: user?.nama ?? '');
    final kelasController = TextEditingController(text: user?.kelas ?? '');
    String peran = user?.peran ?? 'Siswa';
    String status = user?.status ?? 'Aktif';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(user == null ? 'Tambah User' : 'Edit User'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: kelasController,
                decoration: const InputDecoration(labelText: 'Kelas'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField(
                value: peran,
                items: const [
                  DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                  DropdownMenuItem(value: 'Petugas', child: Text('Petugas')),
                  DropdownMenuItem(value: 'Siswa', child: Text('Siswa')),
                ],
                onChanged: (v) => peran = v!,
                decoration: const InputDecoration(labelText: 'Peran'),
              ),
              DropdownButtonFormField(
                value: status,
                items: const [
                  DropdownMenuItem(value: 'Aktif', child: Text('Aktif')),
                  DropdownMenuItem(
                      value: 'Tidak Aktif', child: Text('Tidak Aktif')),
                ],
                onChanged: (v) => status = v!,
                decoration: const InputDecoration(labelText: 'Status'),
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
                if (user == null) {
                  // CREATE
                  users.add(
                    UserModel(
                      id: _idCounter++,
                      nama: namaController.text,
                      kelas: kelasController.text,
                      peran: peran,
                      status: status,
                    ),
                  );
                } else {
                  // UPDATE
                  user.nama = namaController.text;
                  user.kelas = kelasController.text;
                  user.peran = peran;
                  user.status = status;
                }
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
  void _deleteUser(UserModel user) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus User'),
        content: Text('Yakin hapus ${user.nama}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                users.remove(user);
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
        title: const Text('Management User'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Tombol back berfungsi
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showForm(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final bool aktif = user.status == 'Aktif';

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: hijauMuda,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: hijauTua,
                    child: Text(
                      user.nama[0],
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.nama,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(user.kelas),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text('Peran: ${user.peran}'),
                            const SizedBox(width: 12),
                            Text(
                              'Status: ${user.status}',
                              style: TextStyle(
                                color: aktif ? Colors.green : Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // // Panggil halaman profil
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (_) =>
                                //         UserProfilePage(user: user),
                                //   ),
                                // );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('LIHAT PROFIL'),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showForm(user: user),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteUser(user),
                            ),
                          ],
                        )
                      ],
                    ),
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
