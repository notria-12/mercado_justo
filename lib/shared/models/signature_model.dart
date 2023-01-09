class SignatureModel {
  bool status;
  bool pendingPayment;
  String paymentId;
  String id;

  SignatureModel(
      {required this.status,
      required this.pendingPayment,
      required this.paymentId,
      required this.id});

  factory SignatureModel.fromMap(Map<String, dynamic> map) {
    return SignatureModel(
        status: map['status'],
        pendingPayment: map['pagamento_pendente'],
        paymentId: map['id_pagamento'],
        id: map['_id']);
  }
}
