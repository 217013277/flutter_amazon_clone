import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final String description;
  final int quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  // final String? userId;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    // this.userId
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "quantity": quantity,
      "images": images,
      "category": category,
      "price": price,
      // "userId": userId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map["_id"] ?? "",
      // userId: map["userId"] ?? "",
      name: map["name"] ?? "",
      description: map["description"] ?? "",
      quantity: map["quantity"].toInt() ?? 0,
      images: List<String>.from(map["images"]),
      category: map["category"] ?? "",
      price: map["price"].toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
