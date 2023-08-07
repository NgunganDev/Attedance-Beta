import 'package:attedancebeta/all_method/method_firebase.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final present = Provider((ref) => Presenterone(method: ref.read(stateinst)));

class Presenterone {
  final MethodFirebase method;
  Presenterone({required this.method});

  Future<void> updateUname(String user, String newUsername) async {
    await method.updateUsername(user, newUsername);
  }

  Future<void> updateBio(String user, String newBio) async {
    await method.updateBioname(user, newBio);
  }

  Future<void> updatePic(String ins, String user) async {
    await method.pickImg(ins, user);
  }

  Future<String> insName() async {
    String name =await method.fetchIns();
    return name;
  }

  String get user {
    return method.userr;
  }

 }
