// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PositionStore on _PositionStoreBase, Store {
  late final _$positionAtom =
      Atom(name: '_PositionStoreBase.position', context: context);

  @override
  Position? get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(Position? value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$positionStateAtom =
      Atom(name: '_PositionStoreBase.positionState', context: context);

  @override
  AppState get positionState {
    _$positionStateAtom.reportRead();
    return super.positionState;
  }

  @override
  set positionState(AppState value) {
    _$positionStateAtom.reportWrite(value, super.positionState, () {
      super.positionState = value;
    });
  }

  @override
  String toString() {
    return '''
position: ${position},
positionState: ${positionState}
    ''';
  }
}
