class PeminjamanModel {
  final int id;
  final int userId;
  final int alatId;
  final int jumlah;
  final String waktuMulai;
  final String waktuSelesai;
  final String status;

  // DATA JOIN (untuk tampilan)
  final String namaUser;
  final String kelasUser;
  final String namaAlat;

  PeminjamanModel({
    required this.id,
    required this.userId,
    required this.alatId,
    required this.jumlah,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.status,
    required this.namaUser,
    required this.kelasUser,
    required this.namaAlat,
  });

  factory PeminjamanModel.fromMap(Map<String, dynamic> map) {
    return PeminjamanModel(
      id: map['id_peminjaman'],
      userId: map['user_id'],
      alatId: map['alat_id'],
      jumlah: map['jumlah'],
      waktuMulai: map['waktu_mulai'],
      waktuSelesai: map['waktu_selesai'],
      status: map['status'],
      namaUser: map['users']['nama'],
      kelasUser: map['users']['kelas'],
      namaAlat: map['alat']['nama'],
    );
  }
}
