import 'package:flutter/material.dart';

class NavBarItemWidget extends StatelessWidget {
  final Function()? onTap;
  final IconData? icon;
  final String? title;
  final bool? isSelected;


  const NavBarItemWidget({
    Key? key,
    @required this.onTap,
    @required this.isSelected,
    @required this.title,
    @required this.icon
  }) : super(key: key);

  Color get _color =>
      isSelected == true ? Colors.blue : Colors.grey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,size: 24,color: _color,),
              Text(
                title!,
                style: TextStyle(
                    color: isSelected! ? Colors.black : Colors.grey,
                    fontWeight:
                    isSelected! ? FontWeight.bold : FontWeight.normal),
              )
            ],
          ),
        ),
      ),
    );
  }
}