import 'package:e_commerce_app/controllers/auth_controllers.dart';
import 'package:e_commerce_app/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class CategoryBox extends StatelessWidget {
  final String imagePath;
  final String categoryName;

  const CategoryBox(
      {required this.categoryName, required this.imagePath, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        AuthRepository().firebaseAuth.signOut();
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(8),
          height: ResponsiveModel.getDeviceHeight(context) * 0.60,
          width: ResponsiveModel.getDeviceWidth(context) * 0.60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: Colors.grey[100],
            boxShadow: [
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-5.0, -5.0),
                blurRadius: 10.0,
                spreadRadius: 0.0,
              ),
              BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(5.0, 5.0),
                blurRadius: 10.0,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
      ),
    );
  }
}
