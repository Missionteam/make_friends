import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:make_friends_app/functions/screen_size.dart';
import 'package:make_friends_app/functions/send_post.dart';
import 'package:make_friends_app/provider/posts_provider.dart';
import 'package:make_friends_app/widget/fundomental/express/express_dialog_content.dart';
import 'package:make_friends_app/widget/fundomental/grid_view_dialog.dart';
import 'package:make_friends_app/widget/fundomental/modal/simple_dialog.dart';
import 'package:make_friends_app/widget/users_card/users_card.dart';
import 'package:make_friends_app/widget/users_list/express_list.dart';
import 'package:make_friends_app/widget/users_list/segments/date.dart';

import '../../provider/users_provider.dart';
import '../../widget/fundomental/post_widget.dart';
import '../../widget/users_list/segmented_button.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (() => {
                        showMyDialog(context,
                            color: Colors.white,
                            onButtonPressd: null,
                            buttonExist: false,
                            width: sWidth(context) * 0.9,
                            height: sHieght(context) * 0.86,
                            child: ExpressDialogContent())
                      }),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 40, bottom: 10),
                    child: Image.asset('images/HomeImage.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Image.asset('images/HomeText.png'),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      UsersCard(),
                      UsersCard(),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Align(
                    alignment: Alignment.centerLeft,
                    child: SegmentedButton(
                      items: dateSegment,
                    )),
                SizedBox(height: 20),
                ExpressList(),
                // UsersList(),
                // SizedBox(height: 20),
                // UsersList(),
                // SizedBox(height: 20),
                // UsersList(),
                // SizedBox(height: 20),
              ],
            ),
            Positioned(
                right: 0,
                top: 50,
                child: IconButton(
                    onPressed: () => context.push('/Settings'),
                    icon: Icon(Icons.settings))),
          ],
        ),
      ),
    );
  }
}

class PostList extends ConsumerStatefulWidget {
  PostList({super.key, required this.when});
  String when;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostListState();
}

class _PostListState extends ConsumerState<PostList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.when,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 10),
            IconButton(
                onPressed: () => showToDoDialog(context),
                icon: Icon(
                  Icons.insert_emoticon,
                  size: 24,
                ))
          ],
        ),
        SizedBox(
          height: 60,
          child: ref.watch(postsProvider).when(
            data: (data) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 10, left: 10),
                itemCount: data.docs.length,
                itemBuilder: (context, index) {
                  final post = data.docs[index].data();
                  return PostWidget(post: post);
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
        )
      ],
    );
  }

  Future<dynamic> showToDoDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => GridViewDialog(children: [
              ToDoWidget(
                  imagePath: 'images/WhatToDo/WallHitting.jpg',
                  description: '壁打ち'),
              ToDoWidget(
                  imagePath: 'images/WhatToDo/Work.png', description: '作業'),
              ToDoWidget(
                  imagePath: 'images/WhatToDo/Restaurant.jpg',
                  description: 'ごはん'),
              ToDoWidget(
                  imagePath: 'images/WhatToDo/Free.png', description: '活動内容なし'),
              ToDoWidget(
                  imagePath: 'images/WhatToDo/Talk.jpg', description: '話す、相談'),
            ]));
  }
}

class ToDoWidget extends ConsumerWidget {
  ToDoWidget({Key? key, required this.imagePath, required this.description})
      : super(key: key);
  String imagePath;
  String description;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDoc = ref.watch(currentAppUserDocProvider).value;
    return Material(
      child: InkWell(
        onTap: () {
          if (userDoc != null) sendPost(ref, imagePath, userDoc);
          Navigator.of(context).pop();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Image.asset(imagePath), Text(description)],
        ),
      ),
    );
  }
}
