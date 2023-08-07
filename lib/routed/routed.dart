// import 'package:attedancebeta/auth_page/login_page.dart';
// import 'package:attedancebeta/auth_page/register_page.dart';
// import 'package:attedancebeta/auth_page/login_page.dart';
// import 'package:attedancebeta/state/state_manage.dart';
import 'package:attedancebeta/auth_page/login2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../auth_page/register_page.dart';
import '../model_db/hive_model.dart';
import '../state/state_manage.dart';

class Routed extends ConsumerStatefulWidget {
  const Routed({super.key});

  @override
  ConsumerState<Routed> createState() => _RoutedState();
}

class _RoutedState extends ConsumerState<Routed> {
  var box = Hive.box<Dbmodel>('boxname');
  Widget routes(int stateit){
    // print('ohh');
    print(box.length);
    switch(stateit){
      case 0:
      return const LoginDendam();
      case 1:
      return const RegisterPage();
      default:
      return const RegisterPage();
    }
  }
  @override
  Widget build(BuildContext context) {
     final authpage = ref.watch(stateauth);
    return Scaffold(
      body: routes(authpage),
    );
  }
}