import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/pages/dashboard_page.dart';
import 'package:e_commerce_app/pages/navigation_page.dart';
import 'package:e_commerce_app/pages/firebase_tester.dart';
import 'package:e_commerce_app/pages/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TechMart());
}

class TechMart extends StatelessWidget {
  const TechMart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: AuthService().firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NavigationPage();
            }
            return SignInPage();
          }),
    );
  }
}
