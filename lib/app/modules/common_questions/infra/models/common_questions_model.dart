import 'dart:convert';

import 'package:mercado_justo/app/modules/common_questions/domain/entities/common_questions_entity.dart';

class CommonQuestionsModel extends CommonQuestionEntity {
  CommonQuestionsModel({required String question, required String answer})
      : super(question: question, answer: answer);

  Map<String, dynamic> toMap() {
    return {'pergunta': question, 'resposta': answer};
  }

  factory CommonQuestionsModel.fromMap(Map<String, dynamic> map) {
    return CommonQuestionsModel(
        question: map['pergunta'] ?? '', answer: map['resposta']);
  }

  String toJson() => json.encode(toMap());

  factory CommonQuestionsModel.fromJson(String source) =>
      CommonQuestionsModel.fromMap(json.decode(source));

  @override
  String toString() => 'CommonQuestionsModel(question: $question)';

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is CommonQuestionsModel &&
  //     other.id == id;
  // }

  // @override
  // int get hashCode => id.hashCode;

}
