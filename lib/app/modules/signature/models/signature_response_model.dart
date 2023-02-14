class SignatureResponseModel {
  String? id;
  int? payerId;
  String? payerEmail;
  String? backUrl;
  int? collectorId;
  int? applicationId;
  String? status;
  String? reason;
  String? externalReference;
  String? dateCreated;
  String? lastModified;
  String? initPoint;
  AutoRecurring? autoRecurring;
  Summarized? summarized;
  String? paymentMethodId;
  String? cardId;
  Null? firstInvoiceOffset;

  SignatureResponseModel(
      {this.id,
      this.payerId,
      this.payerEmail,
      this.backUrl,
      this.collectorId,
      this.applicationId,
      this.status,
      this.reason,
      this.externalReference,
      this.dateCreated,
      this.lastModified,
      this.initPoint,
      this.autoRecurring,
      this.summarized,
      this.paymentMethodId,
      this.cardId,
      this.firstInvoiceOffset});

  SignatureResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    payerId = json['payer_id'];
    payerEmail = json['payer_email'];
    backUrl = json['back_url'];
    collectorId = json['collector_id'];
    applicationId = json['application_id'];
    status = json['status'];
    reason = json['reason'];
    externalReference = json['external_reference'];
    dateCreated = json['date_created'];
    lastModified = json['last_modified'];
    initPoint = json['init_point'];
    autoRecurring = json['auto_recurring'] != null
        ? new AutoRecurring.fromJson(json['auto_recurring'])
        : null;
    summarized = json['summarized'] != null
        ? new Summarized.fromJson(json['summarized'])
        : null;
    paymentMethodId = json['payment_method_id'];
    cardId = json['card_id'];
    firstInvoiceOffset = json['first_invoice_offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payer_id'] = this.payerId;
    data['payer_email'] = this.payerEmail;
    data['back_url'] = this.backUrl;
    data['collector_id'] = this.collectorId;
    data['application_id'] = this.applicationId;
    data['status'] = this.status;
    data['reason'] = this.reason;
    data['external_reference'] = this.externalReference;
    data['date_created'] = this.dateCreated;
    data['last_modified'] = this.lastModified;
    data['init_point'] = this.initPoint;
    if (this.autoRecurring != null) {
      data['auto_recurring'] = this.autoRecurring!.toJson();
    }
    if (this.summarized != null) {
      data['summarized'] = this.summarized!.toJson();
    }
    data['payment_method_id'] = this.paymentMethodId;
    data['card_id'] = this.cardId;
    data['first_invoice_offset'] = this.firstInvoiceOffset;
    return data;
  }
}

class AutoRecurring {
  int? frequency;
  String? frequencyType;
  int? transactionAmount;
  String? currencyId;
  Null? freeTrial;

  AutoRecurring(
      {this.frequency,
      this.frequencyType,
      this.transactionAmount,
      this.currencyId,
      this.freeTrial});

  AutoRecurring.fromJson(Map<String, dynamic> json) {
    frequency = json['frequency'];
    frequencyType = json['frequency_type'];
    transactionAmount = json['transaction_amount'];
    currencyId = json['currency_id'];
    freeTrial = json['free_trial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['frequency'] = this.frequency;
    data['frequency_type'] = this.frequencyType;
    data['transaction_amount'] = this.transactionAmount;
    data['currency_id'] = this.currencyId;
    data['free_trial'] = this.freeTrial;
    return data;
  }
}

class Summarized {
  Null? quotas;
  Null? chargedQuantity;
  Null? pendingChargeQuantity;
  Null? chargedAmount;
  Null? pendingChargeAmount;
  Null? semaphore;
  Null? lastChargedDate;
  Null? lastChargedAmount;

  Summarized(
      {this.quotas,
      this.chargedQuantity,
      this.pendingChargeQuantity,
      this.chargedAmount,
      this.pendingChargeAmount,
      this.semaphore,
      this.lastChargedDate,
      this.lastChargedAmount});

  Summarized.fromJson(Map<String, dynamic> json) {
    quotas = json['quotas'];
    chargedQuantity = json['charged_quantity'];
    pendingChargeQuantity = json['pending_charge_quantity'];
    chargedAmount = json['charged_amount'];
    pendingChargeAmount = json['pending_charge_amount'];
    semaphore = json['semaphore'];
    lastChargedDate = json['last_charged_date'];
    lastChargedAmount = json['last_charged_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quotas'] = this.quotas;
    data['charged_quantity'] = this.chargedQuantity;
    data['pending_charge_quantity'] = this.pendingChargeQuantity;
    data['charged_amount'] = this.chargedAmount;
    data['pending_charge_amount'] = this.pendingChargeAmount;
    data['semaphore'] = this.semaphore;
    data['last_charged_date'] = this.lastChargedDate;
    data['last_charged_amount'] = this.lastChargedAmount;
    return data;
  }
}
