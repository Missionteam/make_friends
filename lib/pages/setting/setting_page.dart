// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:make_friends_app/pages/setting/open_setting_page.dart';

import '../../functions/firestore_functions.dart';
import '../../models/cloud_storage_model.dart';
import '../../provider/auth_provider.dart';
import '../../provider/users_provider.dart';
import '../../widget/fundomental/userIconWidget.dart';
import 'profile_setting_dialog.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String imageLocalPath = '';
  String imageCloudPath = '';
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    //final user = ref.read(userProvider).value!;
    final uid = ref.watch(uidProvider);
    final currentUserDoc = ref.watch(currentAppUserDocProvider).value;
    final String currentUserImageName =
        currentUserDoc?.get('photoUrl') ?? 'Girl';
    final String currentUserName =
        currentUserDoc?.get('displayName') ?? '名前未登録';

    final imageUrl = ref.watch(imageUrlProvider(imageCloudPath)).value;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () => GoRouter.of(context).pop(),
                icon: const Icon(
                  Icons.chevron_left_outlined,
                  color: Color.fromARGB(255, 0, 0, 0),
                )),
          ],
        ),
        backgroundColor: const Color.fromARGB(0, 250, 250, 250),
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          '個人設定',
          style: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 90, 90, 90),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 30, bottom: 20),
                            child: InkWell(
                              onTap: () async {
                                final image = await select_myIcon(ref, context,
                                    title: 'アイコン画像を選択');

                                if (image != null) {
                                  final imageRemotePath =
                                      '${DateFormat('MMddHH:mm:ssSSS').format(Timestamp.now().toDate())}';
                                  await uploadFile(image, imageRemotePath);
                                  setState(() {
                                    imageFile = image;
                                    imageCloudPath = imageRemotePath;
                                  });
                                  final url = ref
                                      .watch(imageUrlProvider(imageCloudPath));

                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return IconChangeDialog(
                                          imageFile: imageFile,
                                          imageRocalPath: imageCloudPath,
                                        );
                                      });
                                }
                              },
                              child: UserIcon(uid: uid!, radius: 80),
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  currentUserName,
                                  style: GoogleFonts.nunito(
                                    fontSize:
                                        (currentUserName.length < 6) ? 20 : 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                  width: 80,
                                ),
                              ],
                            ),
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                          onTap: () => showDialog(
                              context: context,
                              builder: (_) => MyProfileSettingPage()),
                          child: Container(
                            height: 37,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 238, 238, 238),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.border_color_rounded,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  '編集',
                                  style: GoogleFonts.nunito(fontSize: 15),
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              /*  */
              // MenuWidget(
              //     icon: Icons.lock_person_outlined,
              //     text: 'プライバシー',
              //     onpressed: () {}),
              MenuWidget(
                  icon: Icons.lock_person_outlined,
                  text: '公開範囲の設定',
                  onpressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => OpenSettingPage()),
                    );
                  }),

              // /*  */
              // MenuWidget(
              //     icon: Icons.chat_bubble_outline,
              //     text: 'ヘルプ＆フィードバック',
              //     onpressed: () {}),
              // MenuWidget(
              //     icon: Icons.person_add_rounded,
              //     text: 'パートナーと連携する',
              //     onpressed: () {
              //       showDialog(
              //           context: context, builder: (_) => LinkageDialog());
              //     }),
              // MenuWidget(
              //     icon: Icons.share,
              //     text: 'このアプリを共有',
              //     onpressed: () {
              //       showDialog(context: context, builder: (_) => ShareDialog());
              //     }),
              // MenuWidget(
              //     icon: Icons.info_outline,
              //     text: 'ふたりべやについて',
              //     onpressed: () {}),
              MenuWidget(
                icon: Icons.power_settings_new,
                text: 'ログアウト',
                onpressed: () async {
                  // Google からサインアウト
                  print('feel pressed');
                  await FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
        ),
      ),

      //UnityWidget(onUnityCreated: onUnityCreated)
    );
  }
  /*void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }
  */
}

class IconChangeDialog extends ConsumerStatefulWidget {
  const IconChangeDialog({
    Key? key,
    required this.imageFile,
    required this.imageRocalPath,
  }) : super(key: key);
  final File? imageFile;
  final String imageRocalPath;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IconChangeDialogState();
}

class _IconChangeDialogState extends ConsumerState<IconChangeDialog> {
  double radius = 150;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('この画像をアイコンに設定しますか？'),
      children: [
        (widget.imageFile != null)
            ? SizedBox(
                width: radius,
                height: radius,
                child: CircleAvatar(
                  radius: radius,
                  child: ClipOval(
                      child: SizedBox(
                    width: radius,
                    height: radius,
                    child: Image.file(
                      widget.imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )),
                ),
              )
            : const SizedBox(),
        SizedBox(
            width: 120,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: ElevatedButton(
                onPressed: () {
                  updateUserData(ref,
                      field: 'photoUrl', value: widget.imageRocalPath);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(maximumSize: Size(radius, 50)),
                child: Text('OK'),
              ),
            ))
      ],
    );
  }
}

class MenuWidget extends StatefulWidget {
  MenuWidget({
    Key? key,
    required this.text,
    required this.icon,
    required this.onpressed,
  }) : super(key: key);
  String text;
  IconData icon;
  void Function() onpressed;
  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onpressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  widget.icon,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.text,
                  style: GoogleFonts.nunito(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 90, 90, 90),
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
