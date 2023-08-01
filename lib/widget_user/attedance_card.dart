import 'package:attedancebeta/color/color_const.dart';
import 'package:flutter/material.dart';

class AttedanceCard extends StatelessWidget {
  const AttedanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width * 0.7,
      height: size.height * 0.2,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('see attedance'),
            Container(
              child: Row(
                children: [
                  Container(
                    child: Stack(
                      children: [
                        SizedBox(
                          width: size.width * 0.3,
                          height: size.height * 0.3,
                          child: Image.asset('images/att.png', fit:BoxFit.cover,)),
                        Positioned(
                          top: size.height * 0.07,
                          child: Text('CheckIn', style: TextStyle(
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.w500
                          ),),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}