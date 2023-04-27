// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProblemStore on _ProblemStoreBase, Store {
  final _$problemStatusAtom = Atom(name: '_ProblemStoreBase.problemStatus');

  @override
  AppState get problemStatus {
    _$problemStatusAtom.reportRead();
    return super.problemStatus;
  }

  @override
  set problemStatus(AppState value) {
    _$problemStatusAtom.reportWrite(value, super.problemStatus, () {
      super.problemStatus = value;
    });
  }

  final _$problemTypeAtom = Atom(name: '_ProblemStoreBase.problemType');

  @override
  String get problemType {
    _$problemTypeAtom.reportRead();
    return super.problemType;
  }

  @override
  set problemType(String value) {
    _$problemTypeAtom.reportWrite(value, super.problemType, () {
      super.problemType = value;
    });
  }

  @override
  String toString() {
    return '''
problemStatus: ${problemStatus},
problemType: ${problemType}
    ''';
  }
}
