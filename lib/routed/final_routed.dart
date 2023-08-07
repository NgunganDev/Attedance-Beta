import 'package:attedancebeta/admin_page/admin_main_page.dart';
import 'package:attedancebeta/model_db/hive_model.dart';
// import 'package:attedancebeta/routed/routed.dart';
// import 'package:attedancebeta/state/state_manage.dart';
import 'package:attedancebeta/user_page/user_main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../presenter/admin_presenter.dart';

// import '../presenter/auth_presenter.dart';

class FinalRouted extends ConsumerStatefulWidget {
  const FinalRouted({super.key});

  @override
  ConsumerState<FinalRouted> createState() => _FinalRoutedState();
}

class _FinalRoutedState extends ConsumerState<FinalRouted> {
  // Presenterthree? _present;
  PresenterAdmin? _present;
  User user = FirebaseAuth.instance.currentUser!;
  var box = Hive.box<Dbmodel>('boxname');

  @override
  void initState() {
    print(box.length);
    super.initState();
    setState(() {
      _present = ref.read(presenterFour);
      _present!.setUser(user.email!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Dbmodel modi = box.getAt(0)!;
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('instansi')
              .doc(modi.instansiName)
              .collection('users')
              .doc(user.email!)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
            final data = snapshot.data!.data();
            //   if(data!['instansi'] != modi.instansiName){
            //     print('cant login');
            //   }else{
            //     print('able');
            //   }

            //  space
            if ( data!['type'] == 'User' &&
                data['instansi'] == modi.instansiName) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserMainPage()));
              });
            } else if ( data['type'] == 'Admin' &&
                data['instansi'] == modi.instansiName) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminMainPage()));
              });
            } 
            }
            return const Center();
          }),
    );
  }
}
