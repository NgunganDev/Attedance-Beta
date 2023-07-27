import 'package:attedancebeta/auth_page/login_page.dart';
import 'package:attedancebeta/auth_page/register_page.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Routed extends ConsumerStatefulWidget {
  const Routed({super.key});

  @override
  ConsumerState<Routed> createState() => _RoutedState();
}

class _RoutedState extends ConsumerState<Routed> {
  // int state = 0;
  Widget routes(int stateit){
    print(stateit);
    switch(stateit){
      case 0:
      return const LoginPage();
      case 1:
      return const RegisterPage();
      default:
      return LoginPage();
    }
  }
  StateManage statemanage = StateManage();
  @override
  Widget build(BuildContext context) {
     final authpage = ref.watch(stateauth);
    return Scaffold(
      body: routes(authpage),
    );
  }
}