import 'package:e_commerce_app/database_helper/apis.dart';
import 'package:e_commerce_app/main.dart';

import 'package:e_commerce_app/pages/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController? emailTxtCtl;
  TextEditingController? passwordTxtCtl;

  @override
  void initState() {
    super.initState();
    emailTxtCtl = TextEditingController();
    passwordTxtCtl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //AppBar
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text("TechMart"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Sign in text
              const Text("Sign in",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              const SizedBox(height: 10,),

              //Username Text field
              CustomTextField(
                textEditingController: emailTxtCtl,
                hintText: "Email",
              ),

              //Password Text field
              CustomTextField(
                obscureText: true,
                textEditingController: passwordTxtCtl,
                hintText: "Password",
              ),

              const SizedBox(height: 10,),

              //Sign in button
              ElevatedButton(
                onPressed: () async{
                  User? user = await AuthService().signIn(emailTxtCtl!.text, passwordTxtCtl!.text,context);
                  if(user != null){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TechMart(),),);
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
              const SizedBox(height: 10,),

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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage(),),);
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
      ),
    );
  }
}
