import 'package:cloud_firestore/cloud_firestore.dart';

class ModelAttedance {
  final String checkIn;
  final String checkOut;
  final String noAttedance;
  final String info;
  final String timeStamp;
  final String user;
  final String uuid;
  final bool accept;
  final String dataId;
  final Timestamp realtime;

  ModelAttedance(
      {required this.checkIn,
      required this.checkOut,
      required this.info,
      required this.noAttedance,
      required this.timeStamp,
      required this.user,
      required this.uuid,
      required this.accept,
      required this.dataId,
      required this.realtime,
      });

  factory ModelAttedance.fromSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    return ModelAttedance(
        checkIn: data['checkIn'] ?? 'no data',
        checkOut: data['checkout'],
        info: data['info'],
        noAttedance: data['noattendace'] ?? "no data",
        user: data['user'] ?? "no data",
        timeStamp: data['timestamp'] ?? "nodata",
        uuid: data['uuid'],
        accept: data['accept'],
        dataId: snap.id,
        realtime: data['realtime']
        );

  }
}
