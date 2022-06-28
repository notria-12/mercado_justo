import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  String? imagePath;
  String description;
  String? ref;
  int? order;
  List<String> barCode;
  String id;
  String? category;
  String? category2;
  String? category3;
  int? productId;

  Product(
      {this.imagePath,
      required this.description,
      this.ref,
      this.order,
      required this.barCode,
      required this.id,
      this.category,
      this.category2,
      this.category3,
      this.productId});

  Product copyWith(
      {String? imagePath,
      String? description,
      String? ref,
      int? order,
      List<String>? barCode,
      String? id,
      String? category,
      String? category2,
      String? category3,
      int? productId}) {
    return Product(
        imagePath: imagePath ?? this.imagePath,
        description: description ?? this.description,
        ref: ref ?? this.ref,
        order: order ?? this.order,
        barCode: barCode ?? this.barCode,
        id: id ?? this.id,
        category: category ?? this.category,
        category2: category2 ?? this.category2,
        category3: category3 ?? this.category3,
        productId: productId ?? this.productId);
  }

  Map<String, dynamic> toMap() {
    return {
      'image': imagePath,
      'descricao': description,
      'ordem': order,
      // 'codigo_barras': barCode.first,
      '_id': id,
      'categoria_1': category,
      'categoria_2': category2,
      'categoria_3': category3,
      'id': productId
    };
  }

  Map<String, dynamic> toMapSQL() {
    return {
      'image_path': imagePath,
      'description': description,
      'product_order': order,
      'bar_code': barCode.first,
      'hash_id': id,
      'category': category,
      'category_2': category2,
      'category_3': category3,
      'id': productId
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        imagePath: map['image'] ?? '',
        description: map['descricao'] ?? '',
        ref: map['referencia'] ?? '',
        order: map['ordem']?.toInt(),
        barCode: map['codigo_barras'] != null
            ? List<String>.from(map['codigo_barras'])
            : [],
        id: map['_id'] ?? '',
        category: map['categoria_1'],
        category2: map['categoria_2'],
        category3: map['categoria_3'],
        productId: map['id']);
  }

  factory Product.fromMapSQL(Map<String, dynamic> map) {
    return Product(
        imagePath: map['image_path'] ?? '',
        description: map['description'] ?? '',
        order: map['product_order']?.toInt(),
        barCode: [map['bar_code']],
        id: map['hash_id'] ?? '',
        category: map['category'],
        category2: map['category_2'],
        category3: map['category_3'] ?? '',
        productId: map['id'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(imagePath: $imagePath, description: $description, ref: $ref, order: $order, barCode: $barCode, id: $id, category: $category, category2: $category2, category3: $category3)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.imagePath == imagePath &&
        other.description == description &&
        other.ref == ref &&
        other.order == order &&
        listEquals(other.barCode, barCode) &&
        other.id == id &&
        other.category == category &&
        other.category2 == category2 &&
        other.category3 == category3;
  }

  @override
  int get hashCode {
    return imagePath.hashCode ^
        description.hashCode ^
        ref.hashCode ^
        order.hashCode ^
        barCode.hashCode ^
        id.hashCode ^
        category.hashCode ^
        category2.hashCode ^
        category3.hashCode;
  }
}
