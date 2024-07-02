import 'package:flutter/material.dart';
import 'package:pharmacy/data/models/product.dart';
import 'package:pharmacy/presintations/widgets/show_products_widget.dart';

class BuildProductWidget extends StatelessWidget {
  final List<Product> products;
  final TextEditingController searchController;

  const BuildProductWidget({
    Key? key,
    required this.products,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .where((product) => product.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();

    if (filteredProducts.isEmpty && searchController.text.isNotEmpty) {
      return Center(
        child: Text('No products found for "${searchController.text}"'),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredProducts.length,
      itemBuilder: (context, i) => ShowProducts(product: filteredProducts[i]),
    );
  }
}
