import 'dart:convert';

import 'package:mercado_justo/app/modules/terms_and_conditions/domain/entities/use_terms_entity.dart';

class UseTermsModel extends UseTermsEntity {
  UseTermsModel({required String text}) : super(text: text);

  Map<String, dynamic> toMap() {
    return {'texto': text};
  }

  factory UseTermsModel.fromMap(Map<String, dynamic> map) {
    return UseTermsModel(text: map['texto']);
  }

  String toJson() => json.encode(toMap());

  factory UseTermsModel.fromJson(String source) =>
      UseTermsModel.fromMap(json.decode(source));

  @override
  String toString() => 'UseTermsModel(text: $text)';
}
