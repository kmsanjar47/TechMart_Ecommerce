import 'package:e_commerce_app/controllers/auth_controllers.dart';
import 'package:e_commerce_app/controllers/user_controllers.dart';
import 'package:e_commerce_app/data/repository/auth_repository.dart';
import 'package:e_commerce_app/pages/General%20User/navigation_page.dart';
import 'package:e_commerce_app/pages/General%20User/pages.dart';
import 'package:e_commerce_app/pages/Publisher/publisher_navigation_page.dart';
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
  ], child: const TechMart()));
}

class TechMart extends StatefulWidget {
  const TechMart({Key? key}) : super(key: key);

  @override
  State<TechMart> createState() => _TechMartState();
}

class _TechMartState extends State<TechMart> {
  String userType = "";

  @override
  void initState() {
    super.initState();
    UserController userController =
        Provider.of<UserController>(context, listen: false);
    userController.getUserType(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<UserController>(builder: (_, controller, ___) {
        return Scaffold(
          body: StreamBuilder(
              stream: AuthRepository().firebaseAuth.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (controller.userType == "general") {
                    return const NavigationPage();
                  } else {
                    return const PublisherNavigationPage();
                  }
                }
                return const SignInPage();
              }),
        );
      }),
    );
  }
}
