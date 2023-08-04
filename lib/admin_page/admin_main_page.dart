import 'package:attedancebeta/color/color_const.dart';
import 'package:flutter/material.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.height * 0.03),
              topRight: Radius.circular(size.height * 0.03)),
          color: ColorUse.mainBg,
        ),
        width: size.width,
        height: size.height,
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.height * 0.03),
                      topRight: Radius.circular(size.height * 0.03)),
                color: ColorUse.colorAf,
                ),
                width: size.width,
                height: size.height * 0.7,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
