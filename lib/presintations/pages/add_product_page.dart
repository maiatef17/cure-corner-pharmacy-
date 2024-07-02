import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/data/models/kit.dart';
import 'package:pharmacy/data/models/product.dart';
import 'package:pharmacy/presintations/bloc/kit_bloc.dart';
import 'package:pharmacy/presintations/bloc/kit_event.dart';
import 'package:pharmacy/presintations/bloc/products_bloc.dart';
import 'package:pharmacy/presintations/bloc/products_event.dart';
import 'package:pharmacy/presintations/bloc/products_state.dart';
import 'package:pharmacy/presintations/pages/kits_page.dart';
import 'package:pharmacy/presintations/pages/products_page.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController nameC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController imageC = TextEditingController();
  TextEditingController idC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          title: Text(
            ('Add new Product'),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: BlocBuilder<KitBloc, KitState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: key,
                child: ListView(
                  children: [
                    if (state is KitInitial)
                      SizedBox(
                        height: 50,
                      ),
                    TextFormField(
                      controller: nameC,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          return ('field is required');
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: ('name'),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: priceC,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          return ('field is required');
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: ('price'),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: imageC,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          return ('field is required');
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: ('image'),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: idC,
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          return ('field is required');
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: ('id'),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductsPage()));
                            context.read<KitBloc>().add(AddKit(
                                kit: Kit(
                                    image: imageC.text,
                                    name: nameC.text,
                                    id: idC.text,
                                    price: num.parse(priceC.text),
                                    quantity: 1)));
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              ('Add Kit'),
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
