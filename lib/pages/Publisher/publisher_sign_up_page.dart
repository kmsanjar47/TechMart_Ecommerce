import 'package:e_commerce_app/pages/General%20User/pages.dart';
import "package:flutter/material.dart";
import 'package:e_commerce_app/controllers/auth_controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../controllers/user_controllers.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/medium_text.dart';
import '../../widgets/title_text.dart';

class PublisherSignUpPage extends StatefulWidget {
  const PublisherSignUpPage({Key? key}) : super(key: key);

  @override
  State<PublisherSignUpPage> createState() => _PublisherSignUpPageState();
}

class _PublisherSignUpPageState extends State<PublisherSignUpPage> {
  GlobalKey<FormState>? formKey;

  @override
  void initState() {
    super.initState();
    UserController userController =
        Provider.of<UserController>(context, listen: false);
    userController.publisherNameTxtCtl;
    userController.passwordTxtCtl;
    userController.emailTxtCtl;
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    UserController userController =
        Provider.of<UserController>(context, listen: false);
    userController.publisherNameTxtCtl.dispose();
    userController.passwordTxtCtl.dispose();
    userController.emailTxtCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<UserController>(builder: (_, controller, __) {
        return Scaffold(
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Register
                  const TitleText(text:
                    "Publisher Registration",
                    fontWeight: FontWeight.bold,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //Publisher Name
                  CustomTextFormField(
                    hintText: "Publisher Name",
                    textEditingController: controller.publisherNameTxtCtl,
                    validator: (value) {
                      return value;
                    },
                  ),

                  //Email
                  CustomTextFormField(
                    hintText: "Email",
                    textEditingController: controller.emailTxtCtl,
                    validator: (value) {
                      return value;
                    },
                  ),

                  //Password
                  CustomTextFormField(
                    obscureText: true,
                    hintText: "Password",
                    textEditingController: controller.passwordTxtCtl,
                    validator: (value) {
                      return value;
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  //Register button
                  ElevatedButton(
                    onPressed: () async {
                      User? user = await AuthController().signUpNewUser(
                          controller.emailTxtCtl.text,
                          controller.passwordTxtCtl.text);
                      if (user != null) {
                        UserController().addNewUserData(
                            controller.publisherNameTxtCtl.text,
                            user.email!,
                            user.uid,
                            "publisher");
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Registered Successfully"),
                            ),
                          );
                        }
                        if (context.mounted) Navigator.push(context,MaterialPageRoute(builder: (context)=>const SignInPage(),),);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      minimumSize: const MaterialStatePropertyAll(
                        Size(double.infinity, 50),
                      ),
                    ),
                    child: const MediumText(text: "Register"),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //Already registered?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MediumText(text: "Already registered?"),
                      const SizedBox(
                        width: 7,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ),
                              (route)=>true);
                        },
                        child: const MediumText(
                            text: "Sign in", color: Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const MediumText(text: "General User?"),
                  const SizedBox(
                    height: 15,
                  ),

                  ElevatedButton(
                    onPressed: () {
                     Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      minimumSize: MaterialStatePropertyAll(
                        Size(MediaQuery.of(context).size.width * (1 / 2), 50),
                      ),
                    ),
                    child: const MediumText(text: "Register As An User"),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
