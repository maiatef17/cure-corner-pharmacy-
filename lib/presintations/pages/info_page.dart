import 'package:flutter/material.dart';
import 'package:pharmacy/constants.dart';
import 'package:pharmacy/data/kit_remote_data.dart';
import 'package:pharmacy/data/models/kit.dart';
import 'package:pharmacy/data/models/product.dart';
import 'package:pharmacy/data/products_remote_data_source.dart';
import 'package:pharmacy/presintations/pages/check_out_page.dart';

class InfoPageM extends StatefulWidget {
  const InfoPageM({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  State<InfoPageM> createState() => _InfoPageMState();
}

class _InfoPageMState extends State<InfoPageM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text(
          '${widget.product.name} ',
          style: TextStyle(
              color: kSecondaryColor, fontFamily: 'PlayfairDisplay-Medium'),
        ),
      ),
      body: GridTile(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(30)),
                child: Image.network(widget.product.image,
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${widget.product.name}',
                    style: const TextStyle(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'PlayfairDisplay-Medium'),
                  ),
                  Text(
                    'Price: ${widget.product.price} EGP',
                    style: const TextStyle(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'PlayfairDisplay-Medium'),
                  ),
                  SizedBox(
                    height: 230,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ProductRemoteDsImp().addToCart(widget.product);
                      showToast('Product added to cart');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(500, 50),
                      backgroundColor: kMainColor,
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontFamily: 'PlayfairDisplay-Medium',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoPageK extends StatefulWidget {
  const InfoPageK({super.key, required this.kit});
  final Kit kit;

  @override
  State<InfoPageK> createState() => _InfoPageKState();
}

class _InfoPageKState extends State<InfoPageK> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text(
          '${widget.kit.name} ',
          style: TextStyle(
              color: kSecondaryColor, fontFamily: 'PlayfairDisplay-Medium'),
        ),
      ),
      body: GridTile(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(30)),
                child: Image.network(widget.kit.image,
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${widget.kit.name}',
                    style: TextStyle(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'PlayfairDisplay-Medium'),
                  ),
                  Text(
                    'Price: ${widget.kit.price} EGP',
                    style: const TextStyle(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'PlayfairDisplay-Medium'),
                  ),
                  SizedBox(
                    height: 230,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      KitRemoteDsImp().addToCart(widget.kit);
                      showToast('Product added to cart');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(500, 50),
                      backgroundColor: kMainColor,
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontFamily: 'PlayfairDisplay-Medium',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
