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
  Future<void> signin(
      String email, String password, BuildContext context) async {
    await method.signinemail(email, password, context);
  }

  Future<void> signup(String email, String password, String username,
      String instansi, String type, BuildContext context) async {
    await method.signupemail(email, password, username, instansi, type, context);
  }

  Future<void> logout(BuildContext context, WidgetRef ref, Box box) async {
    await method.signout(context, ref, box);
  }
}
