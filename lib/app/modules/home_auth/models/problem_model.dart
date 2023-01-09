// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProblemModel {
  String bardCode;
  String errorType;
  ProblemModel({
    required this.bardCode,
    required this.errorType,
  });

  ProblemModel copyWith({
    String? bardCode,
    String? errorType,
  }) {
    return ProblemModel(
      bardCode: bardCode ?? this.bardCode,
      errorType: errorType ?? this.errorType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigo_barras': bardCode,
      'tipo': errorType,
    };
  }

  factory ProblemModel.fromMap(Map<String, dynamic> map) {
    return ProblemModel(
      bardCode: map['bardCode'] as String,
      errorType: map['errorType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProblemModel.fromJson(String source) =>
      ProblemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProblemModel(bardCode: $bardCode, errorType: $errorType)';

  @override
  bool operator ==(covariant ProblemModel other) {
    if (identical(this, other)) return true;

    return other.bardCode == bardCode && other.errorType == errorType;
  }

  @override
  int get hashCode => bardCode.hashCode ^ errorType.hashCode;
}
