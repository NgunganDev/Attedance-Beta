import 'package:attedancebeta/color/color_const.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:attedancebeta/widget_admin/attedance_admin.dart';
import 'package:attedancebeta/widget_user/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
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
    final watchAdmin = ref.watch(streamModel);
    final watchToday = ref.watch(streamTodayAtt);
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
                        Text(
                          'see all',
                          style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Expanded(
                        child: watchToday.when(data: (datas) {
                      return AnimationLimiter(
                        child: ListView.builder(
                          itemCount: datas.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                    child: datas[index].noAttedance == ''
                                        ? AttedanceCardAdmin(
                                            action: () async {
                                              await _present!.updateAccept(
                                                  datas[index].dataId,
                                                  datas[index].user,
                                                  true,
                                                  datas[index].uuid);
                                            },
                                            checkout: datas[index].checkOut,
                                            asset:
                                                Image.asset('images/att.png'),
                                            checkin: datas[index].checkIn,
                                            accept: datas[index].accept,
                                            time: datas[index].timeStamp)
                                        : AttedanceCardAdmin(
                                            action: () async {
                                              await _present!.updateAccept(
                                                  datas[index].dataId,                                                
                                                  datas[index].user,
                                                  true,
                                                  datas[index].uuid);
                                            },
                                            checkout: datas[index].noAttedance,
                                            asset: Lottie.asset(
                                                'lottie/nosick.json'),
                                            checkin: datas[index].checkIn,
                                            accept: datas[index].accept,
                                            time: datas[index].timeStamp)),
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
                    })),
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
