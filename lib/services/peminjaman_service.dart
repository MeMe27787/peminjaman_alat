import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/peminjaman_model.dart';

class PeminjamanService {
  final _supabase = Supabase.instance.client;

  // ================= READ =================
  Future<List<PeminjamanModel>> getPeminjaman() async {
    final res = await _supabase
        .from('peminjaman')
        .select('''
          id_peminjaman,
          jumlah,
          waktu_mulai,
          waktu_selesai,
          status,
          users:user_id (
            id_user,
            nama,
            kelas
          ),
          alat:alat_id (
            id_alat,
            nama_alat
          )
        ''')
        .order('created_at', ascending: false);

    return (res as List)
        .map((e) => PeminjamanModel.fromMap(e))
        .toList();
  }

  // ================= CREATE =================
  Future<void> addPeminjaman({
    required int userId,
    required int alatId,
    required int jumlah,
    required String waktuMulai,
    required String waktuSelesai,
  }) async {
    await _supabase.from('peminjaman').insert({
      'user_id': userId,
      'alat_id': alatId,
      'jumlah': jumlah,
      'waktu_mulai': waktuMulai,
      'waktu_selesai': waktuSelesai,
      'status': 'menunggu',
    });
  }

  // ================= UPDATE =================
  Future<void> updatePeminjaman({
    required int idPeminjaman,
    required int jumlah,
    required String waktuMulai,
    required String waktuSelesai,
    required String status,
  }) async {
    await _supabase.from('peminjaman').update({
      'jumlah': jumlah,
      'waktu_mulai': waktuMulai,
      'waktu_selesai': waktuSelesai,
      'status': status,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id_peminjaman', idPeminjaman);
  }

  // ================= DELETE =================
  Future<void> deletePeminjaman(int idPeminjaman) async {
    await _supabase
        .from('peminjaman')
        .delete()
        .eq('id_peminjaman', idPeminjaman);
  }
}
