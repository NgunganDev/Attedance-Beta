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
import '../format_parse/format.dart';
import '../model_data/model_retrieve.dart';
import '../model_data/model_retrieve_attedance.dart';
import '../model_db/hive_model.dart';

// perlu maintenance
class MethodFirebase extends Format {
  String _users = '';
  String _inputTime = '';
  CollectionReference instansiRef =
      FirebaseFirestore.instance.collection('instansi');

  String get userr {
    return _users;
  }

  set inputUser(String user) {
    _users = user;
  }

  String get inputTime {
    return _inputTime;
  }

  set inputTheTime(String time) {
    _inputTime = time;
  }

  String _uuid = '';

  set uuids(String val) {
    _uuid = val;
  }

  String get uuid {
    return _uuid;
  }

  Future<String> fetchIns() async {
    var box = Hive.box<Dbmodel>('boxname');
    Dbmodel ins = box.getAt(0) ?? Dbmodel(instansiName: 'Instansi 1');
    return ins.instansiName;
  }

  Future<void> addins(String name) async {
    var box = Hive.box<Dbmodel>('boxname');
    await box.add(Dbmodel(instansiName: name));
  }

  Future<void> putins(String name) async {
    var box = Hive.box<Dbmodel>('boxname');
    await box.put(0, Dbmodel(instansiName: name));
  }

  Stream<DocumentSnapshot> userData() async* {
    // print(user);
    final data = instansiRef
        .doc(await fetchIns())
        .collection('users')
        .doc(userr)
        .snapshots();
    yield* data;
  }

  Stream<ModelFire> dataModel() async* {
    final data = instansiRef
        .doc(await fetchIns())
        .collection('users')
        .doc(userr)
        .snapshots()
        .map((event) => ModelFire.fromSnapshot(event));
    yield* data;
  }

  Stream<List<ModelAttedance>> dateAttedance() async* {
    // print(inputTime);
    print(userr);
    Stream<List<ModelAttedance>> data = instansiRef
        .doc(await fetchIns())
        .collection('users')
        .doc(userr)
        .collection('atpers')
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return ModelAttedance.fromSnapshot(e);
      }).toList();
    });

    yield* data;
  }

  Stream<List<ModelAttedance>> todayAttedance(DateTime time) async* {
    final String timeNow = formatDate(time);
    var data = instansiRef
        .doc(await fetchIns())
        .collection('attedance')
        .where('timestamp', isEqualTo: timeNow)
        .snapshots()
        .map((event) {
      print(event);
      return event.docs.map((e) => ModelAttedance.fromSnapshot(e)).toList();
    });

    yield* data;
  }

  Stream<List<ModelAttedance>> allAttedance() async* {
    final data = instansiRef.doc(await fetchIns()).collection('attedance').snapshots().map((event) {
      return event.docs.map((e) => ModelAttedance.fromSnapshot(e)).toList();
    });

    yield* data;
  }

  // Stream<List<ModelAttedance>> adminBarChart() async* {
  //   final timeNow = Timestamp.now();
  //   final startWeek = timeNow.toDate().subtract(Duration(days: timeNow.toDate().weekday - 1));
  //   print(startWeek);
  //   final endWeek = timeNow.toDate().add(Duration(days: 7 - timeNow.toDate().weekday));
  //   var data = instansiRef
  //       .doc(await fetchIns())
  //       .collection('attedance')
  //       .where('realtime', isGreaterThanOrEqualTo: startWeek)
  //       .where('realtime', isLessThan: endWeek)
  //       .snapshots()
  //       .map((event) {
  //     return event.docs.map((e) => ModelAttedance.fromSnapshot(e)).toList();
  //   });

  //   yield* data;
  // }

  ImagePicker imagepicker = ImagePicker();
  Future<void> signUpEmail(String email, String password, String username,
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FinalRouted()));
        await addins(instansi);
      });
    });
  }

  Future<void> signInEmail(String email, String password, BuildContext context,
      String nameInstansi) async {
    // var box = Hive.box<Dbmodel>('boxname');
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FinalRouted()));
      await putins(nameInstansi);
    });
  }

  Future<void> signOut(BuildContext context, WidgetRef ref, Box box) async {
    await FirebaseAuth.instance.signOut().then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Routed())));
    box.clear();
  }

  Future<void> updatePicture(String photoUrl, String ins, String user) async {
    instansiRef
        .doc(await fetchIns())
        .collection('users')
        .doc(user)
        .update({"photoUrl": photoUrl}).then((value) {
      print('success add a picture');
    });
  }

  Future<void> deleteAttend() async {}

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
    await instansiRef.doc(await fetchIns()).collection('attedance').add({
      "checkIn": timestamp,
      "checkout": "",
      "noattendace": '',
      "info": '',
      "user": user,
      "timestamp": day,
      "uuid": uuid,
      "accept": false,
      "realtime": DateTime.now()
    });
    await instansiRef
        .doc(await fetchIns())
        .collection('users')
        .doc(user)
        .collection('atpers')
        .add({
      "checkIn": timestamp,
      "checkout": "",
      "noattendace": '',
      "info": '',
      "user": user,
      "timestamp": day,
      "uuid": uuid,
      "accept": false,
      "realtime": DateTime.now()
    });
  }

  Future<void> updateCheckOut(String user, String day, String timeout) async {
    CollectionReference refdes = instansiRef
        .doc(await fetchIns())
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
        instansiRef.doc(await fetchIns()).collection('attedance');
    QuerySnapshot resAll =
        await refAll.where('timestamp', isEqualTo: day).get();
    for (var docTo in resAll.docs) {
      refAll.doc(docTo.id).update({"checkout": timeout});
    }
  }

  Future<void> acceptData(
      String idAtt, String idUser, bool condition, String uid) async {
    CollectionReference ref = instansiRef
        .doc(await fetchIns())
        .collection('users')
        .doc(idUser)
        .collection('atpers');
    CollectionReference refAll =
        instansiRef.doc(await fetchIns()).collection('attedance');
    await refAll.doc(idAtt).update({
      "accept": condition,
    }).then((value) async {
      QuerySnapshot ups = await ref.where('uuid', isEqualTo: uid).get();
      for (var data in ups.docs) {
        await ref.doc(data.id).update({
          "accept": condition,
        });
      }
    });
  }

  Future<void> nonAttedance(String timestamp, String user, String day,
      String non, String info) async {
    await instansiRef.doc(await fetchIns()).collection('attedance').add({
      "checkIn": timestamp,
      "noattendace": non,
      "info": info,
      "checkout": "",
      "user": user,
      "timestamp": day,
      "uuid": uuid,
      "accept": false,
      "realtime": DateTime.now()
    });
    await instansiRef
        .doc(await fetchIns())
        .collection('users')
        .doc(user)
        .collection('atpers')
        .add({
      "checkIn": timestamp,
      "checkout": "",
      "noattendace": non,
      "info": info,
      "user": user,
      "timestamp": day,
      "uuid": uuid,
      "accept": false,
      "realtime": DateTime.now()
    });
  }

  Future<void> updateBioname(String user, String contentbio) async {
    await instansiRef
        .doc(await fetchIns())
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
        .doc(await fetchIns())
        .collection('users')
        .doc(user)
        .update({
      "username": username,
    }).then((value) {
      print('success update username');
    });
  }
}
