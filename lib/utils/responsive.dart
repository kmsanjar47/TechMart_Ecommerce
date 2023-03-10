import 'package:flutter/material.dart';

class ResponsiveModel{
  static getDeviceHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
  static getDeviceWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  static padding5(BuildContext context){
    return EdgeInsets.all(MediaQuery.of(context).size.width * 0.00973);
  }
}
