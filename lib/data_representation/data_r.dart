import '../model_data/model_retrieve_attedance.dart';

class Representation {
  final List<ModelAttedance> listOf;
  Representation({required this.listOf});

  List<ModelAttedance> mondayData() {
    return listOf.where((element) {
      return element.realtime.toDate().weekday == 2;
    }).toList();
  }

  List<ModelAttedance> tueData() {
    return listOf.where((element) {
      return element.realtime.toDate().weekday == 3;
    }).toList();
  }

  List<ModelAttedance> wedData() {
    return listOf.where((element) {
      return element.realtime.toDate().weekday == 4;
    }).toList();
  }

  List<ModelAttedance> thuData() {
    return listOf.where((element) {
      return element.realtime.toDate().weekday == 5;
    }).toList();
  }

  List<ModelAttedance> friData() {
    return listOf.where((element) {
      return element.realtime.toDate().weekday == 6;
    }).toList();
  }

  List<ModelAttedance> satData() {
    return listOf.where((element) {
      return element.realtime.toDate().weekday == 7;
    }).toList();
  }

  List<ModelAttedance> sunData() {
    return listOf.where((element) {
      return element.realtime.toDate().weekday == 8;
    }).toList();
  }
}
