
import 'package:flutter/material.dart';
import 'package:pharmacy/data/models/product.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoadingState extends ProductState {}

final class ProductLoaded extends ProductState {
  final List <Product> products;

  ProductLoaded({required this.products});
}

final class ProductErrorState extends ProductState {
  final String errorMessage;

  ProductErrorState({required this.errorMessage});
}
