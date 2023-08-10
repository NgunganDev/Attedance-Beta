import 'package:attedancebeta/color/color_const.dart';
import 'package:flutter/material.dart';

class DrawerHeaderAdmin extends StatelessWidget {
  final String name;
  final String imageUrl;
  const DrawerHeaderAdmin({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: ColorUse.colorBf,
            backgroundImage: NetworkImage(imageUrl),
          ),
          Text(name, style: TextStyle(
            fontSize: size.height * 0.02,
            fontWeight: FontWeight.w600
          ),),
        ],
      ),
    );
  }
}