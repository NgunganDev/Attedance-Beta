import 'package:attedancebeta/color/color_const.dart';
import 'package:flutter/material.dart';

class UserChocard extends StatelessWidget {
  final double widths;
  final double heights;
  final String itemName;
  final VoidCallback action;
  final bool picked;
  final IconData icon;
  const UserChocard(
      {super.key,
      required this.widths,
      required this.heights,
      required this.itemName,
      required this.action,
      required this.picked,
      required this.icon
      });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: action,
      child: SizedBox(
        width: widths,
        height: heights,
        child: Card(
          color: !picked ? Color.fromARGB(255, 201, 232, 255) : ColorUse.colorBf,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: size.height * 0.03,
                color: !picked ? ColorUse.colorBf : ColorUse.colorAf,
              ),
              Text(
                itemName,
                style: TextStyle(
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.w600,
                  color: !picked ? ColorUse.colorBf : ColorUse.colorAf,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
