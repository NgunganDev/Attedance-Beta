import 'package:attedancebeta/all_method/method_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model_data/model_retrieve.dart';

StateProvider stateauth = StateProvider<int>((ref) => 0);
final stateinst = Provider<MethodFirebase>((ref) => MethodFirebase());

final streamUser = StreamProvider.autoDispose<DocumentSnapshot>((ref) {
  final present = ref.watch(stateinst);
  return present.userData();
});

final streamAttedance = StreamProvider.autoDispose((ref) {
  final present = ref.watch(stateinst);
  return present.userAttedance();
});

final streamModel = StreamProvider.autoDispose<ModelFire>((ref) {
  final present = ref.watch(stateinst);
  return present.dataModel();
});






