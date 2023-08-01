import 'package:flutter/material.dart';

class UserButton extends StatelessWidget {
  final double width;
  final double height;
  final Color colo;
  final VoidCallback action;
  final IconData ic;
  final String name;
  const UserButton({super.key, required this.name,required this.ic, required this.width, required this.height, required this.action, required this.colo});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colo,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )
        ),
        onPressed: action,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(name, style: TextStyle(
              fontSize: size.height * 0.02,
              fontWeight: FontWeight.w500
            ),),
            Icon(ic),
          ],
        ),
      ),
    );
  }
}