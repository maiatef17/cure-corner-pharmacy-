import 'package:flutter/material.dart';
import 'package:pharmacy/data/models/product.dart';

class ShowInCheckout extends StatefulWidget {
  const ShowInCheckout({super.key, required this.product});
  final Product product;

  @override
  State<ShowInCheckout> createState() => _ShowInCheckoutState();
}

class _ShowInCheckoutState extends State<ShowInCheckout> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
        ),
        Text(
          widget.product.quantity.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'PlayfairDisplay-Medium',
          ),
        ),
        SizedBox(
          width: 90,
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                widget.product.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay-Medium',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                widget.product.price.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay-Medium',
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
