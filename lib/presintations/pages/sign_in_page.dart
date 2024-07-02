import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy/presintations/bloc/authentication_bloc.dart';
import 'package:pharmacy/presintations/pages/products_page.dart';
import 'package:pharmacy/presintations/pages/sign_up_page.dart';
import 'package:pharmacy/presintations/widgets/custom_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin {
  bool obscurePassword = true;
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController EmailC = TextEditingController();
  TextEditingController PasswordC = TextEditingController();
  String password = '';
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  @override
  void initState() {
    context.read<AuthenticationBloc>().add(IsSignedInEvent());

    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1050),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/100.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is Authorized) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const ProductsPage()),
                );
              }
            },
            builder: (context, state) {
              print(state);
              return ListView(
                children: [
                  Form(
                    key: key,
                    child: Stack(
                      children: [
                        if (state is AuthLoding)
                          Lottie.asset(
                            'assets/images/1.json',
                            height: 100, 
                            width: 100, 
                            repeat: true, 
                          ),
                        if (state is AuthError) const Text('Error'),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 80, right: 180),
                              child: const Text(
                                'Welcome\nBack',
                                style: TextStyle(fontSize: 33),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 80, right: 35, left: 35),
                              child: Column(
                                children: [
                                  CustomTextField(
                                    controller: EmailC,
                                    hintText: 'Email',
                                    prefixIcon: Icons.mail,
                                    validator: (text) {
                                      if (text == null ||
                                          !text.contains('@') ||
                                          text.startsWith('@') ||
                                          !text.endsWith('.com') ||
                                          text.length < 5) {
                                        return 'Invalid Email';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  CustomTextField(
                                    controller: PasswordC,
                                    hintText: 'Password',
                                    obscureText: obscurePassword,
                                    showPasswordToggle: true,
                                    validator: (pass) {
                                      if (pass == null || pass.length < 6) {
                                        return 'Invalid Password';
                                      } else {
                                        return null;
                                      }
                                    },
                                    prefixIcon: Icons.lock,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 70),
                              child: Row(
                                children: [
                                  const SizedBox(width: 30),
                                  const Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 160),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: const Color(0xff4c505b),
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        if (key.currentState!.validate()) {
                                          context
                                              .read<AuthenticationBloc>()
                                              .add(
                                                SignInEvent(
                                                  email: EmailC.text,
                                                  password: PasswordC.text,
                                                ),
                                              );
                                          if (state is UnAuthorized)
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                    'Sign Up Required'),
                                                content: const Text(
                                                  'Please sign up first before logging in.',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            );
                                        }
                                      },
                                      icon: const Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 35,
                                ),
                                const Text(
                                  'Don\'t have an account ? ',
                                  style: TextStyle(
                                      color: Color(0xff4c505b), fontSize: 18),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color.fromARGB(255, 40, 33, 171),
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
