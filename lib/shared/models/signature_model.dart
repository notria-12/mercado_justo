class SignatureModel {
  bool status;
  bool pendingPayment;
  String paymentId;
  String id;
  String? cardToken;
  String? signatureId;
  String paymentType;
  DateTime expirationDate;

  SignatureModel(
      {required this.status,
      required this.pendingPayment,
      required this.paymentId,
      required this.id,
      required this.paymentType,
      this.cardToken,
      this.signatureId,
      required this.expirationDate});

  factory SignatureModel.fromMap(Map<String, dynamic> map) {
    return SignatureModel(
        status: map['status'],
        pendingPayment: map['pagamento_pendente'],
        paymentId: map['id_pagamento'],
        id: map['_id'],
        paymentType: map['tipo_pagamento'],
        cardToken: map['card_token'],
        signatureId: map['id_assinatura'],
        expirationDate: DateTime.parse(map['data_expiracao']));
  }
}
