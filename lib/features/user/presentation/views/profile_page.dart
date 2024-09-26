import 'package:ecommerce_app/features/user/presentation/blocs/login/login_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/login/login_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/login/login_state.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/logout/logout_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/logout/logout_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_state.dart';
import 'package:ecommerce_app/features/user/presentation/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  static String routeName = "/ProfilePage";

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontFamily: "Poppins-Light"),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              BlocBuilder<PersonalBloc, PersonalState>(
                builder: (context, state) {
                  if(state is PersonalLoaded){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/ic_avatar.png",
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.15,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 16),
                        Container(
                          margin: const EdgeInsets.only(left: 2),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.user.name!.firstname} ${state.user.name?.lastname}".toUpperCase(),
                                style: const TextStyle(
                                    fontFamily: "Poppins-Light",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16),
                              ),
                              Text(
                                "@${state.user.username}",
                                style: const TextStyle(fontFamily: "Poppins-Light"),
                              ),
                              const Text(
                                "View My Profile",
                                style: TextStyle(
                                  fontFamily: "Poppins-Light",
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF33bf2e),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  return  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/ic_avatar.png",
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.15,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 16),
                      Container(
                        margin: const EdgeInsets.only(left: 2),
                        alignment: Alignment.center,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontFamily: "Poppins-Light",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                            Text(
                              "Username",
                              style: TextStyle(fontFamily: "Poppins-Light"),
                            ),
                            Text(
                              "UHUHU",
                              style: TextStyle(fontFamily: "Poppins-Light"),
                            ),
                            Text(
                              "View My Profile",
                              style: TextStyle(
                                fontFamily: "Poppins-Light",
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF33bf2e),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Container(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        margin: EdgeInsets.only(bottom: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.lock,
                                  size: 30,
                                  color: Color(0xFF33bf2e),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 30
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Change Password",
                                        style: TextStyle(
                                            fontFamily: "Poppins-Regular",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "Change your password",
                                        style: TextStyle(
                                            fontFamily: "Poppins-Regular",
                                            color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                )
                              ],
                            ),
                            const Divider(
                              color: Colors.black12,
                              thickness: 0.5,
                              indent: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.70,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.pin_drop,
                                size: 30,
                                color: Color(0xFF33bf2e),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 60),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Locations",
                                      style: TextStyle(
                                          fontFamily: "Poppins-Regular",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Add your locations",
                                      style: TextStyle(
                                          fontFamily: "Poppins-Regular",
                                          color: Colors.black45),
                                    ),
                                    Divider(
                                      color: Colors.black45,
                                      thickness: 3,
                                      height: 5,
                                      indent: 25,
                                      endIndent: 25,
                                    )
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              )
                            ],
                          ),
                          const Divider(
                            color: Colors.black12,
                            thickness: 0.5,
                            indent: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.70,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.facebook,
                                size: 30,
                                color: Color(0xFF33bf2e),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    right: 10
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Add Social Account",
                                      style: TextStyle(
                                          fontFamily: "Poppins-Regular",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Add Facebook, Twitter etc",
                                      style: TextStyle(
                                          fontFamily: "Poppins-Regular",
                                          color: Colors.black45),
                                    ),
                                    Divider(
                                      color: Colors.black45,
                                      thickness: 3,
                                      height: 5,
                                      indent: 25,
                                      endIndent: 25,
                                    )
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              )
                            ],
                          ),
                          const Divider(
                            color: Colors.black12,
                            thickness: 0.5,
                            indent: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.70,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.share_outlined,
                                size: 30,
                                color: Color(0xFF33bf2e),
                              ),
                              Container(
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Refer to Friends",
                                      style: TextStyle(
                                          fontFamily: "Poppins-Regular",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Get \$10 for reffering friends",
                                      style: TextStyle(
                                          fontFamily: "Poppins-Regular",
                                          color: Colors.black45),
                                    ),
                                    Divider(
                                      color: Colors.black45,
                                      thickness: 3,
                                      height: 5,
                                      indent: 25,
                                      endIndent: 25,
                                    )
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              )
                            ],
                          ),
                          const Divider(
                            color: Colors.black12,
                            thickness: 0.5,
                            indent: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.70,
                      margin: EdgeInsets.only(bottom: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 30,
                                color: Color(0xFF33bf2e),
                              ),
                              Container(
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rate Us",
                                      style: TextStyle(
                                          fontFamily: "Poppins-Regular",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Rate us playstore, appstore",
                                      style: TextStyle(
                                          fontFamily: "Poppins-Regular",
                                          color: Colors.black45),
                                    ),
                                    Divider(
                                      color: Colors.black45,
                                      thickness: 3,
                                      height: 5,
                                      indent: 25,
                                      endIndent: 25,
                                    )
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              )
                            ],
                          ),
                          const Divider(
                            color: Colors.black12,
                            thickness: 0.5,
                            indent: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.70,
                      margin: EdgeInsets.only(bottom: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.book,
                                size: 30,
                                color: Color(0xFF33bf2e),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    right: 50
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "FAQ",
                                      style: TextStyle(
                                          fontFamily: "Poppins-Regular",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Asked any questions",
                                      style: TextStyle(
                                          fontFamily: "Poppins-Regular",
                                          color: Colors.black45),
                                    ),
                                    Divider(
                                      color: Colors.black45,
                                      thickness: 3,
                                      height: 5,
                                      indent: 25,
                                      endIndent: 25,
                                    )
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              )
                            ],
                          ),
                          const Divider(
                            color: Colors.black12,
                            thickness: 0.5,
                            indent: 20,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        BlocProvider.of<LogoutBloc>(context).add(PressLogout());
                        BlocProvider.of<LoginBloc>(context).add(RemoveLogin());
                        showLoaderDialog(context);
                        await Future.delayed(const Duration(seconds: 2));
                        Navigator.pushReplacementNamed(context, LoginPage.routeName);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.login_outlined,
                                  size: 30,
                                  color: Color(0xFF33bf2e),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      right: 50
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Logout",
                                        style: TextStyle(
                                            fontFamily: "Poppins-Regular",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "Logout your account",
                                        style: TextStyle(
                                            fontFamily: "Poppins-Regular",
                                            color: Colors.black45),
                                      ),
                                      Divider(
                                        color: Colors.black45,
                                        thickness: 3,
                                        height: 5,
                                        indent: 25,
                                        endIndent: 25,
                                      )
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                )
                              ],
                            ),
                            const Divider(
                              color: Colors.black12,
                              thickness: 0.5,
                              indent: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = const AlertDialog(
      backgroundColor: Colors.white,
      scrollable: false,
      content: SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text("Signing out..."),
            ],
          ),
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
