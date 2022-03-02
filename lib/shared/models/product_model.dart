import 'dart:convert';

class Product {
  String imagePath;
  String name;
  String ref;
  Product({
    required this.imagePath,
    required this.name,
    required this.ref,
  });

  Product copyWith({
    String? imagePath,
    String? name,
    String? ref,
  }) {
    return Product(
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      ref: ref ?? this.ref,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'name': name,
      'ref': ref,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      imagePath: map['imagePath'] ?? '',
      name: map['name'] ?? '',
      ref: map['ref'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() => 'Product(imagePath: $imagePath, name: $name, ref: $ref)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.imagePath == imagePath &&
        other.name == name &&
        other.ref == ref;
  }

  @override
  int get hashCode => imagePath.hashCode ^ name.hashCode ^ ref.hashCode;
}
