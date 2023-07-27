import 'package:flutter/material.dart';

class FormControl extends StatelessWidget {
  final TextEditingController controlit;
  final double widths;
  final double heights;
  final Color colors;
  final String hint;
  final IconData icon;
  const FormControl(
      {super.key,
      required this.colors,
      required this.widths,
      required this.heights,
      required this.hint,
      required this.controlit,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widths,
      height: heights,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
        ),
        elevation: 8.0,
        child: TextField(
          controller: controlit,
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              fillColor: colors,
              filled: true,
              hintText: hint,
              prefixIcon: Icon(icon)),
        ),
      ),
    );
  }
}
