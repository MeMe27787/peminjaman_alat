import 'package:supabase_flutter/supabase_flutter.dart';

class AlatService {
  final _supabase = Supabase.instance.client;

  // READ
  Future<List<Map<String, dynamic>>> getAlat() async {
    final res = await _supabase
        .from('alat')
        .select('*, kategori:kategori_id(nama_kategori)')
        .order('nama_alat', ascending: true);
    return res as List<Map<String, dynamic>>;
  }

  // CREATE
  Future<void> addAlat(Map<String, dynamic> data) async {
    await _supabase.from('alat').insert(data);
  }

  // UPDATE
  Future<void> updateAlat(int id, Map<String, dynamic> data) async {
    await _supabase.from('alat').update(data).eq('id_alat', id);
  }

  // DELETE
  Future<void> deleteAlat(int id) async {
    await _supabase.from('alat').delete().eq('id_alat', id);
  }
}