import 'package:attedancebeta/all_method/method_firebase.dart';
import 'package:attedancebeta/color/color_const.dart';
import 'package:attedancebeta/widget_control/button_control.dart';
import 'package:attedancebeta/widget_control/form_control.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../presenter/user_presenter.dart';

class Usernon extends ConsumerStatefulWidget {
  final String user;
  const Usernon({super.key, required this.user});

  @override
  ConsumerState<Usernon> createState() => _UsernonState();
}

class _UsernonState extends ConsumerState<Usernon> {
  MethodFirebase method = MethodFirebase();
  Presentertwo? _present;
  TextEditingController controlket = TextEditingController();
  String? select1;
  String? select2;
  final items = [
    'sakit',
    'ijin',
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _present = ref.read(present2);
    });
  }
  @override
  void dispose() {
    super.dispose();
    controlket.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.04, horizontal: size.width * 0.04),
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Whats Up',
                    style: TextStyle(
                        fontSize: size.height * 0.05,
                        fontWeight: FontWeight.w600,
                        color: ColorUse.mainBg),
                  ),
                ],
              ),
            ),
            // Expanded(
            // child: StreamBuilder(
            //   stream: null,
            //   builder: (context, snapshots){
            //     if(snapshots.hasData){
            //       // return ;
            //     }else{
            //       return Center(
            //         child: Text(
            //           'No Attention'
            //         ),
            //       );
            //     }
            // })
            // ),
            Container(
              width: size.width * 0.8,
              height: size.height * 0.14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                    height: size.height * 0.1,
                    child: select1 == 'sakit'
                        ? Lottie.asset('lottie/sickl.json',
                            fit: BoxFit.fitHeight)
                        : Lottie.asset('lottie/nosick.json',
                            fit: BoxFit.fitHeight),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'no attedance',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: select1,
                      onChanged: (String? value) {
                        setState(() {
                          select1 = value;
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
                ],
              ),
            ),
            FormControl(
                colors: ColorUse.colorText,
                widths: size.width * 0.85,
                heights: size.height * 0.1,
                hint: 'keterangan',
                controlit: controlket,
                icon: Icons.not_interested_outlined),
            SizedBox(
              height: size.height * 0.025,
            ),
            ButtonControl(
                widths: size.width * 0.85,
                colorbg: ColorUse.colorBf,
                heights: size.height * 0.08,
                text: 'SEND',
                action: () async {
                  await method
                      .nonAttedance(
                          _present!.formatTime(DateTime.now()),
                          widget.user,
                          _present!.formatDate(DateTime.now()),
                          select1!,
                          controlket.text)
                      .then((val) {
                    Navigator.pop(context);
                  });
                },
                size: size)
          ],
        ),
      ),
    );
  }
}
