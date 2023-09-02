// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/cloud_storage_model.dart';
import '../../models/post.dart';
import '../../provider/auth_provider.dart';
import '../../provider/cloud_messeging_provider.dart';
import '../../provider/posts_provider.dart';
import '../../provider/users_provider.dart';
import 'official_post_widget.dart';

class ReviewPage extends ConsumerStatefulWidget {
  const ReviewPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<ReviewPage> {
  String _review = '';
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  String imageLocalPath = '';
  String imageCloudPath = '';
  File? imageFile;
  Future<void> sendPost(String text) async {
    // まずは user という変数にログイン中のユーザーデータを格納します
    final userDoc = ref.watch(currentAppUserDocProvider).value;
    final posterId = userDoc?.get('id'); // ログイン中のユーザーのIDがとれます
    final posterName = userDoc?.get('displayName'); // Googleアカウントの名前がとれます
    final posterImageUrl = userDoc?.get('photoUrl'); // Googleアカウントのアイコンデータがとれます
    final roomId = 'rivew';

    // 先ほど作った postsReference からランダムなIDのドキュメントリファレンスを作成します
    // doc の引数を空にするとランダムなIDが採番されます
    final newDocumentReference = ref.watch(reviewPostsReferenceProvider).doc();

    final newPost = Post(
      text: text,

      createdAt: Timestamp.now(), // 投稿日時は現在とします
      posterName: posterName,
      posterImageUrl: posterImageUrl,
      posterId: posterId,
      stamps: '',
      reference: newDocumentReference,
    );

    // 先ほど作った newDocumentReference のset関数を実行するとそのドキュメントにデータが保存されます。
    // 引数として Post インスタンスを渡します。
    // 通常は Map しか受け付けませんが、withConverter を使用したことにより Post インスタンスを受け取れるようになります。
    newDocumentReference.set(newPost);
  }

  Future<void> sendOfficial(String text) async {
    // まずは user という変数にログイン中のユーザーデータを格納します
    final userDoc = ref.watch(currentAppUserDocProvider).value;
    final posterId = userDoc?.get('id'); // ログイン中のユーザーのIDがとれます
    final posterName = (posterId == '1kcT1PZsCMRFaZmy861Z5EBhR5X2')
        ? '寺沢遼太郎_ふたりべや開発者'
        : (posterId == 'zrg4iMBJbadqTComgGpGMtdortQ2')
            ? '平本有利佳_ふたりべや開発者'
            : userDoc?.get('displayName'); // Googleアカウントの名前がとれます
    final posterImageUrl = (posterId == '1kcT1PZsCMRFaZmy861Z5EBhR5X2')
        ? 'zrg4iMBJbadqTComgGpGMtdortQ2/032815:25:06404'
        : userDoc?.get('photoUrl'); // Googleアカウントのアイコンデータがとれます
    final roomId = '';
    final imageLocalPath = this.imageLocalPath;

    if (imageFile != null) {
      uploadFile(imageFile!, imageCloudPath);
    }
    final newDocumentReference =
        ref.watch(officialPostsReferenceProvider).doc();

    final newPost = Post(
      text: text,
      createdAt: Timestamp.now(),
      posterName: posterName,
      posterImageUrl: posterImageUrl,
      posterId: posterId,
      stamps: '',
      imageLocalPath: imageLocalPath,
      imageUrl: (imageFile != null) ? imageCloudPath : '',
      reference: newDocumentReference,
    );
    newDocumentReference.set(newPost);
  }

  final controller = TextEditingController();
  final controller2 = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final user = ref.read(userProvider).value!;
    final currentUserDoc = ref.watch(currentAppUserDocProvider).value;

    final String currentUserImageName =
        currentUserDoc?.get('photoUrl') ?? 'Girl';
    final String currentUserName =
        currentUserDoc?.get('displayName') ?? 'お名前を登録してください。';

    final uid = ref.watch(uidProvider);
    final bool isDeveloper = (uid == '1kcT1PZsCMRFaZmy861Z5EBhR5X2' ||
        uid == 'zrg4iMBJbadqTComgGpGMtdortQ2');
    bool isVisible = ref.watch(isVisibleProvider).istrue;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 173, 173),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 250, 250, 250),
        toolbarHeight: 100,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(
            'アプリのフィードバックをする',
            style: GoogleFonts.nunito(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 90, 90, 90),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            primaryFocus?.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Image.asset('images/Tworoom.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                  child: Text(
                      'このアプリは、大学生が制作したアプリです。\n私たちは、カップルの方々が「もっと恋人と繋がれる」ようなアプリを作りたいと考えていますが、まだまだ課題点が多いと感じています。皆さんがどのようなことを感じているのか、ぜひ私たちに聞かせて頂けませんか？'),
                ),
                Form(
                    key: _formKey,
                    child: Container(
                        padding: const EdgeInsets.only(
                            top: 40.0, left: 40, right: 0, bottom: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: new TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: controller,
                                enabled: true,
                                obscureText: false,
                                decoration: const InputDecoration(
                                  hintText: 'このアプリの感想を教えてください',
                                  labelText: '感想',
                                ),
                                onSaved: (String? value) {
                                  this._review = value ?? '';
                                },
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  sendPost(controller.text);
                                  primaryFocus?.unfocus();
                                  FirebaseCloudMessagingService()
                                      .sendPushNotification(
                                          token:
                                              'fynLxP2_RGC2QcLYx1zai_:APA91bEhv7KEjiJTsjrB-eBqVBd508dSGXxjFtxar9t-BT-NM2KpFfkFBzrE9hq-Pqy3E6OILjc0XSyDdGAgWiQ1k8-FKT49c9N1ARBjTRH8jz_rHcbubHOMpPupt5XDNdQCagcPaRtr',
                                          title: '利用者の方からFBが届きました。',
                                          body: '',
                                          type: 'review',
                                          room: '',
                                          postId: '');
                                  // FirebaseCloudMessagingService()
                                  //     .sendPushNotification(
                                  //         'cFjy_l0Y_EgxsEll7eLvSd:APA91bG74Hpf1CBi_8SMp8PbcyYKE5nGLZSt74AcbWjD3I7mk7fO4OLhJCTfMYwz1tjZzNSoF5Pe89YKwPY2WNrwjdgFur7OabNgi1C4beX9PuBFCbJ3BFDoW0hiAHRaawsEYqFR9ZMc',
                                  //         '利用者の方からFBが届きました。',
                                  //         '',
                                  //         'review',
                                  //         '');
                                  controller.clear();
                                },
                                icon: Icon(Icons.send))
                          ],
                        ))),
                SizedBox(
                  height: 400,
                ),
                Text(
                  '運営からのお知らせ',
                  style: GoogleFonts.yuseiMagic(fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
                    child: SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: ref.watch(officialPostsProvider).when(
                        data: (data) {
                          /// 値が取得できた場合に呼ばれる。
                          return ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 10, left: 10),
                            itemCount: data.docs.length,
                            itemBuilder: (context, index) {
                              final post = data.docs[index].data();
                              return OfficialPostWidget(post: post);
                            },
                          );
                        },
                        error: (_, __) {
                          /// 読み込み中にErrorが発生した場合に呼ばれる。
                          return const Center(
                            child: Text('不具合が発生しました。'),
                          );
                        },
                        loading: () {
                          /// 読み込み中の場合に呼ばれる。
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                (isDeveloper)
                    ? Row(
                        children: [
                          Checkbox(
                              activeColor: Color.fromARGB(98, 80, 80, 80),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              fillColor: MaterialStateProperty.resolveWith(
                                  (states) =>
                                      Color.fromARGB(143, 100, 100, 100)),
                              value: isVisible,
                              onChanged: (value) {
                                ref
                                    .watch(isVisibleProvider.notifier)
                                    .setisVisible(value);
                              }),
                          Text(
                            (isVisible) ? '表示' : '',
                            style: GoogleFonts.nunito(
                                color: Color.fromARGB(146, 91, 91, 91)),
                          )
                        ],
                      )
                    : SizedBox(
                        height: 30,
                      ),
                (isDeveloper && isVisible)
                    ? Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                final image = await select_icon(context);
                                final imageRemotePath =
                                    '${DateFormat('MMddHH:mm:ssSSS').format(Timestamp.now().toDate())}';
                                setState(() {
                                  this.imageFile = image;
                                  uploadFile(imageFile!, imageRemotePath);
                                  setState(() {
                                    imageCloudPath = imageRemotePath;
                                  });
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.grey,
                              )),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: controller2,
                              decoration: InputDecoration(
                                hintText: 'お知らせ送信フォーム(開発者のみ表示)',
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 88, 88, 88)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(47, 165, 165, 165),
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(110, 206, 206, 206),
                                    width: 1,
                                  ),
                                ),
                              ),
                              onFieldSubmitted: (text) {
                                sendOfficial(text);
                                controller2.clear();
                              },
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                sendOfficial(controller2.text);
                                primaryFocus?.unfocus();
                                controller2.clear();
                              },
                              icon: Icon(Icons.send))
                        ],
                      )
                    : SizedBox(),
              ],
            ),
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
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.text,
                  style: GoogleFonts.nunito(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 90, 90, 90),
                  ),
                ),
              ],
            ),
            Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
