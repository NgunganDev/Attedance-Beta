import 'package:attedancebeta/all_method/method_firebase.dart';
import 'package:attedancebeta/popup/show.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_representation/data_r.dart';
import '../model_data/model_retrieve_attedance.dart';

final presenterFour = Provider<PresenterAdmin>((ref) =>
    PresenterAdmin(method: ref.read(stateinst), dataR: ref.read(dataRes)));

class PresenterAdmin extends ShowPop {
  final MethodFirebase method;
  final Representation dataR;
  PresenterAdmin({required this.method, required this.dataR});

  String _timeIs = '';
  String userNow() {
    return method.userr;
  }

  void setUser(String value) {
    method.inputUser = value;
  }

  Future<void> updateAccept(
      String userId, String id, bool condition, String uid) async {
    await method.acceptData(userId, id, condition, uid);
  }

  set theTime(String value) {
    _timeIs = value;
  }

  String get timeOn {
    return _timeIs;
  }

  Future<String> calendarCall(context, WidgetRef ref) async {
    return await caleresString(context, ref);
  }

  void setList(List<ModelAttedance> val) {
    dataR.listTo = val;
  }

  List<ModelAttedance> get listThe {
    return dataR.listOf;
  }

  List<Weekday> dayOfWweek = [
    Weekday.monday,
    Weekday.tuesday,
    Weekday.wednesday,
    Weekday.thursday,
    Weekday.friday,
    Weekday.saturday,
    Weekday.sunday
  ];

  List<List<ModelAttedance>> get refatorList {
    List<List<ModelAttedance>> res = [];
    for (var i = 0; i < 7; i++) {
      res.add(dataR.dayData(dayOfWweek[i]));
    }
    return res;
  }

  List<List<ModelAttedance>> get refactorData {
    List<List<ModelAttedance>> res2 = [];
    for (var i = 0; i < 7; i++) {
      res2.add(dataR.dataAttedance(dayOfWweek[i]));
    }
    return res2;
  }

   List<List<ModelAttedance>> get refactorNon {
    List<List<ModelAttedance>> res3 = [];
    for (var i = 0; i < 7; i++) {
      res3.add(dataR.dataNon(dayOfWweek[i]));
    }
    print(res3);
    return res3;
  }

  final chartDrop = ['kehadiran', 'tidak hadir'];
}
