import 'package:attedancebeta/all_method/method_firebase.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final presentre =
    Provider((ref) => Presenterthree(method: ref.read(stateinst)));

class Presenterthree {
  final MethodFirebase method;
  Presenterthree({required this.method});
  Future<void> signIn(
      String email, String password, BuildContext context, String nameInstansi) async {
    await method.signInEmail(email, password, context, nameInstansi);
  }

  Future<void> signUp(String email, String password, String username,
      String instansi, String type, BuildContext context) async {
    await method.signUpEmail(email, password, username, instansi, type, context);
  }

  Future<void> logOut(BuildContext context, WidgetRef ref, Box box) async {
    await method.signOut(context, ref, box);
  }

  String userIn(){
    return method.userr;
  }
}
