import 'package:attedancebeta/all_method/method_firebase.dart';
import 'package:attedancebeta/data_representation/data_r.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model_data/model_retrieve.dart';
import '../model_data/model_retrieve_attedance.dart';

StateProvider stateauth = StateProvider<int>((ref) => 0);
StateProvider stateTime = StateProvider<DateTime>((ref) => DateTime.now());
StateProvider stateBarChart = StateProvider<String>((ref) => 'kehadiran');
final stateinst = Provider<MethodFirebase>((ref) => MethodFirebase());
final dataRes = Provider<Representation>((ref) => Representation());

final streamUser = StreamProvider.autoDispose<DocumentSnapshot>((ref) {
  final present = ref.watch(stateinst);
  return present.userData();
});

final streamModel = StreamProvider.autoDispose<ModelFire>((ref) {
  final present = ref.watch(stateinst);
  return present.dataModel();
});

final streamModelAtt = StreamProvider.autoDispose<List<ModelAttedance>>((ref) {
  final present = ref.watch(stateinst);
  return present.dateAttedance();
});

final streamTodayAtt = StreamProvider.autoDispose((ref) {
  final time = ref.watch(stateTime);
  final present = ref.watch(stateinst);
  return present.todayAttedance(time);
});

final streamallAttedance = StreamProvider.autoDispose<List<ModelAttedance>>((ref) {
  final present = ref.watch(stateinst);
  return present.allAttedance();
});

// final streamBarAtedance = StreamProvider.autoDispose((ref) {
//   final present = ref.watch(stateinst);
//   return present.adminBarChart();
// });
