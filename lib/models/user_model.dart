class UserModel {
  final int id;
  String nama;
  String kelas;
  String peran;
  String status;

  UserModel({
    required this.id,
    required this.nama,
    required this.kelas,
    required this.peran,
    required this.status,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      nama: map['nama'] as String,
      kelas: map['kelas'] as String,
      peran: map['peran'] as String,
      status: map['status'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'kelas': kelas,
      'peran': peran,
      'status': status,
    };
  }
}
