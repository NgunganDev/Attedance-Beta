import 'package:attedancebeta/all_method/method_firebase.dart';
import 'package:attedancebeta/color/color_const.dart';
import 'package:attedancebeta/routed/final_routed.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:attedancebeta/widget_control/button_control.dart';
import 'package:attedancebeta/widget_control/form_control.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model_db/hive_model.dart';
// import 'package:hive/hive.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  StateManage statemanage = StateManage();
  final _method = MethodFirebase();
  final _controlemail = TextEditingController();
  final _controlpassword = TextEditingController();
  final _controlinstansi = TextEditingController();
  User? user;
  Box box = Hive.box<Dbmodel>('boxname');

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;
    super.initState();
     if(user != null ){
      print('ada user');
      Future.delayed(const Duration(seconds: 1), (){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FinalRouted()));
      });
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FinalRouted()));
     }
  }

  @override
  Widget build(BuildContext context) {
    final watchit = ref.watch(statemanage.statepage);
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
                      InkWell(
                        onTap: () async {
                          print(box.length);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: size.height * 0.055,
                              fontWeight: FontWeight.w600,
                              color: ColorUse.colorText),
                        ),
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
                                fontSize: size.height * 0.02,
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
                                fontSize: size.height * 0.02,
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
                              controlit: _controlpassword,
                              icon: Icons.password_sharp),
                        ],
                      ),
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Instansi',
                            style: TextStyle(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          FormControl(
                              colors: ColorUse.colorText,
                              widths: size.width * 0.85,
                              heights: size.height * 0.098,
                              hint: 'instansi',
                              controlit: _controlinstansi,
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
                            TextButton(
                                onPressed: () {
                                  ref
                                      .read(stateauth.notifier)
                                      .update((state) => 1);
                                  print(watchit);
                                },
                                child: const Text(
                                  'Dont have an account',
                                  style: TextStyle(fontStyle: FontStyle.normal),
                                ))
                          ],
                        ),
                      ),
                      ButtonControl(
                          widths: size.width * 0.85,
                          colorbg: ColorUse.colorBf,
                          heights: size.height * 0.075,
                          text: 'SignIn',
                          action: () async {
                            await _method.signinemail(_controlemail.text,
                                _controlpassword.text, context);
                                await box.put(0, Dbmodel(instansiName: _controlinstansi.text));
                                _controlemail.clear();
                                _controlpassword.clear();
                                _controlinstansi.clear();
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
