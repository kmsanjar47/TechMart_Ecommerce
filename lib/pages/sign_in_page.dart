import 'package:e_commerce_app/controllers/auth_controllers.dart';
import 'package:e_commerce_app/controllers/user_controllers.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/pages/General%20User/pages.dart';
import 'package:e_commerce_app/pages/Publisher/publisher_dashboard_page.dart';
import 'package:e_commerce_app/pages/Publisher/publisher_navigation_page.dart';
import 'package:e_commerce_app/pages/Publisher/publisher_sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    UserController userController =
        Provider.of<UserController>(context, listen: false);
    userController.emailTxtCtl;
    userController.passwordTxtCtl;
  }

  @override
  void dispose() {
    UserController userController =
        Provider.of<UserController>(context, listen: false);
    userController.emailTxtCtl.dispose();
    userController.passwordTxtCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<UserController>(builder: (_, controller, ___) {
        return Scaffold(
          //AppBar
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            centerTitle: true,
            title: const Text("TechMart"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Sign in text
                const Text(
                  "Sign in",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(
                  height: 10,
                ),

                //Username Text field
                CustomTextField(
                  textEditingController: controller.emailTxtCtl,
                  hintText: "Email",
                ),

                //Password Text field
                CustomTextField(
                  obscureText: true,
                  textEditingController: controller.passwordTxtCtl,
                  hintText: "Password",
                ),

                const SizedBox(
                  height: 10,
                ),

                //Sign in button
                ElevatedButton(
                  onPressed: () async {
                    User? user = await AuthController().signIn(
                        controller.emailTxtCtl.text,
                        controller.passwordTxtCtl.text,
                        context);
                    if (user != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const TechMart(),),(route)=>true);
                      }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    minimumSize: const MaterialStatePropertyAll(
                      Size(double.infinity, 50),
                    ),
                  ),
                  child: const Text("Sign In"),
                ),
                const SizedBox(
                  height: 10,
                ),

                //New User?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
