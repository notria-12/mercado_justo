class InvoiceModel {
  Customer? customer;
  RecurrentPayment? recurrentPayment;

  InvoiceModel({this.customer, this.recurrentPayment});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    customer = json['Customer'] != null
        ? new Customer.fromJson(json['Customer'])
        : null;
    recurrentPayment = json['RecurrentPayment'] != null
        ? new RecurrentPayment.fromJson(json['RecurrentPayment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['Customer'] = this.customer!.toJson();
    }
    if (this.recurrentPayment != null) {
      data['RecurrentPayment'] = this.recurrentPayment!.toJson();
    }
    return data;
  }
}

class Customer {
  String? name;
  String? identity;
  String? identityType;
  String? email;

  Customer({this.name, this.identity, this.identityType, this.email});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    identity = json['Identity'];
    identityType = json['IdentityType'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Identity'] = this.identity;
    data['IdentityType'] = this.identityType;
    data['Email'] = this.email;
    return data;
  }
}

class RecurrentPayment {
  String? recurrentPaymentId;
  String? nextRecurrency;
  String? startDate;
  String? interval;
  int? amount;
  String? country;
  String? createDate;
  String? currency;
  int? currentRecurrencyTry;
  String? orderNumber;
  String? provider;
  int? recurrencyDay;
  int? successfulRecurrences;
  List<Links>? links;
  List<RecurrentTransactions>? recurrentTransactions;
  int? status;

  RecurrentPayment(
      {this.recurrentPaymentId,
      this.nextRecurrency,
      this.startDate,
      this.interval,
      this.amount,
      this.country,
      this.createDate,
      this.currency,
      this.currentRecurrencyTry,
      this.orderNumber,
      this.provider,
      this.recurrencyDay,
      this.successfulRecurrences,
      this.links,
      this.recurrentTransactions,
      this.status});

  RecurrentPayment.fromJson(Map<String, dynamic> json) {
    recurrentPaymentId = json['RecurrentPaymentId'];
    nextRecurrency = json['NextRecurrency'];
    startDate = json['StartDate'];
    interval = json['Interval'];
    amount = json['Amount'];
    country = json['Country'];
    createDate = json['CreateDate'];
    currency = json['Currency'];
    currentRecurrencyTry = json['CurrentRecurrencyTry'];
    orderNumber = json['OrderNumber'];
    provider = json['Provider'];
    recurrencyDay = json['RecurrencyDay'];
    successfulRecurrences = json['SuccessfulRecurrences'];
    if (json['Links'] != null) {
      links = <Links>[];
      json['Links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    if (json['RecurrentTransactions'] != null) {
      recurrentTransactions = <RecurrentTransactions>[];
      json['RecurrentTransactions'].forEach((v) {
        recurrentTransactions!.add(new RecurrentTransactions.fromJson(v));
      });
    }
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RecurrentPaymentId'] = this.recurrentPaymentId;
    data['NextRecurrency'] = this.nextRecurrency;
    data['StartDate'] = this.startDate;
    data['Interval'] = this.interval;
    data['Amount'] = this.amount;
    data['Country'] = this.country;
    data['CreateDate'] = this.createDate;
    data['Currency'] = this.currency;
    data['CurrentRecurrencyTry'] = this.currentRecurrencyTry;
    data['OrderNumber'] = this.orderNumber;
    data['Provider'] = this.provider;
    data['RecurrencyDay'] = this.recurrencyDay;
    data['SuccessfulRecurrences'] = this.successfulRecurrences;
    if (this.links != null) {
      data['Links'] = this.links!.map((v) => v.toJson()).toList();
    }
    if (this.recurrentTransactions != null) {
      data['RecurrentTransactions'] =
          this.recurrentTransactions!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
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

class RecurrentTransactions {
  String? paymentId;
  int? paymentNumber;
  int? tryNumber;

  RecurrentTransactions({this.paymentId, this.paymentNumber, this.tryNumber});

  RecurrentTransactions.fromJson(Map<String, dynamic> json) {
    paymentId = json['PaymentId'];
    paymentNumber = json['PaymentNumber'];
    tryNumber = json['TryNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PaymentId'] = this.paymentId;
    data['PaymentNumber'] = this.paymentNumber;
    data['TryNumber'] = this.tryNumber;
    return data;
  }
}
