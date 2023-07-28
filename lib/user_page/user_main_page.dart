import 'package:attedancebeta/all_method/method_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model_db/hive_model.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  final _method = MethodFirebase();
  var box = Hive.box<Dbmodel>('boxname');

  void fetchbox() {
    // Dbmodel name = box.get(key)
  }

  User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Dbmodel nameInstansi = box.getAt(0)!;
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('instansi')
              .doc(nameInstansi.instansiName)
              .collection('users')
              .doc(user.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!.data();
              return Center(
                child: InkWell(
                    onTap: () {
                      _method.signout(context);
                      box.clear();
                    },
                    child: Text(data!['username'])),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
