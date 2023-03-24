import 'dart:io';

import 'package:e_commerce_app/widgets/custom_text_field.dart';
import 'package:e_commerce_app/widgets/medium_text.dart';
import 'package:e_commerce_app/widgets/neuphormic_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/big_text.dart';

class PublisherAddProduct extends StatefulWidget {
  const PublisherAddProduct({Key? key}) : super(key: key);

  @override
  State<PublisherAddProduct> createState() => _PublisherAddProductState();
}

class _PublisherAddProductState extends State<PublisherAddProduct> {
  TextEditingController? titleTxtCtl;
  TextEditingController? descriptionTxtCtl;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String? imageRef;

  Future<String?> uploadFile() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {

      String fileName = pickedImage.name;
      File imageFile = File(pickedImage.path);
      try {
        await firebaseStorage.ref(fileName).putFile(imageFile);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: MediumText(text: "Successfully Uploaded")));
        return firebaseStorage.ref().child(fileName).getDownloadURL();
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: MediumText(
          text: e.toString(),
        )));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: MediumText(
          text: e.toString(),
        )));
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    titleTxtCtl = TextEditingController();
    descriptionTxtCtl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const BigText(
          text: "Add Product",
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () async {
                await uploadFile().then((value) {
                  print(value);
                  value != null
                      ? setState(() {
                          imageRef = value;
                        })
                      : imageRef = null;
                });
                print(imageRef);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: Colors.grey[200],
                    border: Border.all(width: 2, color: Colors.grey.shade400)),
                child: imageRef == null
                    ? const Center(
                        child: Icon(
                          CupertinoIcons.plus_app_fill,
                          size: 50,
                        ),
                      )
                    : Image.network(imageRef!,fit: BoxFit.fill,)
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () async {
                    await uploadFile().then((value) {
                      print(value);
                      value != null
                          ? setState(() {
                        imageRef = value;
                      })
                          : imageRef = null;
                    });
                    print(imageRef);
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Colors.grey[200],
                      border: Border.all(width: 2, color: Colors.grey.shade400),
                    ),
                    child: imageRef == null
                        ? const Center(
                      child: Icon(
                        CupertinoIcons.plus_app_fill,
                        size: 50,
                      ),
                    )
                        : Image.network(imageRef!,fit: BoxFit.fill,)
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () async {
                    await uploadFile().then((value) {
                      print(value);
                      value != null
                          ? setState(() {
                        imageRef = value;
                      })
                          : imageRef = null;
                    });
                    print(imageRef);
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Colors.grey[200],
                      border: Border.all(width: 2, color: Colors.grey.shade400),
                    ),
                    child: imageRef == null
                        ? const Center(
                      child: Icon(
                        CupertinoIcons.plus_app_fill,
                        size: 50,
                      ),
                    )
                        : Image.network(imageRef!,fit: BoxFit.fill,)
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () async {
                    await uploadFile().then((value) {
                      print(value);
                      value != null
                          ? setState(() {
                        imageRef = value;
                      })
                          : imageRef = null;
                    });
                    print(imageRef);
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Colors.grey[200],
                      border: Border.all(width: 2, color: Colors.grey.shade400),
                    ),
                    child: imageRef == null
                        ? const Center(
                      child: Icon(
                        CupertinoIcons.plus_app_fill,
                        size: 50,
                      ),
                    )
                        : Image.network(imageRef!,fit: BoxFit.fill,)
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () async {
                    await uploadFile().then((value) {
                      print(value);
                      value != null
                          ? setState(() {
                        imageRef = value;
                      })
                          : imageRef = null;
                    });
                    print(imageRef);
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Colors.grey[200],
                      border: Border.all(width: 2, color: Colors.grey.shade400),
                    ),
                    child: imageRef == null
                        ? const Center(
                      child: Icon(
                        CupertinoIcons.plus_app_fill,
                        size: 50,
                      ),
                    )
                        : Image.network(imageRef!,fit: BoxFit.fill,)
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
                textEditingController: titleTxtCtl,
                hintText: "Add A Product Title"),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
                textEditingController: descriptionTxtCtl,
                hintText: "Add Product Description"),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NeuphormicButton(
                  width: 100,
                  height: 50,
                  onTap: () {},
                  color: Colors.red,
                  centerWidget: const MediumText(
                    text: "Cancel",
                    color: Colors.white,
                  ),
                  widgetColor: Colors.grey.shade200,
                ),
                NeuphormicButton(
                    width: 100,
                    height: 50,
                    onTap: () {},
                    widgetColor: Colors.grey.shade200,
                    centerWidget: const MediumText(text: "Add Product")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
