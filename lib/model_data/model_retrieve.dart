import 'package:cloud_firestore/cloud_firestore.dart';

class ModelFire {
  final String userName;
  final String bio;
  final String photoUrl;

  ModelFire({
    required this.userName,
    required this.bio,
    required this.photoUrl
  });

  factory ModelFire.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ModelFire(
      userName: data['username'],
      photoUrl: data['photoUrl'],
      bio: data['bio']
    );
  }
}