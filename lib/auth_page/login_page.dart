import 'package:attedancebeta/color/color_const.dart';
import 'package:attedancebeta/widget_control/button_control.dart';
import 'package:attedancebeta/widget_control/form_control.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controlemail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(color: ColorUse.mainBg),
        // padding: EdgeInsets.symmetric(
        //   vertical: size.height * 0.04,
        //   horizontal: size.width * 0.03,
        // ),
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.05,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.04,
                    horizontal: size.width * 0.04),
                width: size.width,
                height: size.height * 0.25,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: size.height * 0.055,
                            fontWeight: FontWeight.w600,
                            color: ColorUse.colorText),
                      ),
                      Text(
                        'Hi Welcome Back',
                        style: TextStyle(
                            fontSize: size.height * 0.03,
                            fontWeight: FontWeight.w400,
                            color: ColorUse.colorText),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.height * 0.07),
                      topRight: Radius.circular(size.height * 0.07),
                    ),
                    color: ColorUse.colorAf,
                  ),
                  width: size.width,
                  height: size.height * 0.7,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          FormControl(
                              colors: ColorUse.colorText,
                              widths: size.width * 0.85,
                              heights: size.height * 0.098,
                              hint: 'email...',
                              controlit: _controlemail,
                              icon: Icons.email_sharp),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          FormControl(
                              colors: ColorUse.colorText,
                              widths: size.width * 0.85,
                              heights: size.height * 0.098,
                              hint: 'password...',
                              controlit: _controlemail,
                              icon: Icons.password_sharp),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        width: size.width * 0.85,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){

                            }, child: const Text('Dont have a account', style: TextStyle(
                              fontStyle: FontStyle.normal
                            ),))
                          ],
                        ),
                      ),
                      ButtonControl(
                          widths: size.width * 0.83,
                          colorbg: ColorUse.colorBf,
                          heights: size.height * 0.075,
                          text: 'SignIn',
                          action: (){
                          },
                          size: size)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
