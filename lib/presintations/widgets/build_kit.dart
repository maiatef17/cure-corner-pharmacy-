import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmacy/constants.dart';
import 'package:pharmacy/data/kit_remote_data.dart';
import 'package:pharmacy/data/models/kit.dart';
import 'package:pharmacy/data/models/product.dart';
import 'package:pharmacy/presintations/bloc/kit_bloc.dart';
import 'package:pharmacy/presintations/bloc/kit_event.dart';
import 'package:pharmacy/presintations/pages/info_page.dart';
import 'package:pharmacy/presintations/widgets/show_kit.dart';
import 'package:pharmacy/presintations/widgets/show_products_widget.dart';

class BuildKitWidget extends StatelessWidget {
  final List<Kit> kits;
  final TextEditingController searchController;

  const BuildKitWidget({
    Key? key,
    required this.kits,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredKits = kits
        .where((kit) => kit.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();

    if (filteredKits.isEmpty && searchController.text.isNotEmpty) {
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
      itemCount: filteredKits.length,
      itemBuilder: (context, i) => ShowKits(kit: filteredKits[i]),
    );
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
  );
}

