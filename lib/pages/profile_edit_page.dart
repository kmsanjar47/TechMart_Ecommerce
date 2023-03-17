import "package:e_commerce_app/controllers/user_controllers.dart";
import "package:e_commerce_app/widgets/custom_text_field.dart";
import "package:e_commerce_app/widgets/title_text.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../widgets/big_text.dart";


class ProfileEditPage extends StatefulWidget {
  final String username;
  final String name;
  final String location;
  final String country;

  const ProfileEditPage(this.username, this.name, this.location, this.country,
      {Key? key})
      : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  void initState() {
    super.initState();
    UserController userController =
        Provider.of<UserController>(context, listen: false);
    userController.usernameTxtCtl.text = widget.username;
    userController.nameTxtCtl.text = widget.name;
    userController.countryTxtCtl.text = widget.country;
    userController.locationTxtCtl.text = widget.location;
  }

  @override
  void dispose() {
    super.dispose();
    UserController userController =
        Provider.of<UserController>(context, listen: false);
    userController.nameTxtCtl.dispose();
    userController.usernameTxtCtl.dispose();
    userController.countryTxtCtl.dispose();
    userController.locationTxtCtl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (_, controller, __) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: TitleText(text: "Edit Profile Information")),
              const SizedBox(
                height: 20,
              ),
              BigText(text: "Username:"),
              CustomTextField(
                  textEditingController: controller.usernameTxtCtl,
                  hintText: "username"),
              BigText(text: "Name:"),
              CustomTextField(
                  textEditingController: controller.nameTxtCtl, hintText: "name"),
              BigText(text: "Location:"),
              CustomTextField(
                  textEditingController: controller.locationTxtCtl,
                  hintText: "location"),
              BigText(text: "Country:"),
              CustomTextField(
                  textEditingController: controller.countryTxtCtl,
                  hintText: "country"),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await UserController().updateUserProfileInfo(context,
                            name: controller.nameTxtCtl.text,
                            username: controller.usernameTxtCtl.text,
                            location: controller.locationTxtCtl.text,
                            country: controller.countryTxtCtl.text);
                        if(context.mounted) Navigator.of(context).pop(true);
                      },
                      child: const Text("Submit")),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("Cancel"),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
