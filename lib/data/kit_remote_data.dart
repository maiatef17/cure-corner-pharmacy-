import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pharmacy/data/models/kit.dart';
import 'package:pharmacy/data/models/product.dart';

abstract class KitRemoteDs {
  Future<void> addKit(Kit kit);
  Future<List<Kit>> getKit();
  Future<void> addToCart(Kit kit);
  Future<List<Kit>> getCartKit();
  Future<void> removeKit(String id);
  Future<void> removeKitFromCart(String id);
  Future<void> updateKit(Kit kit);
}

class KitRemoteDsImp extends KitRemoteDs {
  @override
  Future<void> addKit(Kit kit) async {
    await FirebaseFirestore.instance.collection("kits").add(kit.toMap());
  }

  @override
  Future<List<Kit>> getKit() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("kits").get();
      return snapshot.docs.map((d) => Kit.fromDoc(d)).toList();
    } catch (e) {
      print("Error getting Kit: $e");
      return [];
    }
  }
  @override
  Future<void> removeKit(String id) async {
    try {
      await FirebaseFirestore.instance.collection("kits").doc(id).delete();
    } catch (e) {
      print("Error removing Kit: $e");
    }
  }

  @override
  Future<void> updateKit(Kit kit) async {
    try {
      await FirebaseFirestore.instance
          .collection("kits")
          .doc(kit.id)
          .update(kit.toMap());
    } catch (e) {
      print("Error updating Kit: $e");
    }
  }

  @override
  Future<void> addToCart(Kit kit) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection("users-cart-items")
            .doc(currentUser.email)
            .collection("items")
            .add(kit.toMap());
        print("Added to cart");
      } else {
        print("User not signed in.");
      }
    } catch (e) {
      print("Error adding to cart: $e");
    }
  }

  @override
  Future<List<Kit>> getCartKit() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection("users-cart-items")
            .doc(currentUser.email)
            .collection("items")
            .get();

        final Set<String> productIds = Set<String>();
        final List<Kit> cartKits = [];

        snapshot.docs.forEach((doc) {
          final kit = Kit.fromDoc(doc);
          if (!productIds.contains(kit.name)) {
            productIds.add(kit.name);
            cartKits.add(kit);
          }
        });

        return cartKits;
      } else {
        print("User not signed in.");
        return [];
      }
    } catch (e) {
      print("Error getting cart Kits: $e");
      return [];
    }
  }

  @override
  Future<void> removeKitFromCart(String id) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection("users-cart-items")
            .doc(currentUser.email)
            .collection("items")
            .doc(id)
            .delete();
        print("Kit removed from cart");
      } else {
        print("User not signed in.");
      }
    } catch (e) {
      print("Error removing from cart: $e");
    }
  } 
  }

