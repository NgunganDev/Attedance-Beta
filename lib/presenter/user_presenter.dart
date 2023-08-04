import 'package:attedancebeta/all_method/method_firebase.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final present2 = Provider((ref) => Presentertwo(method: ref.read(stateinst)));

class Presentertwo {
  final MethodFirebase method;
  Presentertwo({required this.method});

  Future<void> addcheckin(String user, String timestamp, String day) async {
    await method.addCheckIn(user, timestamp, day);
  }

  Future<void> addcheckout(String user, String day, String timeout) async {
    await method.updateCheckOut(user, day, timeout);
  }
}
