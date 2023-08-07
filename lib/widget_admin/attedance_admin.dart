import 'package:flutter/material.dart';

import '../color/color_const.dart';

class AttedanceCardAdmin extends StatelessWidget {
  final String checkin;
  final String time;
  final String checkout;
  final Widget asset;
  final VoidCallback action;
  final bool accept;
  const AttedanceCardAdmin(
      {super.key,
      required this.checkout,
      required this.asset,
      required this.checkin,
      required this.time,
      required this.action,
      required this.accept
      });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width * 0.8,
      height: size.height * 0.25,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              // vertical: size.height * 0.02,
              horizontal: size.width * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    onTap: action,
                    child: accept ? Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      width: size.width * 0.28,
                      height: size.height * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ColorUse.colorBf),
                        child: Row(
                          children: [
                            const Icon(Icons.check, color: Colors.white,),
                            Text(
                              'Accepted',
                              style: TextStyle(color: ColorUse.colorText, fontWeight: FontWeight.w500, fontSize: size.height * 0.02),
                            ),
                          ],
                        )) : Container(
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      width: size.width * 0.28,
                      height: size.height * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey),
                        child: Row(
                          children: [
                            const Icon(Icons.not_interested_outlined, color: Colors.white,),
                            Text(
                              'Not Yet',
                              style: TextStyle(color: ColorUse.colorText, fontWeight: FontWeight.w500, fontSize: size.height * 0.02),
                            ),
                          ],
                        ))
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                    horizontal: size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.1,
                      height: size.height * 0.12,
                      child: asset,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CheckIn',
                          style: TextStyle(
                              fontSize: size.height * 0.03,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(checkin),
                        Text(
                          'CheckOut',
                          style: TextStyle(
                              fontSize: size.height * 0.03,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(checkout)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
