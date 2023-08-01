import 'package:attedancebeta/all_method/method_firebase.dart';
import 'package:attedancebeta/color/color_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model_db/hive_model.dart';

class UserProfile extends StatefulWidget {
  final VoidCallback action;
  const UserProfile({super.key, required this.action});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User user = FirebaseAuth.instance.currentUser!;
  var box = Hive.box<Dbmodel>('boxname');
  String imgUrle = '';
  @override
  Widget build(BuildContext context) {
  MethodFirebase method = MethodFirebase();
    Dbmodel instansi = box.getAt(0)!;
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        color: ColorUse.colorAf,
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            Container(
              width: size.width * 0.8,
              height: size.height * 0.2,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('instansi')
                      .doc(instansi.instansiName)
                      .collection('users')
                      .doc(user.email!)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      final data = snapshot.data!.data();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        InkWell(
                          onTap: () async {
                            setState(() async {
                              imgUrle = await method.pickImg(instansi.instansiName,user.email!);
                              await method.updatePicture(imgUrle, instansi.instansiName, user.email!);
                            });
                          },
                          child: CircleAvatar(
                            radius: size.height * 0.05,
                            backgroundImage: NetworkImage(data!['photoUrl']),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.width * 0.08,
                            ),
                            Text(
                              data['username'],
                              style: TextStyle(
                                  fontSize: size.height * 0.035,
                                  fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                                onPressed: () async {},
                                icon: const Icon(Icons.mode_edit_sharp))
                          ],
                        ),
                      ],
                    );
                    }else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
              width: size.width * 0.8,
              height: size.height * 0.15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Your Bio', style: TextStyle(
                    fontSize: size.height * 0.03,
                    fontWeight: FontWeight.w400
                  ),),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Hahaha'),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
