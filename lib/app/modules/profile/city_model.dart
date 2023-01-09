// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CityModel {
  String id;
  String name;
  String state;
  CityModel({
    required this.id,
    required this.name,
    required this.state,
  });

  CityModel copyWith({
    String? id,
    String? name,
    String? state,
  }) {
    return CityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'state': state,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['_id'] as String,
      name: map['nome'] as String,
      state: map['estado'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CityModel(id: $id, name: $name, state: $state)';

  @override
  bool operator ==(covariant CityModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.state == state;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ state.hashCode;
}
