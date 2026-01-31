import 'package:peminjaman/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final _supabase = Supabase.instance.client;

  // READ
  Future<List<UserModel>> getUsers() async {
    final res = await _supabase.from('users').select();
    return (res as List)
        .map((e) => UserModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  // CREATE
  Future<void> addUser({
    required String nama,
    required String kelas,
    required String peran,
  }) async {
    await _supabase.from('users').insert({
      'nama': nama,
      'kelas': kelas,
      'peran': peran,
      'status': 'Aktif',
    });
  }

  // UPDATE
  Future<void> updateUser({
    required int id,
    required String nama,
    required String kelas,
    required String peran,
    required String status,
  }) async {
    await _supabase.from('users').update({
      'nama': nama,
      'kelas': kelas,
      'peran': peran,
      'status': status,
    }).eq('id', id);
  }

  // DELETE
  Future<void> deleteUser(int id) async {
    await _supabase.from('users').delete().eq('id', id);
  }
}
