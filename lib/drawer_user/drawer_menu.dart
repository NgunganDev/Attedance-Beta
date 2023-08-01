import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color icColor;
  const DrawerMenu({super.key, required this.icon, required this.name, required this.icColor});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
        // vertical: size.height * 0.01
      ),
      child: SizedBox(
        width: size.width * 0.5,
        height: size.height * 0.08,
        child: Card(
          color: Colors.white,
          elevation: 0,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: size.height * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, color: icColor,),
                SizedBox(
                  width: size.width * 0.08,
                ),
                Text(name, style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontWeight: FontWeight.w500
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
