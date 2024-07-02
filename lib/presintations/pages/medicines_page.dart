import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy/presintations/bloc/products_bloc.dart';
import 'package:pharmacy/presintations/bloc/products_event.dart';
import 'package:pharmacy/presintations/bloc/products_state.dart';
import 'package:pharmacy/presintations/widgets/build_Product.dart';

class MedicinesPage extends StatefulWidget {
  final TextEditingController searchController;

  const MedicinesPage({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  State<MedicinesPage> createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProduct());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              if (state is ProductLoadingState)
                Lottie.asset(
                  'assets/images/1.json',
                  height: 100,
                  width: 100,
                  repeat: true,
                ),
              if (state is ProductErrorState) Text('Error'),
              if (state is ProductLoaded)
                BuildProductWidget(
                  products: state.products,
                  searchController: widget.searchController,
                )
            ],
          ),
        );
      },
    );
  }
}
