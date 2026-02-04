class PengembalianModel {
  final int idPeminjaman;
  final String namaUser;
  final String namaAlat;
  final int jumlah;
  final DateTime waktuMulai;
  final DateTime waktuSelesai;
  final DateTime? waktuKembaliAktual;
  final String status;

  PengembalianModel({
    required this.idPeminjaman,
    required this.namaUser,
    required this.namaAlat,
    required this.jumlah,
    required this.waktuMulai,
    required this.waktuSelesai,
    this.waktuKembaliAktual,
    required this.status,
  });

  // Factory untuk memetakan data dari Join Query Supabase
  factory PengembalianModel.fromMap(Map<String, dynamic> map) {
    return PengembalianModel(
      idPeminjaman: map['id_peminjaman'] ?? 0,
      // Mengambil data dari nested map hasil join table users dan alat
      namaUser: map['users']?['nama'] ?? 'Tanpa Nama',
      namaAlat: map['alat']?['nama_alat'] ?? 'Alat Tidak Diketahui',
      jumlah: map['jumlah'] ?? 0,
      waktuMulai: DateTime.parse(map['waktu_mulai']),
      waktuSelesai: DateTime.parse(map['waktu_selesai']),
      waktuKembaliAktual: map['waktu_kembali_aktual'] != null 
          ? DateTime.parse(map['waktu_kembali_aktual']) 
          : null,
      status: map['status'] ?? 'menunggu',
    );
  }

  // Method untuk mempermudah konversi ke Map jika diperlukan (misal untuk update)
  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'waktu_kembali_aktual': waktuKembaliAktual?.toIso8601String(),
    };
  }
}