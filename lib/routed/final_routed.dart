import 'package:attedancebeta/admin_page/admin_main_page.dart';
import 'package:attedancebeta/model_db/hive_model.dart';
import 'package:attedancebeta/user_page/user_main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FinalRouted extends ConsumerStatefulWidget {
  const FinalRouted({super.key});

  @override
  ConsumerState<FinalRouted> createState() => _FinalRoutedState();
}

class _FinalRoutedState extends ConsumerState<FinalRouted> {
  User user = FirebaseAuth.instance.currentUser!;

 var box = Hive.box<Dbmodel>('boxname');
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
