// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String id;
  String name;
  String cpf;
  String email;
  String phone;
  int? age;
  String? genre;
  AddressModel? address;
  DateTime? registerDate;
  UserModel(
      {required this.id,
      required this.name,
      required this.cpf,
      required this.email,
      required this.phone,
      this.age,
      this.genre,
      this.address,
      this.registerDate});

  UserModel copyWith(
      {String? name,
      String? cpf,
      String? email,
      String? phone,
      int? age,
      String? id,
      String? genre,
      DateTime? registerDate,
      AddressModel? address}) {
    return UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        cpf: cpf ?? this.cpf,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        age: age ?? this.age,
        genre: genre ?? this.genre,
        address: address ?? this.address,
        registerDate: registerDate ?? this.registerDate);
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': name,
      'cpf': cpf,
      'email': email,
      'telefone': phone,
      'id': id,
      'idade': age,
      'orientacao': genre,
      if (address != null) 'endereco': address!.toMap()
    };
  }

  Map<String, dynamic> toMapStorage() {
    return {
      'id': id,
      'nome': name,
      'cpf': cpf,
      'email': email,
      'telefone': phone,
      'idade': age,
      'orientacao': genre,
      'data_cadastro': registerDate.toString()
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'],
        name: map['nome'] ?? '',
        cpf: map['cpf'] ?? '',
        email: map['email'] ?? '',
        phone: map['telefone'] ?? '',
        age: map['idade']?.toInt(),
        genre: map['orientacao'],
        registerDate: map['data_cadastro'] != null
            ? DateTime.tryParse(map['data_cadastro'])
            : null,
        address: map['endereco'] != null
            ? AddressModel.fromMap(map['endereco'])
            : null);
  }

  String toJson() => json.encode(toMap());
  String toJsonStorage() => json.encode(toMapStorage());

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

class AddressModel {
  String state;
  String city;
  String? street;
  String? neighborhood;
  String? number;
  String? cep;
  String? complement;
  AddressModel({
    required this.state,
    required this.city,
    this.street,
    this.neighborhood,
    this.number,
    this.cep,
    this.complement,
  });

  AddressModel copyWith({
    String? state,
    String? city,
    String? street,
    String? neighborhood,
    String? number,
    String? cep,
    String? complement,
  }) {
    return AddressModel(
      state: state ?? this.state,
      city: city ?? this.city,
      street: street ?? this.street,
      neighborhood: neighborhood ?? this.neighborhood,
      number: number ?? this.number,
      cep: cep ?? this.cep,
      complement: complement ?? this.complement,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uf': state,
      'cidade': city,
      if (street != null) 'rua': street,
      if (neighborhood != null) 'bairro': neighborhood,
      if (number != null) 'numero': number,
      if (cep != null) 'cep': cep,
      if (complement != null) 'complemento': complement,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      state: map['uf'] as String,
      city: map['cidade'] as String,
      street: map['rua'] != null ? map['rua'] as String : null,
      neighborhood: map['bairro'] != null ? map['bairro'] as String : null,
      number: map['numero'] != null ? map['numero'] as String : null,
      cep: map['cep'] != null ? map['cep'] as String : null,
      complement:
          map['complemento'] != null ? map['complemento'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressModel(state: $state, city: $city, street: $street, neighborhood: $neighborhood, number: $number, cep: $cep, complement: $complement)';
  }

  @override
  bool operator ==(covariant AddressModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.city == city &&
        other.street == street &&
        other.neighborhood == neighborhood &&
        other.number == number &&
        other.cep == cep &&
        other.complement == complement;
  }

  @override
  int get hashCode {
    return state.hashCode ^
        city.hashCode ^
        street.hashCode ^
        neighborhood.hashCode ^
        number.hashCode ^
        cep.hashCode ^
        complement.hashCode;
  }
}
