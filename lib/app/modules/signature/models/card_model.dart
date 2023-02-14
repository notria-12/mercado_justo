class CardModel {
  String? id;
  String? firstSixDigits;
  int? expirationMonth;
  int? expirationYear;
  String? lastFourDigits;
  Cardholder? cardholder;
  String? status;
  String? dateCreated;
  String? dateLastUpdated;
  String? dateUsed;
  String? dateDue;
  bool? luhnValidation;
  bool? liveMode;
  bool? requireEsc;
  int? cardNumberLength;
  int? securityCodeLength;

  CardModel(
      {this.id,
      this.firstSixDigits,
      this.expirationMonth,
      this.expirationYear,
      this.lastFourDigits,
      this.cardholder,
      this.status,
      this.dateCreated,
      this.dateLastUpdated,
      this.dateUsed,
      this.dateDue,
      this.luhnValidation,
      this.liveMode,
      this.requireEsc,
      this.cardNumberLength,
      this.securityCodeLength});

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstSixDigits = json['first_six_digits'];
    expirationMonth = json['expiration_month'];
    expirationYear = json['expiration_year'];
    lastFourDigits = json['last_four_digits'];
    cardholder = json['cardholder'] != null
        ? new Cardholder.fromJson(json['cardholder'])
        : null;
    status = json['status'];
    dateCreated = json['date_created'];
    dateLastUpdated = json['date_last_updated'];
    dateUsed = json['date_used'];
    dateDue = json['date_due'];
    luhnValidation = json['luhn_validation'];
    liveMode = json['live_mode'];
    requireEsc = json['require_esc'];
    cardNumberLength = json['card_number_length'];
    securityCodeLength = json['security_code_length'];
  }
}

class Cardholder {
  Identification? identification;
  String? name;

  Cardholder({this.identification, this.name});

  Cardholder.fromJson(Map<String, dynamic> json) {
    identification = json['identification'] != null
        ? new Identification.fromJson(json['identification'])
        : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.identification != null) {
      data['identification'] = this.identification!.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}

class Identification {
  String? number;
  String? type;

  Identification({this.number, this.type});

  Identification.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['type'] = this.type;
    return data;
  }
}
