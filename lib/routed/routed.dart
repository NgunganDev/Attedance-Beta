import 'package:attedancebeta/auth_page/login_page.dart';
import 'package:flutter/material.dart';

class Routed extends StatefulWidget {
  const Routed({super.key});

  @override
  State<Routed> createState() => _RoutedState();
}

class _RoutedState extends State<Routed> {
  int state = 0;
  Widget routes(){
    switch(state){
      case 0:
      return LoginPage();
      default:
      return LoginPage();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: routes(),
    );
  }
}