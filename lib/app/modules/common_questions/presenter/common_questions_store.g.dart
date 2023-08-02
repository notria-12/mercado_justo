// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_questions_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CommonQuestionsStore on _CommonQuestionsStoreBase, Store {
  late final _$commonQuestionsAtom =
      Atom(name: '_CommonQuestionsStoreBase.commonQuestions', context: context);

  @override
  List<CommonQuestionEntity> get commonQuestions {
    _$commonQuestionsAtom.reportRead();
    return super.commonQuestions;
  }

  @override
  set commonQuestions(List<CommonQuestionEntity> value) {
    _$commonQuestionsAtom.reportWrite(value, super.commonQuestions, () {
      super.commonQuestions = value;
    });
  }

  late final _$commonQuestionsStateAtom = Atom(
      name: '_CommonQuestionsStoreBase.commonQuestionsState', context: context);

  @override
  AppState get commonQuestionsState {
    _$commonQuestionsStateAtom.reportRead();
    return super.commonQuestionsState;
  }

  @override
  set commonQuestionsState(AppState value) {
    _$commonQuestionsStateAtom.reportWrite(value, super.commonQuestionsState,
        () {
      super.commonQuestionsState = value;
    });
  }

  @override
  String toString() {
    return '''
commonQuestions: ${commonQuestions},
commonQuestionsState: ${commonQuestionsState}
    ''';
  }
}
