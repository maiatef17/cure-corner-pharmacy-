import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Kit {
  final String image, name, id;
  num quantity, price;

  Kit({
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

  factory Kit.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Kit(
        id: doc.id,
        image: doc.data()['image'],
        name: doc.data()['name']!,
        price: doc.data()['price'],
        quantity: doc.data()['quantity']);
  }
}
