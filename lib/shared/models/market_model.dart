import 'dart:convert';

import 'package:flutter/foundation.dart';

class Market {
  String name;
  String imagePath;
  String siteAddress;
  List<String> addresses;
  Market({
    required this.name,
    required this.imagePath,
    required this.siteAddress,
    required this.addresses,
  });

  Market copyWith({
    String? name,
    String? imagePath,
    String? siteAddress,
    List<String>? addresses,
  }) {
    return Market(
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      siteAddress: siteAddress ?? this.siteAddress,
      addresses: addresses ?? this.addresses,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imagePath': imagePath,
      'siteAddress': siteAddress,
      'addresses': addresses,
    };
  }

  factory Market.fromMap(Map<String, dynamic> map) {
    return Market(
      name: map['name'] ?? '',
      imagePath: map['imagePath'] ?? '',
      siteAddress: map['siteAddress'] ?? '',
      addresses: List<String>.from(map['addresses']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Market.fromJson(String source) => Market.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Market(name: $name, imagePath: $imagePath, siteAddress: $siteAddress, addresses: $addresses)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Market &&
        other.name == name &&
        other.imagePath == imagePath &&
        other.siteAddress == siteAddress &&
        listEquals(other.addresses, addresses);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        imagePath.hashCode ^
        siteAddress.hashCode ^
        addresses.hashCode;
  }
}
