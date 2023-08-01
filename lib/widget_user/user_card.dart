import 'package:attedancebeta/color/color_const.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final double widths;
  final double heights;
  final String name;
  final String image;
  const UserCard(
      {super.key,
      required this.heights,
      required this.widths,
      required this.name,
      required this.image});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: widths,
      height: heights,
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.3,
              height: size.height * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: size.height * 0.05,
                    backgroundColor: ColorUse.colorBf,
                    backgroundImage: NetworkImage(image),
                  ),
                  Text(
                    'Active User',
                    style: TextStyle(
                        fontSize: size.height * 0.024,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width * 0.3,
              height: size.height * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: size.height * 0.03,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'checkin :',
                          style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          '12.00',
                          style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          'checkin :',
                          style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          '14.00',
                          style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
