// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfigStore on _ConfigStoreBase, Store {
  final _$separetedByCategoryAtom =
      Atom(name: '_ConfigStoreBase.separetedByCategory');

  @override
  bool get separetedByCategory {
    _$separetedByCategoryAtom.reportRead();
    return super.separetedByCategory;
  }

  @override
  set separetedByCategory(bool value) {
    _$separetedByCategoryAtom.reportWrite(value, super.separetedByCategory, () {
      super.separetedByCategory = value;
    });
  }

  final _$_ConfigStoreBaseActionController =
      ActionController(name: '_ConfigStoreBase');

  @override
  dynamic setSeparetedByCategory(bool value) {
    final _$actionInfo = _$_ConfigStoreBaseActionController.startAction(
        name: '_ConfigStoreBase.setSeparetedByCategory');
    try {
      return super.setSeparetedByCategory(value);
    } finally {
      _$_ConfigStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
separetedByCategory: ${separetedByCategory}
    ''';
  }
}
