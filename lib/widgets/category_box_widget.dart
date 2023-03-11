import 'package:e_commerce_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class CategoryBox extends StatelessWidget {
  final String imagePath;
  final String categoryName;
  const CategoryBox({required this.categoryName,required this.imagePath,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(8),
          height: ResponsiveModel.getDeviceHeight(context) * 0.60,
          width: ResponsiveModel.getDeviceWidth(context) * 0.60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 14,
                offset: const Offset(4, 4),
              ),
              const BoxShadow(
                color: Colors.white,
                blurRadius: 14,
                offset: Offset(-4, -4),
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
