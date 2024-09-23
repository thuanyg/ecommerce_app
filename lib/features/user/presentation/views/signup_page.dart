import 'package:ecommerce_app/features/product/presentation/views/home_page.dart';
import 'package:ecommerce_app/features/user/data/models/user.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/signup/signup_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/signup/signup_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/signup/signup_state.dart';
import 'package:ecommerce_app/features/user/presentation/components/button.dart';
import 'package:ecommerce_app/features/user/presentation/components/inputfield.dart';
import 'package:ecommerce_app/features/user/presentation/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  static String routeName = "/SignInPage";

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
        child: Center(
          child: Form(
            key: _signUpFormKey,
            child: Column(
              children: [
                const SizedBox(height: 120),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "SIGN UP",
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
                  label: "abc@email.com",
                  prefixIconName: "assets/images/ic_email_outlined.png",
                ),
                const SizedBox(height: 18.0),
                CustomInputField(
                  controller: _passwordController,
                  obscureText: true,
                  label: "Your password",
                  prefixIconName: "assets/images/ic_lock_outlined.png",
                ),
                const SizedBox(height: 18.0),
                CustomInputField(
                  controller: _rePasswordController,
                  obscureText: true,
                  label: "Confirm password",
                  prefixIconName: "assets/images/ic_lock_outlined.png",
                ),
                const SizedBox(height: 36.0),
                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    if(state is SignUpInitial) {
                      return const SizedBox.shrink();
                    }
                    if (state is SignUpLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is SignUpError) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    if (state is SignUpSuccess) {
                      // Avoid calling Navigator inside build directly
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushNamed(LoginPage.routeName);
                      });
                    }
                    return const Center(
                      child: Text("Something went wrong!"),
                    );
                  },
                ),
                MainElevatedButton(
                  textButton: "SIGN UP",
                  onTap: () {
                    handleSignUp(context);
                  },
                ),
                const SizedBox(height: 24.0),
                const Row(
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
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(LoginPage.routeName);
                          },
                          child: const Text(
                            "Sign in",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleSignUp(BuildContext context) {
    String fullName = _emailController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    User user = User(email: email, password: password);
    BlocProvider.of<SignupBloc>(context).add(PressSignUp(user));

    // Navigator.of(context).pushNamed(VerificationPage.routeName);
  }
}
