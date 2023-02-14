import 'package:mercado_justo/app/modules/signature/models/card_model.dart';
import 'package:mercado_justo/app/modules/signature/models/invoice_model.dart';
import 'package:mercado_justo/app/modules/signature/models/signature_request_model.dart';
import 'package:mercado_justo/app/modules/signature/repositories/card_repository.dart';
import 'package:mercado_justo/shared/utils/app_state.dart';
import 'package:mercado_justo/shared/utils/error.dart';
import 'package:mobx/mobx.dart';

import '../models/signature_response_model.dart';

part 'card_invoice_controller.g.dart';

class CardInvoiceStore = _CardInvoiceStoreBase with _$CardInvoiceStore;

abstract class _CardInvoiceStoreBase with Store {
  final CardRepository _repository;
  _CardInvoiceStoreBase(this._repository);

  @observable
  AppState cardState = AppStateEmpty();
  @observable
  AppState invoiceState = AppStateEmpty();
  @observable
  AppState signatureState = AppStateEmpty();
  @observable
  CardModel? card;
  @observable
  InvoiceModel? invoice;
  @observable
  SignatureResponseModel? signatureResponseModel;

  Future getInvoice({required String id}) async {
    try {
      invoiceState = AppStateLoading();
      invoice = await _repository.getInvoice(paymentId: id);
      invoiceState = AppStateSuccess();
    } on Failure catch (e) {
      invoiceState = AppStateError(error: e);
    }
  }

  Future getCard({required String id}) async {
    try {
      cardState = AppStateLoading();
      card = await _repository.getCard(cardId: id);
      cardState = AppStateSuccess();
    } on Failure catch (e) {
      cardState = AppStateError(error: e);
    }
  }

  Future createSignature(SignatureRequestModel signatureRequestModel) async {
    try {
      signatureState = AppStateLoading();
      signatureResponseModel =
          await _repository.createSignature(signatureRequestModel);
      signatureState = AppStateSuccess();
    } on Failure catch (e) {
      signatureState = AppStateError(error: e);
    }
  }
}
