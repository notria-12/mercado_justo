import 'dart:convert';

import 'package:flutter/foundation.dart';

class Market {
  int id;
  String hashId;
  int? order;
  bool isSelectable;
  bool isVisible;
  double latitude;
  double longitude;
  String cnpj;
  String phoneNumber;
  String name;
  String? imagePath;
  String siteAddress;
  String address;
  Market(
      {required this.id,
      required this.hashId,
      this.order,
      required this.isVisible,
      required this.latitude,
      required this.longitude,
      required this.cnpj,
      required this.phoneNumber,
      required this.name,
      this.imagePath,
      required this.siteAddress,
      required this.address,
      this.isSelectable = true});

  Market copyWith(
      {int? id,
      String? hashId,
      int? order,
      bool? isVisible,
      double? latitude,
      double? longitude,
      String? cnpj,
      String? phoneNumber,
      String? name,
      String? imagePath,
      String? siteAddress,
      String? address,
      bool? isSelectable}) {
    return Market(
        id: id ?? this.id,
        hashId: hashId ?? this.hashId,
        order: order ?? this.order,
        isVisible: isVisible ?? this.isVisible,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        cnpj: cnpj ?? this.cnpj,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        name: name ?? this.name,
        imagePath: imagePath ?? this.imagePath,
        siteAddress: siteAddress ?? this.siteAddress,
        address: address ?? this.address,
        isSelectable: isSelectable ?? this.isSelectable);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hashId': hashId,
      'order': order,
      'isVisible': isVisible,
      'latitude': latitude,
      'longitude': longitude,
      'cnpj': cnpj,
      'phoneNumber': phoneNumber,
      'name': name,
      'imagePath': imagePath,
      'siteAddress': siteAddress,
      'address': address,
    };
  }

  factory Market.fromMap(Map<String, dynamic> map) {
    return Market(
      id: map['id']?.toInt() ?? 0,
      hashId: map['_id'] ?? '',
      order: map['ordem']?.toInt(),
      isVisible: map['visivel'] ?? true,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      cnpj: map['cnpj'] ?? '',
      phoneNumber: map['telefone'] ?? '',
      name: map['nome'] ?? '',
      imagePath: map['imagePath'] ?? '',
      siteAddress: map['site'] ?? '',
      address: map['endereco'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Market.fromJson(String source) => Market.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Market(id: $id, hashId: $hashId, order: $order, isVisible: $isVisible, latitude: $latitude, longitude: $longitude, cnpj: $cnpj, phoneNumber: $phoneNumber, name: $name, imagePath: $imagePath, siteAddress: $siteAddress, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Market &&
        other.id == id &&
        other.hashId == hashId &&
        other.order == order &&
        other.isVisible == isVisible &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.cnpj == cnpj &&
        other.phoneNumber == phoneNumber &&
        other.name == name &&
        other.imagePath == imagePath &&
        other.siteAddress == siteAddress &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        hashId.hashCode ^
        order.hashCode ^
        isVisible.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        cnpj.hashCode ^
        phoneNumber.hashCode ^
        name.hashCode ^
        imagePath.hashCode ^
        siteAddress.hashCode ^
        address.hashCode;
  }
}
