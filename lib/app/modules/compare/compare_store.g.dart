// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compare_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CompareStore on _CompareStoreBase, Store {
  Computed<List<List<Map<String, dynamic>>>>? _$getFairPriceComputed;

  @override
  List<List<Map<String, dynamic>>> get getFairPrice =>
      (_$getFairPriceComputed ??= Computed<List<List<Map<String, dynamic>>>>(
              () => super.getFairPrice,
              name: '_CompareStoreBase.getFairPrice'))
          .value;

  final _$newQuantityAtom = Atom(name: '_CompareStoreBase.newQuantity');

  @override
  int? get newQuantity {
    _$newQuantityAtom.reportRead();
    return super.newQuantity;
  }

  @override
  set newQuantity(int? value) {
    _$newQuantityAtom.reportWrite(value, super.newQuantity, () {
      super.newQuantity = value;
    });
  }

  final _$pricesAtom = Atom(name: '_CompareStoreBase.prices');

  @override
  List<List<Map<String, dynamic>>> get prices {
    _$pricesAtom.reportRead();
    return super.prices;
  }

  @override
  set prices(List<List<Map<String, dynamic>>> value) {
    _$pricesAtom.reportWrite(value, super.prices, () {
      super.prices = value;
    });
  }

  final _$listIdAtom = Atom(name: '_CompareStoreBase.listId');

  @override
  int? get listId {
    _$listIdAtom.reportRead();
    return super.listId;
  }

  @override
  set listId(int? value) {
    _$listIdAtom.reportWrite(value, super.listId, () {
      super.listId = value;
    });
  }

  final _$totalAtom = Atom(name: '_CompareStoreBase.total');

  @override
  double get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(double value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  final _$listTotalAtom = Atom(name: '_CompareStoreBase.listTotal');

  @override
  List<Map<String, dynamic>> get listTotal {
    _$listTotalAtom.reportRead();
    return super.listTotal;
  }

  @override
  set listTotal(List<Map<String, dynamic>> value) {
    _$listTotalAtom.reportWrite(value, super.listTotal, () {
      super.listTotal = value;
    });
  }

  final _$_CompareStoreBaseActionController =
      ActionController(name: '_CompareStoreBase');

  @override
  dynamic setTotal(double value) {
    final _$actionInfo = _$_CompareStoreBaseActionController.startAction(
        name: '_CompareStoreBase.setTotal');
    try {
      return super.setTotal(value);
    } finally {
      _$_CompareStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setListTotal(Map<String, dynamic> value) {
    final _$actionInfo = _$_CompareStoreBaseActionController.startAction(
        name: '_CompareStoreBase.setListTotal');
    try {
      return super.setListTotal(value);
    } finally {
      _$_CompareStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newQuantity: ${newQuantity},
prices: ${prices},
listId: ${listId},
total: ${total},
listTotal: ${listTotal},
getFairPrice: ${getFairPrice}
    ''';
  }
}
