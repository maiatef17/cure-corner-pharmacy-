import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/constants.dart';
import 'package:pharmacy/data/kit_remote_data.dart';
import 'package:pharmacy/data/models/kit.dart';
import 'package:pharmacy/presintations/bloc/kit_bloc.dart';
import 'package:pharmacy/presintations/pages/check_out_page.dart';
import 'package:pharmacy/presintations/pages/info_page.dart';

class ShowKits extends StatefulWidget {
  const ShowKits({super.key, required this.kit});
  final Kit kit;
  @override
  State<ShowKits> createState() => _ShowKitsState();
}

class _ShowKitsState extends State<ShowKits> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KitBloc, KitState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InfoPageK(
                          kit: widget.kit,
                        )));
            setState(() {});
          },
          child: Container(
              color: Colors.grey[100],
              margin: const EdgeInsets.all(5),
              width: 180,
              height: 180,
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
                          widget.kit.name,
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
                              widget.kit.price.toString(),
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
                              width: 80,
                            ),
                            GestureDetector(
                                onTap: () {
                                  KitRemoteDsImp().addToCart(widget.kit);
                                  showToast('Product added to cart');
                                },
                                child: Icon(Icons.add_shopping_cart_outlined)),
                          ],
                        )
                      ],
                    ),
                  ),
                  child: Image.network(
                    widget.kit.image,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
        );
      },
    );
  }
}
