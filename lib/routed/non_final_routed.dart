import 'package:attedancebeta/admin_page/admin_main_page.dart';
import 'package:attedancebeta/presenter/auth_presenter.dart';
// import 'package:attedancebeta/routed/routed.dart';
import 'package:attedancebeta/user_page/user_main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class NonFinalRouted extends ConsumerStatefulWidget {
  final Box box;
  final String email;
  final String inst;
  const NonFinalRouted({super.key, required this.email, required this.inst, required this.box});

  @override
  ConsumerState<NonFinalRouted> createState() => _NonFinalRoutedState();
}

class _NonFinalRoutedState extends ConsumerState<NonFinalRouted> {
  Presenterthree? _present;
  @override
  void initState() {
    super.initState();
    _present = ref.read(presentre);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('instansi').doc(widget.inst).collection('users').doc(widget.email).snapshots(),
        builder: (ctx, snapshot){
          if(snapshot.hasData){
            final data = snapshot.data!.data();
            if(data!['instansi'] == widget.inst && data['type'] == 'User'){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UserMainPage()));
            }else if(data['instansi'] == widget.inst && data['type'] == 'Admin'){
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminMainPage()));
            }
          }
          return const Center();
        }),
    );
  }
}