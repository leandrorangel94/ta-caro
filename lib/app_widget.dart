import 'package:flutter/material.dart';
import 'package:ta_caro/modules/feed/feed_page.dart';
import 'package:ta_caro/modules/login/login_page.dart';
import 'package:ta_caro/modules/profile/profile_page.dart';
import 'package:ta_caro/modules/signup/signup_page.dart';
import 'package:ta_caro/modules/splash/splash_page.dart';
import 'package:ta_caro/shared/models/user_model.dart';

import 'modules/home/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Race 1",
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashPage(),
        "/login": (context) => LoginPage(),
        "/home": (context) => HomePage(pages: const [
              FeedPage(),
              ProfilePage(),
            ], user: ModalRoute.of(context)!.settings.arguments as UserModel),
        "/signup": (context) => SignupPage(),
      },
    );
  }
}
