import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy/presintations/bloc/authentication_bloc.dart';
import 'package:pharmacy/presintations/pages/products_page.dart';
import 'package:pharmacy/presintations/pages/sign_in_page.dart';
import 'package:pharmacy/presintations/widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
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
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/100.jpg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is Authorized) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ProductsPage()));
                }
              },
              builder: (context, state) {
                print(state);
                return ListView(
                  children: [
                    Center(
                      child: Form(
                        key: key,
                        child: Stack(
                          children: [
                            if (state is AuthLoding)
                              Lottie.asset(
                                'assets/images/1.json',
                                height: 200,
                                width: 200,
                                repeat: true,
                              ),
                            if (state is AuthError) const Text('Error'),
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 35, top: 30),
                              child: const Text(
                                'Create\nAccount',
                                style: TextStyle(fontSize: 33),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 35, right: 35),
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
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          CustomTextField(
                                            controller: PasswordC,
                                            hintText: 'Password',
                                            obscureText: obscurePassword,
                                            showPasswordToggle: true,
                                            validator: (pass) {
                                              if (pass == null ||
                                                  pass.length < 6) {
                                                return 'Invalid Password';
                                              } else {
                                                return null;
                                              }
                                            },
                                            prefixIcon: Icons.lock,
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Sign Up',
                                                style: TextStyle(
                                                    fontSize: 27,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              if (state is UnAuthorized)
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor:
                                                      const Color(0xff4c505b),
                                                  child: IconButton(
                                                      color: Colors.white,
                                                      onPressed: () {
                                                        if (key.currentState!
                                                            .validate()) {
                                                          context
                                                              .read<
                                                                  AuthenticationBloc>()
                                                              .add(SignUpEvent(
                                                                  email: EmailC
                                                                      .text,
                                                                  password:
                                                                      PasswordC
                                                                          .text));
                                                        }
                                                      },
                                                      icon: const Icon(
                                                        Icons.arrow_forward,
                                                      )),
                                                ),
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundColor:
                                                    const Color(0xff4c505b),
                                                child: Tooltip(
                                                  message: 'Sign in as a guest',
                                                  child: IconButton(
                                                    color: Colors.white,
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              AuthenticationBloc>()
                                                          .add(
                                                              SignInAnonEvent());
                                                    },
                                                    icon: const Icon(Icons
                                                        .groups_2_outlined),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Already have an account?  ',
                                                style: TextStyle(
                                                    color: Color(0xff4c505b),
                                                    fontSize: 18),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SignInPage(),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'Sign In',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Color.fromARGB(
                                                          255, 40, 33, 171),
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
