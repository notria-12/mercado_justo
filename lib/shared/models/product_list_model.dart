import 'dart:convert';

class ProductListModel {
  int? id;
  int productId;
  int listId;
  int quantity;
  ProductListModel({
    this.id,
    required this.productId,
    required this.listId,
    required this.quantity,
  });

  ProductListModel copyWith({
    int? id,
    int? productId,
    int? listId,
    int? quantity,
  }) {
    return ProductListModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      listId: listId ?? this.listId,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'list_id': listId,
      'quantity': quantity,
    };
  }

  factory ProductListModel.fromMap(Map<String, dynamic> map) {
    return ProductListModel(
      id: map['id']?.toInt(),
      productId: map['product_id']?.toInt() ?? 0,
      listId: map['list_id']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductListModel.fromJson(String source) =>
      ProductListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductListModel(id: $id, productId: $productId, listId: $listId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductListModel &&
        other.id == id &&
        other.productId == productId &&
        other.listId == listId &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        listId.hashCode ^
        quantity.hashCode;
  }
}
