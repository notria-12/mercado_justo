// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_invoice_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CardInvoiceStore on _CardInvoiceStoreBase, Store {
  late final _$cardStateAtom =
      Atom(name: '_CardInvoiceStoreBase.cardState', context: context);

  @override
  AppState get cardState {
    _$cardStateAtom.reportRead();
    return super.cardState;
  }

  @override
  set cardState(AppState value) {
    _$cardStateAtom.reportWrite(value, super.cardState, () {
      super.cardState = value;
    });
  }

  late final _$invoiceStateAtom =
      Atom(name: '_CardInvoiceStoreBase.invoiceState', context: context);

  @override
  AppState get invoiceState {
    _$invoiceStateAtom.reportRead();
    return super.invoiceState;
  }

  @override
  set invoiceState(AppState value) {
    _$invoiceStateAtom.reportWrite(value, super.invoiceState, () {
      super.invoiceState = value;
    });
  }

  late final _$signatureStateAtom =
      Atom(name: '_CardInvoiceStoreBase.signatureState', context: context);

  @override
  AppState get signatureState {
    _$signatureStateAtom.reportRead();
    return super.signatureState;
  }

  @override
  set signatureState(AppState value) {
    _$signatureStateAtom.reportWrite(value, super.signatureState, () {
      super.signatureState = value;
    });
  }

  late final _$cancelStateAtom =
      Atom(name: '_CardInvoiceStoreBase.cancelState', context: context);

  @override
  AppState get cancelState {
    _$cancelStateAtom.reportRead();
    return super.cancelState;
  }

  @override
  set cancelState(AppState value) {
    _$cancelStateAtom.reportWrite(value, super.cancelState, () {
      super.cancelState = value;
    });
  }

  late final _$cardAtom =
      Atom(name: '_CardInvoiceStoreBase.card', context: context);

  @override
  CardModel? get card {
    _$cardAtom.reportRead();
    return super.card;
  }

  @override
  set card(CardModel? value) {
    _$cardAtom.reportWrite(value, super.card, () {
      super.card = value;
    });
  }

  late final _$invoiceAtom =
      Atom(name: '_CardInvoiceStoreBase.invoice', context: context);

  @override
  InvoiceModel? get invoice {
    _$invoiceAtom.reportRead();
    return super.invoice;
  }

  @override
  set invoice(InvoiceModel? value) {
    _$invoiceAtom.reportWrite(value, super.invoice, () {
      super.invoice = value;
    });
  }

  late final _$signatureResponseModelAtom = Atom(
      name: '_CardInvoiceStoreBase.signatureResponseModel', context: context);

  @override
  SignatureResponseModel? get signatureResponseModel {
    _$signatureResponseModelAtom.reportRead();
    return super.signatureResponseModel;
  }

  @override
  set signatureResponseModel(SignatureResponseModel? value) {
    _$signatureResponseModelAtom
        .reportWrite(value, super.signatureResponseModel, () {
      super.signatureResponseModel = value;
    });
  }

  @override
  String toString() {
    return '''
cardState: ${cardState},
invoiceState: ${invoiceState},
signatureState: ${signatureState},
cancelState: ${cancelState},
card: ${card},
invoice: ${invoice},
signatureResponseModel: ${signatureResponseModel}
    ''';
  }
}
