import 'package:e_commerce_app/controllers/auth_controllers.dart';
import 'package:e_commerce_app/controllers/user_controllers.dart';
import 'package:e_commerce_app/data/repository/auth_repository.dart';
import 'package:e_commerce_app/pages/navigation_page.dart';
import 'package:e_commerce_app/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/product_controllers.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthController>(
      create: (context) => AuthController(),
    ),
    ChangeNotifierProvider<UserController>(
      create: (context) => UserController(),
    ),
    ChangeNotifierProvider<ProductController>(
      create: (context) => ProductController(),
    ),


  ],
      child:const TechMart()));


}

class TechMart extends StatelessWidget {
  const TechMart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: AuthRepository
            ().firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NavigationPage();
            }
            return SignInPage();
          }),
    );
  }
}
