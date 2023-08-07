import 'package:attedancebeta/color/color_const.dart';
import 'package:flutter/material.dart';

class MiniButton extends StatelessWidget {
  final String name;
  final bool condition;
  const MiniButton({super.key, required this.name, required this.condition});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      alignment: const Alignment(0, 0),
      width: size.width * 0.2,
      height: size.height * 0.04,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: condition ? ColorUse.colorBf : Colors.grey
      ),
      child: Text(name, style: TextStyle(
        fontSize: size.height * 0.018,
        fontWeight: FontWeight.w500,
        color: ColorUse.colorText
      ),),
    );
  }
}