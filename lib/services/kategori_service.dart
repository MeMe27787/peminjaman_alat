import 'package:supabase_flutter/supabase_flutter.dart';

class KategoriService {
  final _supabase = Supabase.instance.client;

  // READ
  Future<List<Map<String, dynamic>>> getKategori() async {
    return await _supabase.from('kategori').select().order('nama_kategori');
  }

  // CREATE
  Future<void> addKategori(String nama) async {
    await _supabase.from('kategori').insert({'nama_kategori': nama});
  }

  // DELETE
  Future<void> deleteKategori(int id) async {
    await _supabase.from('kategori').delete().eq('id_kategori', id);
  }
}