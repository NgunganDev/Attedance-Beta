import 'dart:io';
import 'package:attedancebeta/routed/final_routed.dart';
import 'package:attedancebeta/routed/routed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../model_db/hive_model.dart';

// perlu maintenance
class MethodFirebase {
  Future<String> fetchins() async {
    var box = Hive.box<Dbmodel>('boxname');
    Dbmodel ins = box.getAt(0) ?? Dbmodel(instansiName: 'Instansi 1');
    return ins.instansiName;
  }

  ImagePicker imagepicker = ImagePicker();
  CollectionReference instansiRef =
      FirebaseFirestore.instance.collection('instansi');
  Future<void> signupemail(String email, String password, String username,
      String instansi, String type, String ins) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      instansiRef.doc(ins).collection('users').doc(email).set({
        "username": username,
        "type": type,
        "instansi": instansi,
        "bio": "",
        "photoUrl": "",
      }).then((value) {
        print('success created an user');
      });
    });
  }

  Future<void> signinemail(
      String email, String password, BuildContext context) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FinalRouted()));
    });
  }

  Future<void> signout(BuildContext context, WidgetRef ref, Box box) async {
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Routed()));
      // ref.read(stateauth.notifier).update((state) => 1);
    });
    box.clear();
  }

  Future<void> updatePicture(String photoUrl, String ins, String user) async {
    instansiRef
        .doc(ins)
        .collection('users')
        .doc(user)
        .update({"photoUrl": photoUrl}).then((value) {
      print('success add a picture');
    });
  }

  Future<String> pickImg(String ins, String user) async {
    String imgUrl = '';
    XFile? file;
    try {
      file = await imagepicker.pickImage(source: ImageSource.gallery);
      // print('${file?.path}');
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('Profile Photos');
      Reference referenceImageToUpload = referenceDirImages.child(user);
      // Reference nameDir = referenceImageToUpload.
      await referenceImageToUpload.putFile(File(file!.path));
      imgUrl = await referenceImageToUpload.getDownloadURL();
      await updatePicture(imgUrl, ins, user);
      return imgUrl;
      // if (file == null) return;
    } catch (e) {
      return 'https://cdn.stealthoptional.com/images/ncavvykf/stealth/f60441357c6c210401a1285553f0dcecc4c4489e-564x564.jpg?w=328&h=328&auto=format';
    }
  }

  Future<void> addCheckIn(String user, String timestamp, String day) async {
    await instansiRef.doc(await fetchins()).collection('attedance').add(
        {"checkIn": timestamp, "checkout": "", "user": user, "timestamp": day});
    await instansiRef
        .doc(await fetchins())
        .collection('users')
        .doc(user)
        .collection('atpers')
        .add({
      "checkIn": timestamp,
      "checkout": "",
      "noattendace": '',
      "info": '',
      "user": user,
      "timestamp": day
    });
  }

  Future<void> updatecheckout() async {}

  Future<void> addNon(String timestamp, String user, String day, String non,
      String info) async {
    await instansiRef.doc(await fetchins()).collection('attedance').add({
      "checkIn": timestamp,
      "noattendace": non,
      "info": info,
      "checkout": "",
      "user": user,
      "timestamp": day
    });
    await instansiRef
        .doc(await fetchins())
        .collection('users')
        .doc(user)
        .collection('atpers')
        .add({
      "checkIn": timestamp,
      "checkout": "",
      "noattendace": non,
      "info": info,
      "user": user,
      "timestamp": day
    });
  }
}
