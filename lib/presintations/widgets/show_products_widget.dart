import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/constants.dart';
import 'package:pharmacy/data/models/product.dart';
import 'package:pharmacy/data/products_remote_data_source.dart';
import 'package:pharmacy/presintations/bloc/products_bloc.dart';
import 'package:pharmacy/presintations/bloc/products_event.dart';
import 'package:pharmacy/presintations/bloc/products_state.dart';
import 'package:pharmacy/presintations/pages/info_page.dart';

class ShowProducts extends StatefulWidget {
  const ShowProducts({super.key, required this.product});
  final Product product;
  @override
  State<ShowProducts> createState() => _ShowProductsState();
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
  );
}

class _ShowProductsState extends State<ShowProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InfoPageM(product: widget.product)));
            setState(() {});
          },
          child: Container(
              color: Colors.grey[100],
              margin: const EdgeInsets.all(5),
              width: 180,
              height: 170,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: GridTile(
                  footer: Container(
                    height: 70,
                    color: Colors.white.withOpacity(0.7),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: kSecondaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.product.price.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: kSecondaryColor,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text("EGP",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kSecondaryColor,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              width: 70,
                            ),
                            GestureDetector(
                              onTap: () {
                                ProductRemoteDsImp().addToCart(widget.product);
                                showToast('Product added to cart');
                              },
                              child: Icon(Icons.add_shopping_cart_outlined),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  child: Image.network(
                    widget.product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
        );
      },
    );
  }
}
