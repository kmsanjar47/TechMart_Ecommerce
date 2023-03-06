import 'package:e_commerce_app/pages/dashboard_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TechMart());
}

class TechMart extends StatelessWidget {
  const TechMart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}
