import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/presintations/bloc/kit_bloc.dart';
import 'package:pharmacy/presintations/bloc/kit_event.dart';
import 'package:pharmacy/presintations/widgets/build_kit.dart';

class KitsPage extends StatefulWidget {
  final TextEditingController searchController;

  const KitsPage({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  State<KitsPage> createState() => _KitsPageState();
}

class _KitsPageState extends State<KitsPage> {
  @override
  void initState() {
    super.initState();
    context.read<KitBloc>().add(GetKit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<KitBloc, KitState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  if (state is KitLoaded)
                    BuildKitWidget(
                      kits: state.kits,
                      searchController: widget.searchController,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}