import 'package:attedancebeta/color/color_const.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:attedancebeta/widget_admin/attedance_admin.dart';
import 'package:attedancebeta/widget_admin/mini_button.dart';
import 'package:attedancebeta/widget_user/user_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import '../model_data/model_retrieve_attedance.dart';
import '../model_db/hive_model.dart';
import '../presenter/admin_presenter.dart';
import '../presenter/auth_presenter.dart';

class AdminMainPage extends ConsumerStatefulWidget {
  const AdminMainPage({super.key});

  @override
  ConsumerState<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends ConsumerState<AdminMainPage> {
  PresenterAdmin? _present;
  Presenterthree? _pres;
  var box = Hive.box<Dbmodel>('boxname');
  int pageIndex = 0;
  PageController controlPage = PageController();
  bool checkPage(int thePage) {
    if (thePage == pageIndex) {
      return true;
    } else {
      return false;
    }
  }
  List<ModelAttedance> _privList = [];

  @override
  void initState() {
    setState(() {
      _present = ref.read(presenterFour);
      _pres = ref.read(presentre);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final watchTime = ref.watch(stateTime);
    final watchAdmin = ref.watch(streamModel);
    final watchToday = ref.watch(streamTodayAtt);
    final watchChart = ref.watch(streamBarAtedance);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.height * 0.03),
              topRight: Radius.circular(size.height * 0.03)),
          color: ColorUse.mainBg,
        ),
        width: size.width,
        height: size.height,
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    // vertical: size.height * 0.02,
                    horizontal: size.width * 0.04),
                width: size.width,
                height: size.height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await _pres!.logOut(context, ref, box);
                            },
                            icon: const Icon(
                              Icons.menu_outlined,
                              color: ColorUse.colorAf,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.notifications,
                                color: ColorUse.colorAf)),
                      ],
                    ),
                    watchAdmin.when(data: (datas) {
                      return UserCard(
                          heights: size.height * 0.2,
                          widths: size.width * 0.9,
                          name: datas.userName,
                          image: datas.photoUrl);
                    }, error: (e, r) {
                      print(e);
                      return Text(e.toString());
                    }, loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.03),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.height * 0.03),
                      topRight: Radius.circular(size.height * 0.03)),
                  color: ColorUse.colorAf,
                ),
                width: size.width,
                height: size.height * 0.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Today Attedance',
                          style: TextStyle(
                              fontSize: size.height * 0.024,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () async {
                            print(watchTime);
                            _present!.theTime =
                                await _present!.calendarCall(context, ref);
                          },
                          child: Text(
                            'see all',
                            style: TextStyle(
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              controlPage.jumpToPage(0);
                            },
                            child: MiniButton(
                                name: 'Today', condition: checkPage(0))),
                        InkWell(
                            onTap: () {
                              final timeNow = Timestamp.now();
                              final startWeek = timeNow.toDate().subtract(
                                  Duration(days: timeNow.toDate().weekday - 1));
                              final endWeek = timeNow.toDate().add(
                                  Duration(days: 7 - timeNow.toDate().weekday));
                                  // print(startWeek);
                              controlPage.jumpToPage(1);
                            },
                            child: MiniButton(
                                name: 'Graphic', condition: checkPage(1))),
                        MiniButton(name: 'Top', condition: checkPage(2)),
                        MiniButton(name: 'Activation', condition: checkPage(3)),
                      ],
                    ),
                    Expanded(
                      child: PageView(
                          controller: controlPage,
                          onPageChanged: (val) {
                            setState(() {
                              pageIndex = val;
                            });
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            watchToday.when(data: (datas) {
                              return AnimationLimiter(
                                child: ListView.builder(
                                  itemCount: datas.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                            child: datas[index].noAttedance ==
                                                    ''
                                                ? AttedanceCardAdmin(
                                                    action: () async {
                                                      await _present!
                                                          .updateAccept(
                                                              datas[index]
                                                                  .dataId,
                                                              datas[index].user,
                                                              true,
                                                              datas[index]
                                                                  .uuid);
                                                    },
                                                    checkout:
                                                        datas[index].checkOut,
                                                    asset: Image.asset(
                                                        'images/att.png'),
                                                    checkin:
                                                        datas[index].checkIn,
                                                    accept: datas[index].accept,
                                                    time:
                                                        datas[index].timeStamp)
                                                : AttedanceCardAdmin(
                                                    action: () async {
                                                      await _present!
                                                          .updateAccept(
                                                              datas[index]
                                                                  .dataId,
                                                              datas[index].user,
                                                              true,
                                                              datas[index]
                                                                  .uuid);
                                                    },
                                                    checkout: datas[index]
                                                        .noAttedance,
                                                    asset: Lottie.asset(
                                                        'lottie/nosick.json'),
                                                    checkin:
                                                        datas[index].checkIn,
                                                    accept: datas[index].accept,
                                                    time: datas[index]
                                                        .timeStamp)),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }, error: (e, r) {
                              return Text(e.toString());
                            }, loading: () {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                            watchToday.when(data: (data){
                                final timeNow = Timestamp.now();
                              final startWeek = timeNow.toDate().subtract(
                                  Duration(days: timeNow.toDate().weekday - 2));
                              final endWeek = timeNow.toDate().add(
                                  Duration(days: 7 - timeNow.toDate().weekday));
                                  print(startWeek);
                                  print(endWeek);
                                  _privList = 
                                  data.where((elem){
                                    print(elem.realtime.toDate());
                                    // return elem.noAttedance == '';
                                    return elem.realtime.toDate().isAfter(startWeek) || elem.realtime.toDate().isBefore(endWeek);
                                  } ).toList();
                                  print(_privList.length);
                              return ListView.builder(
                                itemCount: _privList.length,
                                itemBuilder: (_, index){
                                  return Text(_privList[index].user);
                              });
                            }, error: (e,r){
                              return Text(e.toString());
                            }, loading: (){
                              return const Center(child: CircularProgressIndicator());
                            })                            
                            // watchChart.when(data: (data) {
                            //   print('${data.length} item');
                            //   return AnimationLimiter(
                            //     child: ListView.builder(
                            //       itemCount: data.length,
                            //       itemBuilder:
                            //           (BuildContext context, int index) {
                            //         return AnimationConfiguration.staggeredList(
                            //           position: index,
                            //           duration:
                            //               const Duration(milliseconds: 375),
                            //           child: SlideAnimation(
                            //             verticalOffset: 50.0,
                            //             child: FadeInAnimation(
                            //                 child: Text(data[index].user)),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //   );
                            // }, error: (e, r) {
                            //   return Text(e.toString());
                            // }, loading: () {
                            //   return const Center(
                            //     child: CircularProgressIndicator(),
                            //   );
                            // })
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
