// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PositionStore on _PositionStoreBase, Store {
  final _$positionAtom = Atom(name: '_PositionStoreBase.position');

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

  @override
  String toString() {
    return '''
position: ${position}
    ''';
  }
}
