import 'dart:convert';

class UserModel {
  String name;
  String cpf;
  String email;
  String phone;
  int? age;
  UserModel({
    required this.name,
    required this.cpf,
    required this.email,
    required this.phone,
    this.age,
  });

  UserModel copyWith({
    String? name,
    String? cpf,
    String? email,
    String? phone,
    int? age,
  }) {
    return UserModel(
      name: name ?? this.name,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': name,
      'cpf': cpf,
      'email': email,
      'telefone': phone,
      'idade': age,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['nome'] ?? '',
      cpf: map['cpf'] ?? '',
      email: map['email'] ?? '',
      phone: map['telefone'] ?? '',
      age: map['idade']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, cpf: $cpf, email: $email, phone: $phone, age: $age)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.cpf == cpf &&
        other.email == email &&
        other.phone == phone &&
        other.age == age;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        cpf.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        age.hashCode;
  }
}
