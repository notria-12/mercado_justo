import 'package:dio/dio.dart';
import 'package:mercado_justo/app/modules/signature/models/card_model.dart';
import 'package:mercado_justo/app/modules/signature/models/invoice_model.dart';
import 'package:mercado_justo/app/modules/signature/models/signature_request_model.dart';
import 'package:mercado_justo/app/modules/signature/models/signature_response_model.dart';
import 'package:mercado_justo/shared/repositories/signature_repository.dart';
import 'package:mercado_justo/shared/utils/error.dart';

class CardRepository {
  final Dio _dio;

  CardRepository(this._dio);

  Future<CardModel> getCard({required String cardId}) async {
    try {
      var result = await _dio.get('/assinaturas/card/$cardId');
      return CardModel.fromJson(result.data['dados']);
    } catch (e) {
      throw Failure(
          message: 'Erro ao buscar dados do cartão', title: 'Erro Cartão');
    }
  }

  Future<InvoiceModel> getInvoice({required String paymentId}) async {
    try {
      var result = await _dio.get('/assinaturas/fatura/$paymentId');
      return InvoiceModel.fromJson(result.data['dados']);
    } catch (e) {
      throw Failure(
          message: 'Erro ao buscar dados do pagamento', title: 'Erro Cartão');
    }
  }

  Future<SignatureResponseModel> createSignature(
      SignatureRequestModel signatureRequest) async {
    try {
      var result =
          await _dio.post('/assinaturas/', data: signatureRequest.toJson());
      return SignatureResponseModel.fromJson(result.data['dados']);
    } catch (e) {
      throw Failure(
          message:
              'Não foi possível criar assinatura. Verifique os dados do cartão',
          title: 'Erro Cartão');
    }
  }
}
