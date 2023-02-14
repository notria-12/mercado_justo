class InvoiceModel {
  String? preapprovalId;
  int? id;
  String? type;
  String? status;
  DateTime? dateCreated;
  String? lastModified;
  int? transactionAmount;
  String? currencyId;
  String? reason;
  String? externalReference;
  Payment? payment;
  String? rejectionCode;
  int? retryAttempt;
  DateTime? nextRetryDate;
  DateTime? expireDate;
  DateTime? debitDate;
  String? paymentMethodId;

  InvoiceModel(
      {this.preapprovalId,
      this.id,
      this.type,
      this.status,
      this.dateCreated,
      this.lastModified,
      this.transactionAmount,
      this.currencyId,
      this.reason,
      this.externalReference,
      this.payment,
      this.rejectionCode,
      this.retryAttempt,
      this.nextRetryDate,
      this.expireDate,
      this.debitDate,
      this.paymentMethodId});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    preapprovalId = json['preapproval_id'];
    id = json['id'];
    type = json['type'];
    status = json['status'];
    dateCreated = DateTime.parse(json['date_created']);
    lastModified = json['last_modified'];
    transactionAmount = json['transaction_amount'];
    currencyId = json['currency_id'];
    reason = json['reason'];
    externalReference = json['external_reference'];
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    rejectionCode = json['rejection_code'];
    retryAttempt = json['retry_attempt'];
    nextRetryDate = DateTime.parse(json['next_retry_date']);
    expireDate = DateTime.parse(json['expire_date']);
    debitDate = DateTime.parse(json['debit_date']);
    paymentMethodId = json['payment_method_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['preapproval_id'] = this.preapprovalId;
    data['id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    data['date_created'] = this.dateCreated;
    data['last_modified'] = this.lastModified;
    data['transaction_amount'] = this.transactionAmount;
    data['currency_id'] = this.currencyId;
    data['reason'] = this.reason;
    data['external_reference'] = this.externalReference;
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    data['rejection_code'] = this.rejectionCode;
    data['retry_attempt'] = this.retryAttempt;
    data['next_retry_date'] = this.nextRetryDate;
    data['expire_date'] = this.expireDate;
    data['debit_date'] = this.debitDate;
    data['payment_method_id'] = this.paymentMethodId;
    return data;
  }
}

class Payment {
  int? id;
  String? status;
  String? statusDetail;

  Payment({this.id, this.status, this.statusDetail});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    statusDetail = json['status_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['status_detail'] = this.statusDetail;
    return data;
  }
}
