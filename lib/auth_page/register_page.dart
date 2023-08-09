import 'package:attedancebeta/color/color_const.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:attedancebeta/widget_control/button_control.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model_db/hive_model.dart';
import '../presenter/auth_presenter.dart';
import '../widget_control/form_control.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  Presenterthree? _present;
  final _controlUser = TextEditingController();
  final _controlEmail = TextEditingController();
  final _controlPassword = TextEditingController();
  final items = ['Admin', 'User'];
  final itemsInstansi = ['Instansi 1', 'Instansi 2', 'Instansi 3'];
  String? type;
  String? selectInstansi;
  // final _method = MethodFirebase();
  var box = Hive.box<Dbmodel>('boxname');

  @override
  void initState() {
    super.initState();
    _present = ref.read(presentre);
  }

  @override
  void dispose() {
    super.dispose();
    _controlEmail.dispose();
    _controlPassword.dispose();
    _controlUser.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        color: ColorUse.mainBg,
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.03,
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
                        'Register',
                        style: TextStyle(
                            fontSize: size.height * 0.055,
                            fontWeight: FontWeight.w600,
                            color: ColorUse.colorText),
                      ),
                      Text(
                        'SignUp Your Account',
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
                  decoration: const BoxDecoration(
                      color: ColorUse.colorAf,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  width: size.width,
                  height: size.height * 0.75,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: items
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: type,
                                onChanged: (String? value) {
                                  setState(() {
                                    type = value;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: ColorUse.colorText),
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: size.height * 0.08,
                                  width: size.width * 0.4,
                                  // elevation: 8
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Instansi',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: itemsInstansi
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectInstansi,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectInstansi = value;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: ColorUse.colorText),
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  height: size.height * 0.08,
                                  width: size.width * 0.4,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap:(){
                              FirebaseAuth.instance.currentUser!.email != null ? print('ji') :
                              print('no');
                            } ,
                            child: Text(
                              'Username',
                              style: TextStyle(
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          FormControl(
                              colors: ColorUse.colorText,
                              widths: size.width * 0.85,
                              heights: size.height * 0.098,
                              hint: 'username',
                              controlit: _controlUser,
                              icon: Icons.email_sharp),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
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
                              controlit: _controlEmail,
                              icon: Icons.email_sharp),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Paswword',
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
                              controlit: _controlPassword,
                              icon: Icons.email_sharp),
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.85,
                        height: size.height * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  ref
                                      .read(stateauth.notifier)
                                      .update((state) => 0);
                                      // print(box.length);
                                },
                                child: Text('Already Have an Account'))
                          ],
                        ),
                      ),
                      ButtonControl(
                          widths: size.width * 0.85,
                          colorbg: ColorUse.colorBf,
                          heights: size.height * 0.08,
                          text: 'SignUp',
                          action: () async {
                            await _present!.signUp(
                                _controlEmail.text,
                                _controlPassword.text,
                                _controlUser.text,
                                selectInstansi!,
                                type!, context);
                                print(box.length);
                          },
                          size: size)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
