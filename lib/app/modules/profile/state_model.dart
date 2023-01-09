// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StateModel {
  String id;
  String sigla;
  String nome;
  StateModel({
    required this.id,
    required this.sigla,
    required this.nome,
  });

  StateModel copyWith({
    String? id,
    String? sigla,
    String? nome,
  }) {
    return StateModel(
      id: id ?? this.id,
      sigla: sigla ?? this.sigla,
      nome: nome ?? this.nome,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sigla': sigla,
      'nome': nome,
    };
  }

  factory StateModel.fromMap(Map<String, dynamic> map) {
    return StateModel(
      id: map['_id'] as String,
      sigla: map['sigla'] as String,
      nome: map['nome'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StateModel.fromJson(String source) =>
      StateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StateModel(id: $id, sigla: $sigla, nome: $nome)';

  @override
  bool operator ==(covariant StateModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.sigla == sigla && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ sigla.hashCode ^ nome.hashCode;
}
