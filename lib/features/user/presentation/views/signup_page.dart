import 'package:ecommerce_app/core/utils/dialog.dart';
import 'package:ecommerce_app/features/home/home_page.dart';
import 'package:ecommerce_app/features/user/data/models/user.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/signup/signup_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/signup/signup_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/signup/signup_state.dart';
import 'package:ecommerce_app/features/user/presentation/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SignupPage extends StatefulWidget {
  static String routeName = "/SignUpPage";

  const SignupPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text(
              'Back',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget _entryField(TextEditingController controller, String title,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: signUpAction,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xfffbb448), Color(0xfff7892b)],
          ),
        ),
        child: const Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'E',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
              text: 'com',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'merce',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField(usernameController, "Username"),
        _entryField(emailController, "Email"),
        _entryField(passwordController, "Password", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    const SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) {
                        if (state is SignUpLoading) {
                          return Center(
                            child: Lottie.asset(
                              "assets/animations/loading.json",
                              width: 90,
                            ),
                          );
                        }

                        if (state is SignUpSuccess) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pushNamed(LoginPage.routeName);
                          });
                        }

                        if (state is SignUpError) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Text(
                              "Email or username already exists!",
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    _submitButton(),
                    SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  void signUpAction() async {
    User user = User(
      username: usernameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: Name(firstname: "", lastname: ""),
      address: Address(
        city: "",
        geolocation: Geolocation(lat: "", long: ""),
        number: 0,
        street: "",
        zipcode: "",
      ),
      phone: "",
    );
    if (user.username != "" && user.email != "" && user.password != "") {
      BlocProvider.of<SignupBloc>(context).add(PressSignUp(user));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter all fields!"),
        ),
      );
    }
  }
}
