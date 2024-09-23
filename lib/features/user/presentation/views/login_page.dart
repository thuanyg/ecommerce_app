import 'package:ecommerce_app/features/product/presentation/views/home_page.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/login/login_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/login/login_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/login/login_state.dart';
import 'package:ecommerce_app/features/user/presentation/components/button.dart';
import 'package:ecommerce_app/features/user/presentation/components/inputfield.dart';
import 'package:ecommerce_app/features/user/presentation/views/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "/LoginPage";

  LoginPage({super.key});

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
        child: Center(
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: [
                const SizedBox(height: 120),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 23.0),
                CustomInputField(
                  controller: _emailController,
                  label: "Email or username",
                  prefixIconName: "assets/images/ic_email_outlined.png",
                ),
                const SizedBox(height: 18.0),
                CustomInputField(
                  controller: _passwordController,
                  obscureText: true,
                  label: "Your password",
                  prefixIconName: "assets/images/ic_lock_outlined.png",
                ),
                const SizedBox(height: 36.0),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginInitial) {
                      return MainElevatedButton(
                        textButton: "LOGIN",
                        onTap: () {
                          handleLogin(context);
                        },
                      );
                    }
                    if (state is LoginLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is LoginError) {
                      return Center(
                        child: Column(
                          children: [
                            const Text(
                              "Username or password incorrect!",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 36.0),
                            MainElevatedButton(
                              textButton: "LOGIN",
                              onTap: () {
                                handleLogin(context);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is LoginSuccess) {
                      // Avoid calling Navigator inside build directly
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushNamed(MyHomePage.routeName);
                      });
                    }
                    return const Center(
                      child: SizedBox.shrink(),
                    );
                  },
                ),
                const SizedBox(height: 24.0),
                buildDivider(),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account? ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(SignupPage.routeName);
                          },
                          child: const Text(
                            "Signup",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildDivider() {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'OR',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  handleLogin(BuildContext context) async {
    String username = _emailController.text.trim();
    String password = _passwordController.text.trim();
    BlocProvider.of<LoginBloc>(context).add(PressLogin(username, password));
  }
}
