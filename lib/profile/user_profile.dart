import 'package:attedancebeta/color/color_const.dart';
import 'package:attedancebeta/popup/show.dart';
import 'package:attedancebeta/state/state_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../model_db/hive_model.dart';
import '../presenter/profile_presenter.dart';

// presenter page => presenterone

class UserProfile extends ConsumerStatefulWidget {
  final VoidCallback action;
  const UserProfile({super.key, required this.action});

  @override
  ConsumerState<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  TextEditingController updatebio = TextEditingController();
  TextEditingController updateUsername = TextEditingController();
  Presenterone? _present;
  var box = Hive.box<Dbmodel>('boxname');
  ShowPop showit = ShowPop();
  String imgUrle = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      _present = ref.read(present);
    });
  }

  @override
  void dispose() {
    super.dispose();
    updatebio.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final watchUser = ref.watch(streamUser);
    final watchModel = ref.watch(streamModel);
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
              child: watchModel.when(data: (datas) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        await _present!
                            .updatePic(instansi.instansiName, _present!.user);
                      },
                      child: CircleAvatar(
                        radius: size.height * 0.05,
                        backgroundImage: NetworkImage(datas.photoUrl),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.width * 0.08,
                        ),
                        Text(
                          datas.userName,
                          style: TextStyle(
                              fontSize: size.height * 0.035,
                              fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                            onPressed: () async {
                              showit.showUp(context, () async {
                                await _present!
                                    .updateUname(
                                        _present!.user, updateUsername.text)
                                    .then((value) {
                                  Navigator.pop(context);
                                });
                              }, 'username', updateUsername, 'name');
                            },
                            icon: const Icon(Icons.mode_edit_sharp))
                      ],
                    ),
                  ],
                );
              }, error: (e, r) {
                return const Center(
                  child: Text('error page'),
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
            //
            watchModel.when(data: (datas) {
              return Container(
                width: size.width * 0.8,
                height: size.height * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your Bio',
                      style: TextStyle(
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(datas.bio),
                          IconButton(
                              onPressed: () {
                                showit.showUp(context, () async {
                                  await _present!.updateBio(
                                      _present!.user, updatebio.text);
                                }, 'Update Bio', updatebio, 'bio');
                                updatebio.clear();
                              },
                              icon: const Icon(Icons.edit)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }, error: (e, r) {
              return const Center(
                child: Text('no data'),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            })
          ],
        ),
      ),
    );
  }
}
