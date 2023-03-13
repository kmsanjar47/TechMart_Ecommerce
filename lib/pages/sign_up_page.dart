import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController? userNameTxtCtl;
  TextEditingController? passwordTxtCtl;
  TextEditingController? emailTxtCtl;
  GlobalKey<FormState>? formKey;

  @override
  void initState() {
    super.initState();
    userNameTxtCtl = TextEditingController();
    passwordTxtCtl = TextEditingController();
    emailTxtCtl = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    userNameTxtCtl?.dispose();
    passwordTxtCtl?.dispose();
    emailTxtCtl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Register
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),

                const SizedBox(
                  height: 10,
                ),

                //Username
                CustomTextFormField(
                  hintText: "Username",
                  textEditingController: userNameTxtCtl,
                  validator: (value) {
                    return value;
                  },
                ),

                //Email
                CustomTextFormField(
                  hintText: "Email",
                  textEditingController: emailTxtCtl,
                  validator: (value) {
                    return value;
                  },
                ),

                //Password
                CustomTextFormField(
                  obscureText: true,
                  hintText: "Password",
                  textEditingController: passwordTxtCtl,
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
                    User? user = await AuthService()
                        .signUpNewUser(emailTxtCtl!.text, passwordTxtCtl!.text);
                    if (user != null) {
                      FirestoreService().addNewUserData(userNameTxtCtl!.text, user.email!, user.uid);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Registration Successfull"),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    minimumSize: const MaterialStatePropertyAll(
                      Size(double.infinity, 50),
                    ),
                  ),
                  child: const Text("Register"),
                ),

                const SizedBox(
                  height: 10,
                ),

                //Already registered?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already registered?"),
                    const SizedBox(
                      width: 7,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
