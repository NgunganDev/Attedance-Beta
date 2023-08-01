import 'package:flutter/material.dart';

import '../format_parse/format.dart';

class ShowPop {
  String caleresString(BuildContext context)  {
    String pickedDate = '';
     showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: (DateTime.now()).add(const Duration(days: 7)))
        .then((value) {
      pickedDate = Format().formatDate(value!);
      print(pickedDate);
    });
    return pickedDate;
  }
}
