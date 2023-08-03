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
  CollectionReference instansiRef =
      FirebaseFirestore.instance.collection('instansi');

  Future<String> fetchins() async {
    var box = Hive.box<Dbmodel>('boxname');
    Dbmodel ins = box.getAt(0) ?? Dbmodel(instansiName: 'Instansi 1');
    return ins.instansiName;
  }

  Future<void> addins(String name) async {
    var box = Hive.box<Dbmodel>('boxname');
    await box.add(Dbmodel(instansiName: name));
  }

  Future<void> putins() async {

  }


  ImagePicker imagepicker = ImagePicker();
  Future<void> signupemail(String email, String password, String username,
      String instansi, String type, BuildContext context) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      instansiRef.doc(instansi).collection('users').doc(email).set({
        "username": username,
        "type": type,
        "instansi": instansi,
        "bio": "",
        "photoUrl": "",
      }).then((value) async {
       Navigator.push(context, MaterialPageRoute(builder: (context) => const FinalRouted() ));
        await addins(instansi);
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
        .doc(await fetchins())
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

  Future<void> updatecheckout(String user, String day, String timeout) async {
    CollectionReference refdes = instansiRef
        .doc(await fetchins())
        .collection('users')
        .doc(user)
        .collection('atpers');
    QuerySnapshot refAtpers =
        await refdes.where('timestamp', isEqualTo: day).get();
    for (var docdes in refAtpers.docs) {
      var upItem = docdes.id;
      await refdes.doc(upItem).update({
        "checkout": timeout,
      }).then((value) {
        print('success update checkout ');
      });
    }

    CollectionReference refAll =
        instansiRef.doc(await fetchins()).collection('attedance');
    QuerySnapshot resAll =
        await refAll.where('timestamp', isEqualTo: day).get();
    for (var docTo in resAll.docs) {
      refAll.doc(docTo.id).update({"checkout": timeout});
    }
  }

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

  Future<void> updateBioname(String user, String contentbio) async {
    await instansiRef
        .doc(await fetchins())
        .collection('users')
        .doc(user)
        .update({
      "bio": contentbio,
    }).then((value) {
      print('succes update bio');
    });
  }

  Future<void> updateUsername(String user, String username) async {
    await instansiRef
        .doc(await fetchins())
        .collection('users')
        .doc(user)
        .update({
          "username": username,
        }).then((value) {
          print('success update username');
        });
  }
}
