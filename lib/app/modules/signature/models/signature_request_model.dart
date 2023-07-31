import 'dart:convert';

class SignatureRequestModel {
  String email;
  String userId;
  CardSignatureModel card;
  SignatureRequestModel({
    required this.email,
    required this.userId,
    required this.card,
  });

  SignatureRequestModel copyWith({
    String? email,
    String? userId,
    CardSignatureModel? card,
  }) {
    return SignatureRequestModel(
      email: email ?? this.email,
      userId: userId ?? this.userId,
      card: card ?? this.card,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'id_usuario': userId,
      'card': card.toMap(),
    };
  }

  factory SignatureRequestModel.fromMap(Map<String, dynamic> map) {
    return SignatureRequestModel(
      email: map['email'] as String,
      userId: map['userId'] as String,
      card: CardSignatureModel.fromMap(map['card'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SignatureRequestModel.fromJson(String source) =>
      SignatureRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SignatureRequestModel(email: $email, userId: $userId, card: $card)';

  @override
  bool operator ==(covariant SignatureRequestModel other) {
    if (identical(this, other)) return true;

    return other.email == email && other.userId == userId && other.card == card;
  }

  @override
  int get hashCode => email.hashCode ^ userId.hashCode ^ card.hashCode;
}

class CardSignatureModel {
  String holderName;
  String cardNumber;

  String expirationMonth;
  String expirationYear;
  String cvv;
  String userId;
  CardSignatureModel(
      {required this.holderName,
      required this.cardNumber,
      required this.expirationMonth,
      required this.expirationYear,
      required this.cvv,
      required this.userId});

  CardSignatureModel copyWith(
      {String? holderName,
      String? cardNumber,
      String? expirationMonth,
      String? expirationYear,
      String? cvv,
      String? userId}) {
    return CardSignatureModel(
        holderName: holderName ?? this.holderName,
        cardNumber: cardNumber ?? this.cardNumber,
        expirationMonth: expirationMonth ?? this.expirationMonth,
        expirationYear: expirationYear ?? this.expirationYear,
        cvv: cvv ?? this.cvv,
        userId: userId ?? this.userId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'holder_name': holderName,
      'card_number': cardNumber,
      'expiration_month': expirationMonth,
      'expiration_year': expirationYear,
      'security_code': cvv,
      'user_id': userId
    };
  }

  factory CardSignatureModel.fromMap(Map<String, dynamic> map) {
    return CardSignatureModel(
        holderName: map['holderName'] as String,
        cardNumber: map['cardNumber'] as String,
        expirationMonth: map['expirationMonth'] as String,
        expirationYear: map['expirationYear'] as String,
        cvv: map['cvv'] as String,
        userId: map['user_id'] as String);
  }

  String toJson() => json.encode(toMap());

  factory CardSignatureModel.fromJson(String source) =>
      CardSignatureModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CardSignatureModel(holderName: $holderName, cardNumber: $cardNumber,  expirationMonth: $expirationMonth, expirationYear: $expirationYear, cvv: $cvv)';
  }

  @override
  bool operator ==(covariant CardSignatureModel other) {
    if (identical(this, other)) return true;

    return other.holderName == holderName &&
        other.cardNumber == cardNumber &&
        other.expirationMonth == expirationMonth &&
        other.expirationYear == expirationYear &&
        other.cvv == cvv;
  }

  @override
  int get hashCode {
    return holderName.hashCode ^
        cardNumber.hashCode ^
        expirationMonth.hashCode ^
        expirationYear.hashCode ^
        cvv.hashCode;
  }
}
