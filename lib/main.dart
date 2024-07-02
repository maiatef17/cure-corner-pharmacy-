import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/data/authentication_remote_data_source.dart';
import 'package:pharmacy/data/kit_remote_data.dart';
import 'package:pharmacy/data/models/product.dart';
import 'package:pharmacy/data/products_remote_data_source.dart';
import 'package:pharmacy/presintations/bloc/authentication_bloc.dart';
import 'package:pharmacy/presintations/bloc/kit_bloc.dart';
import 'package:pharmacy/presintations/bloc/products_bloc.dart';
import 'package:pharmacy/presintations/pages/sign_up_page.dart';
import 'package:pharmacy/presintations/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(AuthenticationRemoteDsImp()),
      ),
      BlocProvider<ProductBloc>(
        create: (context) => ProductBloc(ProductRemoteDsImp()),
      ),
      BlocProvider<KitBloc>(
        create: (context) => KitBloc(KitRemoteDsImp()),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(244, 16, 207, 182)),
      ),
      home: SplashScreen(),
    );
  }
}
