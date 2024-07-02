import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy/constants.dart';
import 'package:pharmacy/data/models/product.dart';
import 'package:pharmacy/presintations/widgets/show_in_checkout.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key, required this.cartProducts}) : super(key: key);
  final List<Product> cartProducts;

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}
void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
  );
}

class _CheckOutPageState extends State<CheckOutPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var product in widget.cartProducts) {
      totalPrice += product.price * product.quantity;
    }
    return totalPrice;
  }

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      contentPadding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Order',
            style: TextStyle(fontFamily: 'PlayfairDisplay-Medium'),
          ),
          backgroundColor: kMainColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: nameController,
                  decoration: _buildInputDecoration('Name'),
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: emailController,
                  decoration: _buildInputDecoration('Email'),
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: phoneController,
                  decoration: _buildInputDecoration('Phone'),
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: notesController,
                  decoration: _buildInputDecoration('Notes'),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                showToast('Order Confirmed');
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                      color: kSecondaryColor,
                      fontFamily: 'PlayfairDisplay-Medium'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',
                  style: TextStyle(
                      color: kSecondaryColor,
                      fontFamily: 'PlayfairDisplay-Medium')),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text(
          'Checkout',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              fontFamily: 'PlayfairDisplay-Medium'),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                child: Row(
                  children: [
                    Text(
                      "QTY",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayfairDisplay-Medium',
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Text(
                      "PRODUCT NAME",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayfairDisplay-Medium',
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Text(
                      "PRICE",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayfairDisplay-Medium',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.cartProducts.length,
              itemBuilder: (context, i) =>
                  ShowInCheckout(product: widget.cartProducts[i]),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Divider(),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                    ),
                    Text(
                      "Total Price",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayfairDisplay-Medium',
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "${getTotalPrice().toStringAsFixed(2)} \EGP ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayfairDisplay-Medium',
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: _showConfirmationDialog,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(500, 50),
                    backgroundColor: kMainColor,
                  ),
                  child: Text(
                    'CONFIRM ORDER',
                    style: TextStyle(
                        color: kSecondaryColor,
                        fontFamily: 'PlayfairDisplay-Medium'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
