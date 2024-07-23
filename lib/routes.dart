import 'package:authexam_firebase/prasentation/homepage/home_page.dart';
import 'package:authexam_firebase/prasentation/login/log_in.dart';
import 'package:authexam_firebase/prasentation/signin/sign_in.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();
  static final AppRoutes instance = AppRoutes._();

  String login = '/';
  String signin = 'sign_in';
  String homepage = 'home_page';

  Map<String, WidgetBuilder> allRoutes = {
    '/': (context) => LogIn(),
    'sign_in': (context) => const SignIn(),
    'home_page': (context) => const HomePage(),
  };
}
