import 'package:flutter/material.dart';

class ButtonControl extends StatelessWidget {
  final double widths;
  final double heights;
  final Color colorbg;
  final String text;
  final VoidCallback action;
  final Size size;
  const ButtonControl({super.key,
  required this.widths,
  required this.colorbg,
  required this.heights,
  required this.text,
  required this.action,
  required this.size
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widths,
      height: heights,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14)
          ),
          backgroundColor: colorbg
        ),
        onPressed: action, child: Text(text, style: TextStyle(
          fontSize: size.height * 0.025,
          fontWeight: FontWeight.w600
        ),)),
    );
  }
}