import 'package:attedancebeta/admin_page/admin_main_page.dart';
import 'package:attedancebeta/model_db/hive_model.dart';
import 'package:attedancebeta/user_page/user_main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FinalRouted extends StatefulWidget {
  const FinalRouted({super.key});

  @override
  State<FinalRouted> createState() => _FinalRoutedState();
}

class _FinalRoutedState extends State<FinalRouted> {
  User user = FirebaseAuth.instance.currentUser!;
//   var box = Hive.box<Dbmodel>('boxname');
// String fetchin () {
//   modi = box.getAt(0);
//   return modi!.instansiName;
// }
 var box = Hive.box<Dbmodel>('boxname');

// Future<void> fetchin() async {
//     var box = Hive.box<Dbmodel>('boxname');
//     setState(() {
//       modi =  box.getAt(0);
//     });
//     print(box.length);
// }

  @override
  void initState() {
    super.initState();
    // fetchin();
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
            if (snapshot.hasData) {
              final data = snapshot.data!.data();
              if (data!['type'] == 'User') {
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserMainPage()));
                });
              } else {
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminMainPage()));
                });
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center();
          }),
    );
  }
}
