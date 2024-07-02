import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/constants.dart';
import 'package:pharmacy/data/models/product.dart';
import 'package:pharmacy/presintations/bloc/products_bloc.dart';
import 'package:pharmacy/presintations/bloc/products_event.dart';
import 'package:pharmacy/presintations/bloc/products_state.dart';
import 'package:pharmacy/presintations/pages/add_product_page.dart';
import 'package:pharmacy/presintations/pages/cart_page.dart';
import 'package:pharmacy/presintations/pages/kits_page.dart';
import 'package:pharmacy/presintations/widgets/build_Product.dart';
import 'package:pharmacy/presintations/widgets/drawer.dart';
import 'package:pharmacy/presintations/widgets/show_products_widget.dart';
import 'package:pharmacy/presintations/pages/medicines_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  TextEditingController searchController = TextEditingController();
  int selectedIndex = 0;

  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: kSecondaryColor),
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: kMainColor,
                context: context,
                isScrollControlled: false,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: searchController,
                        onChanged: (query) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: const Icon(
              Icons.shopping_cart_rounded,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        backgroundColor: kMainColor,
        title: const Text(
          'CureCorner',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            fontFamily: 'PlayfairDisplay-Medium',
            color: kSecondaryColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          Visibility(
            visible: selectedIndex == 0,
            child: MedicinesPage(
              searchController: searchController,
            ),
          ),
          Visibility(
            visible: selectedIndex == 1,
            child: KitsPage(
              searchController: searchController,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        color: kMainColor,
        height: 70,
        items: const [
          Icon(
            Icons.vaccines,
            size: 40,
          ),
          Icon(
            Icons.medical_services_rounded,
            size: 40,
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: kMainColor,
      //   onPressed: () async {
      //     await Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => AddProductPage()));
      //     setState(() {});
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
