import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy/constants.dart';
import 'package:pharmacy/data/models/product.dart';
import 'package:pharmacy/presintations/bloc/products_bloc.dart';
import 'package:pharmacy/presintations/bloc/products_event.dart';
import 'package:pharmacy/presintations/bloc/products_state.dart';
import 'package:pharmacy/presintations/pages/check_out_page.dart';
import 'package:pharmacy/presintations/widgets/show_in_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetCartProduct());
  }

  List<Product> getCartProducts() {
    if (context.read<ProductBloc>().state is ProductLoaded) {
      return (context.read<ProductBloc>().state as ProductLoaded).products;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: const Text(
          'Your Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            fontFamily: 'PlayfairDisplay-Medium',
          ),
        ),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      if (state is ProductLoadingState)
                        Container(
                          alignment: Alignment.center,
                          child: Lottie.asset(
                            'assets/images/1.json', // Replace with your Lottie animation file path
                            width: 100,
                            height: 100,
                            // Other Lottie properties can be adjusted here
                          ),
                        ),
                      if (state is ProductErrorState) Text('Error'),
                      if (state is ProductLoaded)
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.products.length,
                          itemBuilder: (context, i) =>
                              ShowInCart(product: state.products[i]),
                        ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CheckOutPage(cartProducts: getCartProducts()),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(500, 50),
                        backgroundColor: kMainColor,
                      ),
                      child: Text(
                        'Check Out',
                        style: TextStyle(
                          color: kSecondaryColor,
                          fontFamily: 'PlayfairDisplay-Medium',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        listener: (BuildContext context, ProductState state) {},
      ),
    );
  }
}
