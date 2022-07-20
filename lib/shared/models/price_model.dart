import 'dart:convert';

import 'package:mercado_justo/shared/models/product_model.dart';

class Price {
  String id;
  int idMarket;
  String price;
  String updateAt;
  Product product;
  Price({
    required this.id,
    required this.idMarket,
    required this.price,
    required this.updateAt,
    required this.product,
  });

  Price copyWith({
    String? id,
    int? idMarket,
    String? price,
    String? updateAt,
    Product? product,
  }) {
    return Price(
      id: id ?? this.id,
      idMarket: idMarket ?? this.idMarket,
      price: price ?? this.price,
      updateAt: updateAt ?? this.updateAt,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idMarket': idMarket,
      'price': price,
      'updateAt': updateAt,
      'product': product.toMap(),
    };
  }

  factory Price.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      print(map);
    }
    return Price(
      id: map['_id'] ?? '',
      idMarket: map['id']?.toInt() ?? 0,
      price: map['preco'] ?? '',
      updateAt: map['atualizado_em'] ?? '',
      product: Product.fromMap(map['produto']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Price.fromJson(String source) => Price.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Price(id: $id, idMarket: $idMarket, price: $price, updateAt: $updateAt, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Price &&
        other.id == id &&
        other.idMarket == idMarket &&
        other.price == price &&
        other.updateAt == updateAt &&
        other.product == product;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idMarket.hashCode ^
        price.hashCode ^
        updateAt.hashCode ^
        product.hashCode;
  }
}
