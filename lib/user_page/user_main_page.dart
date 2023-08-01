import 'package:attedancebeta/color/color_const.dart';
import 'package:attedancebeta/drawer_user/drawer_head_user.dart';
import 'package:attedancebeta/drawer_user/drawer_menu.dart';
import 'package:attedancebeta/popup/show.dart';
import 'package:attedancebeta/profile/user_profile.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:attedancebeta/widget_user/attedance_card.dart';
import 'package:attedancebeta/widget_user/user_button.dart';
import 'package:attedancebeta/widget_user/user_card.dart';
import 'package:attedancebeta/widget_user/user_choose.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../all_method/method_firebase.dart';
import '../format_parse/format.dart';
import '../model_db/hive_model.dart';

class UserMainPage extends ConsumerStatefulWidget {
  const UserMainPage({super.key});

  @override
  ConsumerState<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends ConsumerState<UserMainPage> {
  String names = '';
  var box = Hive.box<Dbmodel>('boxname');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool picked1 = false;
  bool picked2 = false;
  Format format = Format();
  ShowPop show = ShowPop();
  User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MethodFirebase method = MethodFirebase();
    final size = MediaQuery.sizeOf(context);
    Dbmodel nameInstansi = box.getAt(0)!;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: size.width,
        height: size.height,
        color: ColorUse.mainBg,
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.05,
              child: SizedBox(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.07,
                        width: size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.notifications_active_sharp,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('instansi')
                              .doc(nameInstansi.instansiName)
                              .collection('users')
                              .doc(user.email)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data!.data();
                              return UserCard(
                                heights: size.height * 0.2,
                                widths: size.width * 0.8,
                                name: data!['username'],
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ],
                  )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.65,
                  decoration: const BoxDecoration(
                      color: ColorUse.colorAf,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.white),
                        width: size.width * 0.8,
                        height: size.height * 0.15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            UserChocard(
                              widths: size.width * 0.2,
                              heights: size.height * 0.1,
                              itemName: 'Today',
                              icon: Icons.calendar_today_sharp,
                              action: () async {
                                setState(() {
                                  picked1 = !picked1;
                                });
                                await show.caleresString(context);
                                picked1 = !picked1;
                              },
                              picked: picked1,
                            ),
                            UserChocard(
                                widths: size.width * 0.2,
                                heights: size.height * 0.1,
                                itemName: 'History',
                                icon: Icons.history_edu_sharp,
                                action: () {
                                  setState(() {
                                    picked2 = !picked2;
                                  });
                                  // checksame();
                                },
                                picked: picked2),
                            UserChocard(
                                widths: size.width * 0.2,
                                heights: size.height * 0.1,
                                itemName: 'Absent',
                                icon: Icons.no_accounts_sharp,
                                action: () {
                                  setState(() {
                                    picked2 = !picked2;
                                  });
                                  // checksame();
                                },
                                picked: picked2)
                          ],
                        ),
                      ),
                      Expanded(
                          child: PageView(children: [
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('instansi')
                                .doc(nameInstansi.instansiName)
                                .collection('users')
                                .doc(user.email!)
                                .collection('atpers')
                                .where('timestamp',
                                    isEqualTo:
                                        format.formatDate(DateTime.now()))
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final data = snapshot.data!.docs;
                                return ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (_, index) {
                                      return ListTile(
                                        title: Text(data[index]['checkIn']),
                                      );
                                    });
                              } else {
                                return Center(
                                  child: Text('no data'),
                                );
                              }
                            }),
                      ])),
                      Container(
                        height: size.height * 0.1,
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            UserButton(
                                name: 'checkin',
                                ic: Icons.input_outlined,
                                width: size.width * 0.4,
                                height: size.height * 0.065,
                                action: () async {
                                  await method.addCheckIn(
                                      user.email!,
                                      format.formatTime(DateTime.now()),
                                      format.formatDate(DateTime.now()));
                                },
                                colo: ColorUse.colorBf),
                            UserButton(
                                name: 'checkout',
                                ic: Icons.output_outlined,
                                width: size.width * 0.4,
                                height: size.height * 0.065,
                                action: () {},
                                colo: ColorUse.colorBf),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('instansi')
                    .doc(nameInstansi.instansiName)
                    .collection('users')
                    .doc(user.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!.data();
                    return DrawerHeadUser(
                      Url: data!['photoUrl'],
                      name: user.email!,
                      action: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfile(
                                      action: () {},
                                    )));
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            const DrawerMenu(
              icon: Icons.note_add_outlined,
              name: 'Notes',
              icColor: Colors.blueAccent,
            ),
            const DrawerMenu(
              icon: Icons.attach_money_outlined,
              name: 'Budget',
              icColor: Colors.green,
            ),
            InkWell(
                onTap: () async {
                  await method.signout(context, ref, box);
                  ref.read(stateauth.notifier).update((state) => 1);
                },
                child: const DrawerMenu(
                  icon: Icons.login_outlined,
                  name: 'Logout',
                  icColor: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}
