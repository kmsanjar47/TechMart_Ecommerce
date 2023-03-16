import "package:e_commerce_app/database_helper/apis.dart";
import "package:e_commerce_app/widgets/custom_text_field.dart";
import "package:e_commerce_app/widgets/title_text.dart";
import "package:flutter/material.dart";

import "../widgets/big_text.dart";
import "../widgets/medium_text.dart";

class ProfileEditPage extends StatefulWidget {
  String username;
  String name;
  String location;
  String country;

  ProfileEditPage(this.username, this.name, this.location, this.country,
      {Key? key})
      : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController usernameTxtCtl = TextEditingController();

  TextEditingController locationTxtCtl = TextEditingController();

  TextEditingController countryTxtCtl = TextEditingController();

  TextEditingController nameTxtCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameTxtCtl.text = widget.username;
    nameTxtCtl.text = widget.name;
    countryTxtCtl.text = widget.country;
    locationTxtCtl.text = widget.location;
  }

  @override
  void dispose() {
    super.dispose();
    nameTxtCtl.dispose();
    usernameTxtCtl.dispose();
    countryTxtCtl.dispose();
    locationTxtCtl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: TitleText(text: "Edit Profile Information")),
          const SizedBox(
            height: 5,
          ),
          BigText(text:"Username:"),
          CustomTextField(
              textEditingController: usernameTxtCtl, hintText: "username"),
          BigText(text:"Name:"),
          CustomTextField(textEditingController: nameTxtCtl, hintText: "name"),
          BigText(text:"Location:"),
          CustomTextField(
              textEditingController: locationTxtCtl, hintText: "location"),
          BigText(text:"Country:"),
          CustomTextField(
              textEditingController: countryTxtCtl, hintText: "country"),

          Center(
            child: ElevatedButton(onPressed: ()async{
              await FirestoreService().updateUserProfileInfo(context, name: nameTxtCtl.text, username: usernameTxtCtl.text, location: locationTxtCtl.text, country: countryTxtCtl.text);
              Navigator.of(context).pop(true);
            }, child: const Text("Submit")),
          )
        ],
      ),
    );
  }
}
