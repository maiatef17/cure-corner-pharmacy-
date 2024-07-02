import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String image, name, id;
  num quantity, price;

  Product({
    required this.image,
    required this.name,
    required this.price,
    required this.id,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      "image": image,
      "name": name,
      "price": price,
      "id": id,
      "quantity": quantity
    };
  }

  factory Product.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Product(
        id: doc.id,
        image: doc.data()['image'],
        name: doc.data()['name']!,
        price: doc.data()['price'],
        quantity: doc.data()['quantity']);
  }
}
