class Akun {
  final String id;
  final String name;
  final String email;
  final String password;

  Akun({required this.id, required this.name, required this.email, required this.password, required String nama});

  factory Akun.fromJson(Map<String, dynamic> json) {
    return Akun(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String, nama: '',
    );
  }
}
