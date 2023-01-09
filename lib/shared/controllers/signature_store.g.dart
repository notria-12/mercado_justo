// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignatureStore on _SignatureStoreBase, Store {
  final _$signatureAtom = Atom(name: '_SignatureStoreBase.signature');

  @override
  SignatureModel? get signature {
    _$signatureAtom.reportRead();
    return super.signature;
  }

  @override
  set signature(SignatureModel? value) {
    _$signatureAtom.reportWrite(value, super.signature, () {
      super.signature = value;
    });
  }

  final _$paymentByPixAtom = Atom(name: '_SignatureStoreBase.paymentByPix');

  @override
  bool get paymentByPix {
    _$paymentByPixAtom.reportRead();
    return super.paymentByPix;
  }

  @override
  set paymentByPix(bool value) {
    _$paymentByPixAtom.reportWrite(value, super.paymentByPix, () {
      super.paymentByPix = value;
    });
  }

  final _$paymentByCreditCardAtom =
      Atom(name: '_SignatureStoreBase.paymentByCreditCard');

  @override
  bool get paymentByCreditCard {
    _$paymentByCreditCardAtom.reportRead();
    return super.paymentByCreditCard;
  }

  @override
  set paymentByCreditCard(bool value) {
    _$paymentByCreditCardAtom.reportWrite(value, super.paymentByCreditCard, () {
      super.paymentByCreditCard = value;
    });
  }

  final _$_SignatureStoreBaseActionController =
      ActionController(name: '_SignatureStoreBase');

  @override
  dynamic setPaymentByCreditCard(bool value) {
    final _$actionInfo = _$_SignatureStoreBaseActionController.startAction(
        name: '_SignatureStoreBase.setPaymentByCreditCard');
    try {
      return super.setPaymentByCreditCard(value);
    } finally {
      _$_SignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPaymentByPix(bool value) {
    final _$actionInfo = _$_SignatureStoreBaseActionController.startAction(
        name: '_SignatureStoreBase.setPaymentByPix');
    try {
      return super.setPaymentByPix(value);
    } finally {
      _$_SignatureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
signature: ${signature},
paymentByPix: ${paymentByPix},
paymentByCreditCard: ${paymentByCreditCard}
    ''';
  }
}
