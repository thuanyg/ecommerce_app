import 'package:ecommerce_app/core/utils/storage.dart';
import 'package:ecommerce_app/features/home/home_page.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_bloc.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_event.dart';
import 'package:ecommerce_app/features/user/presentation/blocs/personal/personal_state.dart';
import 'package:ecommerce_app/features/user/presentation/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  static String routeName = "/SplashScreen";

  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    fetchStartingData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // Tùy chỉnh kiểu dáng của thanh trạng thái
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.teal,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.teal,
      body: BlocListener<PersonalBloc, PersonalState>(
        listener: (context, state) {
          if (state is PersonalLoaded) {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          } else if (state is PersonalError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Something went wrong. Please try again!"),
              ),
            );
          }
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  const SizedBox(height: 8),
                  Lottie.asset(
                    "assets/animations/loading.json",
                    width: 130,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.02),
                child: RichText(
                  text: TextSpan(
                    text: "Version v1.0.0",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins-Light",
                      fontSize: MediaQuery.of(context).size.height * 0.016,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchStartingData() async {
    String? id = await StorageUtils.getValue(key: "userid");
    if (id == null) {
      Navigator.pushNamed(context, LoginPage.routeName);
    } else {
      context.read<PersonalBloc>().add(PersonalLoadInformation(id));
    }
  }
}
