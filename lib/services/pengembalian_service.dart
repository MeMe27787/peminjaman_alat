import 'package:supabase_flutter/supabase_flutter.dart';

class PengembalianService {
  final _supabase = Supabase.instance.client;

  // Verifikasi alat kembali (Update status di tabel peminjaman)
  Future<void> prosesPengembalian(int idPeminjaman) async {
    await _supabase.from('peminjaman').update({
      'status': 'kembali',
      'waktu_kembali_aktual': DateTime.now().toIso8601String(),
    }).eq('id_peminjaman', idPeminjaman);
  }

  // Ambil daftar alat yang sedang dipinjam (untuk ditampilkan di Page Pengembalian)
  Future<List<Map<String, dynamic>>> getAlatDipinjam() async {
    return await _supabase
        .from('peminjaman')
        .select('*, users:user_id(nama), alat:alat_id(nama_alat)')
        .eq('status', 'dipinjam');
  }
}