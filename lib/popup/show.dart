import 'package:attedancebeta/color/color_const.dart';
import 'package:attedancebeta/widget_control/button_control.dart';
import 'package:attedancebeta/widget_control/form_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../format_parse/format.dart';
import '../state/state_manage.dart';

class ShowPop extends Format{
  Future<String> caleresString(BuildContext context, WidgetRef ref) async {
    String pickedDate = '';
   await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: (DateTime.now()).add(const Duration(days: 7)))
        .then((value) {
           ref.read(stateTime.notifier).state = value;
      pickedDate = formatDate(value!);
    });
    return pickedDate;
  }

  void showUp(BuildContext context, VoidCallback action, String title,
      TextEditingController controlit, String label) {
    final size = MediaQuery.sizeOf(context);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Container(
                width: size.width,
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.height * 0.04)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label),
                    FormControl(
                        colors: ColorUse.colorText,
                        widths: size.width * 0.8,
                        heights: size.height * 0.08,
                        hint: 'update bio',
                        controlit: controlit,
                        icon: Icons.edit)
                  ],
                ),
              ),
            ),
            actions: [
              ButtonControl(
                  widths: size.width * 0.3,
                  colorbg: ColorUse.colorBf,
                  heights: size.height * 0.06,
                  text: 'cancel',
                  action: () {
                    Navigator.pop(context);
                  },
                  size: size),
              ButtonControl(
                  widths: size.width * 0.3,
                  colorbg: ColorUse.colorBf,
                  heights: size.height * 0.06,
                  text: 'update',
                  action: action,
                  size: size)
            ],
          );
        });
  }
}
