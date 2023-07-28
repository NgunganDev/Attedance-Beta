import 'package:attedancebeta/model_db/hive_model.dart';
import 'package:attedancebeta/routed/final_routed.dart';
import 'package:attedancebeta/routed/routed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MethodFirebase {
  // CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
  CollectionReference instansiRef =
      FirebaseFirestore.instance.collection('instansi');
  Future<void> signupemail(String email, String password, String username,
      String instansi, String type) async {
    var box = Hive.box<Dbmodel>('boxname');
    Dbmodel iname = box.getAt(0)!;
    print(iname);
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      instansiRef
          .doc(iname.instansiName)
          .collection('users')
          .doc(email)
          .set({
            "username": username,
            "type": type,
            "instansi": instansi
          }).then((value) {
        print('success created an user');
      });
    });
  }

  Future<void> signinemail(String email, String password, BuildContext context) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const FinalRouted()));
    });
  }

  Future<void> signout(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Routed()));
    });
  }
}
