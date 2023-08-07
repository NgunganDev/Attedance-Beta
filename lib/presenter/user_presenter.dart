import 'package:attedancebeta/all_method/method_firebase.dart';
import 'package:attedancebeta/format_parse/format.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final present2 = Provider((ref) => Presentertwo(method: ref.read(stateinst)));

class Presentertwo extends Format{
  final MethodFirebase method;
  Presentertwo({required this.method});

  Future<void> addCheckin(String user, String timestamp, String day) async {
    await method.addCheckIn(user, timestamp, day);
  }

  Future<void> addCheckout(String user, String day, String timeout) async {
    print('ch');
    await method.updateCheckOut(user, day, timeout);
  }

  void userNow(String name){
    print(name);
    method.inputUser = name;
  }

  void timeDay(String time){
    print(time);
    method.inputTheTime = time;
  }

  void uUid(){
    method.uuids = uuidFormat();
  }
}
