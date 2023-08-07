import 'package:attedancebeta/all_method/method_firebase.dart';
import 'package:attedancebeta/popup/show.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final presenterFour = Provider<PresenterAdmin>((ref) => PresenterAdmin(method: ref.read(stateinst)));
class PresenterAdmin extends ShowPop{
  final MethodFirebase method;
  PresenterAdmin({required this.method});

  String _timeIs = '';
  String userNow(){
    return method.userr;
  }

  void setUser(String value){
    method.inputUser = value;
  }

  Future<void> updateAccept(String userId, String id, bool condition, String uid) async {
    await method.acceptData(userId, id, condition, uid);
  }
  set theTime(String value){
    _timeIs = value;
  }
String get timeOn{
  return _timeIs;
}
  Future<String> calendarCall(context, WidgetRef ref) async {
    return await caleresString(context, ref);
  }

}