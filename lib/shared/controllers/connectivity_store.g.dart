// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConnectivityStore on _ConnectivityStoreBase, Store {
  late final _$hasConnectionAtom =
      Atom(name: '_ConnectivityStoreBase.hasConnection', context: context);

  @override
  bool? get hasConnection {
    _$hasConnectionAtom.reportRead();
    return super.hasConnection;
  }

  @override
  set hasConnection(bool? value) {
    _$hasConnectionAtom.reportWrite(value, super.hasConnection, () {
      super.hasConnection = value;
    });
  }

  @override
  String toString() {
    return '''
hasConnection: ${hasConnection}
    ''';
  }
}
