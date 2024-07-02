import 'package:pharmacy/data/models/kit.dart';
import 'package:flutter/material.dart';

@immutable
sealed class KitEvent {}


class GetKit extends KitEvent {}

class GetCartKit extends KitEvent {}

class AddKit extends KitEvent {
  final Kit kit;

  AddKit({required this.kit});
}

class AddKitToCart extends KitEvent {
  final Kit kit;

  AddKitToCart({required this.kit});
}
class RemoveKit extends KitEvent {
  final String id;

  RemoveKit({required this.id});
}
class RemoveKitFromCart extends KitEvent {
  final String id;

  RemoveKitFromCart({required this.id});
}

class UpdateKit extends KitEvent {
  final Kit kit;

  UpdateKit({required this.kit});
}
