class CardModel {
  String? merchantOrderId;
  String? acquirerOrderId;
  Customer? customer;
  Payment? payment;

  CardModel(
      {this.merchantOrderId,
      this.acquirerOrderId,
      this.customer,
      this.payment});

  CardModel.fromJson(Map<String, dynamic> json) {
    merchantOrderId = json['MerchantOrderId'];
    acquirerOrderId = json['AcquirerOrderId'];
    customer = json['Customer'] != null
        ? new Customer.fromJson(json['Customer'])
        : null;
    payment =
        json['Payment'] != null ? new Payment.fromJson(json['Payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MerchantOrderId'] = this.merchantOrderId;
    data['AcquirerOrderId'] = this.acquirerOrderId;
    if (this.customer != null) {
      data['Customer'] = this.customer!.toJson();
    }
    if (this.payment != null) {
      data['Payment'] = this.payment!.toJson();
    }
    return data;
  }
}

class Customer {
  String? name;
  String? identity;
  String? email;

  Customer({
    this.name,
    this.identity,
    this.email,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    identity = json['Identity'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Identity'] = this.identity;
    data['Email'] = this.email;

    return data;
  }
}

class Payment {
  int? serviceTaxAmount;
  int? installments;
  String? interest;
  bool? capture;
  bool? authenticate;
  bool? recurrent;
  CreditCard? creditCard;
  String? proofOfSale;
  String? tid;
  String? authorizationCode;
  String? paymentId;
  String? type;
  int? amount;
  String? receivedDate;
  String? currency;
  String? country;
  String? provider;
  int? status;
  RecurrentPayment? recurrentPayment;
  List<Links>? links;

  Payment(
      {this.serviceTaxAmount,
      this.installments,
      this.interest,
      this.capture,
      this.authenticate,
      this.recurrent,
      this.creditCard,
      this.proofOfSale,
      this.tid,
      this.authorizationCode,
      this.paymentId,
      this.type,
      this.amount,
      this.receivedDate,
      this.currency,
      this.country,
      this.provider,
      this.status,
      this.recurrentPayment,
      this.links});

  Payment.fromJson(Map<String, dynamic> json) {
    serviceTaxAmount = json['ServiceTaxAmount'];
    installments = json['Installments'];
    interest = json['Interest'];
    capture = json['Capture'];
    authenticate = json['Authenticate'];
    recurrent = json['Recurrent'];
    creditCard = json['CreditCard'] != null
        ? new CreditCard.fromJson(json['CreditCard'])
        : null;
    proofOfSale = json['ProofOfSale'];
    tid = json['Tid'];
    authorizationCode = json['AuthorizationCode'];
    paymentId = json['PaymentId'];
    type = json['Type'];
    amount = json['Amount'];
    receivedDate = json['ReceivedDate'];
    currency = json['Currency'];
    country = json['Country'];
    provider = json['Provider'];
    status = json['Status'];
    recurrentPayment = json['RecurrentPayment'] != null
        ? new RecurrentPayment.fromJson(json['RecurrentPayment'])
        : null;
    if (json['Links'] != null) {
      links = <Links>[];
      json['Links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ServiceTaxAmount'] = this.serviceTaxAmount;
    data['Installments'] = this.installments;
    data['Interest'] = this.interest;
    data['Capture'] = this.capture;
    data['Authenticate'] = this.authenticate;
    data['Recurrent'] = this.recurrent;
    if (this.creditCard != null) {
      data['CreditCard'] = this.creditCard!.toJson();
    }
    data['ProofOfSale'] = this.proofOfSale;
    data['Tid'] = this.tid;
    data['AuthorizationCode'] = this.authorizationCode;
    data['PaymentId'] = this.paymentId;
    data['Type'] = this.type;
    data['Amount'] = this.amount;
    data['ReceivedDate'] = this.receivedDate;
    data['Currency'] = this.currency;
    data['Country'] = this.country;
    data['Provider'] = this.provider;
    data['Status'] = this.status;
    if (this.recurrentPayment != null) {
      data['RecurrentPayment'] = this.recurrentPayment!.toJson();
    }
    if (this.links != null) {
      data['Links'] = this.links!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreditCard {
  String? cardNumber;
  String? holder;
  String? expirationDate;
  String? brand;
  String? paymentAccountReference;

  CreditCard(
      {this.cardNumber,
      this.holder,
      this.expirationDate,
      this.brand,
      this.paymentAccountReference});

  CreditCard.fromJson(Map<String, dynamic> json) {
    cardNumber = json['CardNumber'];
    holder = json['Holder'];
    expirationDate = json['ExpirationDate'];
    brand = json['Brand'];
    paymentAccountReference = json['PaymentAccountReference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CardNumber'] = this.cardNumber;
    data['Holder'] = this.holder;
    data['ExpirationDate'] = this.expirationDate;
    data['Brand'] = this.brand;
    data['PaymentAccountReference'] = this.paymentAccountReference;
    return data;
  }
}

class RecurrentPayment {
  String? recurrentPaymentId;

  RecurrentPayment({this.recurrentPaymentId});

  RecurrentPayment.fromJson(Map<String, dynamic> json) {
    recurrentPaymentId = json['RecurrentPaymentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RecurrentPaymentId'] = this.recurrentPaymentId;
    return data;
  }
}

class Links {
  String? method;
  String? rel;
  String? href;

  Links({this.method, this.rel, this.href});

  Links.fromJson(Map<String, dynamic> json) {
    method = json['Method'];
    rel = json['Rel'];
    href = json['Href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Method'] = this.method;
    data['Rel'] = this.rel;
    data['Href'] = this.href;
    return data;
  }
}
