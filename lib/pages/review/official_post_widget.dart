import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

import '../../models/post.dart';
import '../../models/cloud_storage_model.dart';

class OfficialPostWidget extends ConsumerWidget {
  const OfficialPostWidget({
    Key? key,
    required this.post,
    this.isReplyPage = false,
  }) : super(key: key);

  final Post post;
  final bool isReplyPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget image =
        ref.watch(imageOfPostProvider(post.imageUrl)).value ?? SizedBox();

    Future<void> updatePost(String text) async {
      post.reference.update({'stamps': text});
    }

    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OfficialIcon(
                radius: 40,
                imagePath: post.posterImageUrl,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                      useRootNavigator: true,
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 330,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          updatePost('🤗');
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('🤗',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            )),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          updatePost('🙆‍♂️');
                                        },
                                        child: Text('🙆‍♂️',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            )),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          updatePost('🥺');
                                        },
                                        child: Text('🥺',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            )),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          updatePost('❤️');
                                        },
                                        child: Text('❤️',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            )),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          updatePost('🤔');
                                        },
                                        child: Text('🤔',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // TextButton(
                                  //   onPressed: () {
                                  //     Navigator.of(context).pop();
                                  //     Navigator.of(context).push(
                                  //         MaterialPageRoute(
                                  //             builder: ((context) =>
                                  //                 ReplyPage(post: post))));
                                  //   },
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Text(
                                  //       'スレッドで返信する',
                                  //       style: GoogleFonts.nunito(
                                  //         fontSize: 14,
                                  //         color: Colors.black,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  TextButton(
                                    onPressed: () => null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'ごめんね、今返信できない(準備中)',
                                        style: GoogleFonts.nunito(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => null,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '考え中です(準備中)',
                                        style: GoogleFonts.nunito(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // TextButton(
                                  //   onPressed: () => null,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Text(
                                  //       '後でリマインドする',
                                  //       style: const TextStyle(
                                  //         fontSize: 14,
                                  //         color: Colors.black,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // TextButton(
                                  //   onPressed: () => null,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Text(
                                  //       'ブックマークに登録する',
                                  //       style: const TextStyle(
                                  //         fontSize: 14,
                                  //         color: Colors.black,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.posterName,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                                color: Color.fromARGB(255, 194, 102, 102)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                DateFormat('MM/dd HH:mm')
                                    .format(post.createdAt.toDate()),
                                style: const TextStyle(
                                    fontSize: 8,
                                    color: Color.fromARGB(126, 48, 48, 48)),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 5,
                            bottom: (post.stamps != '')
                                ? 5
                                : (post.replyCount != 0)
                                    ? 5
                                    : 25,
                            right: 5),
                        child: Text(
                          post.text,
                          style: const TextStyle(
                            fontSize: 14.6,
                            color: Color.fromARGB(225, 59, 59, 59),
                            height: 1.5,
                          ),
                        ),
                      ),
                      image,
                      SizedBox(
                        height: (post.stamps == '') ? 0 : 38,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: (post.replyCount != 0) ? 0 : 8),
                          child: ElevatedButton(
                            onPressed: (() => null),
                            child: Text(post.stamps ?? ''),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor:
                                  Color.fromARGB(69, 255, 255, 255),
                              // shadowColor: Color.fromARGB(255, 194, 194, 194),
                              elevation: 0,
                              padding: EdgeInsets.all(0),
                              // maximumSize: Size(0.1, 0.1)
                              // (post.stamps == null) ? Size(0, 0) : Size(40, 40),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            (this.isReplyPage == false && post.replyCount != 0)
                                ? 34
                                : 0,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 4),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: OfficialIcon(
                                  radius: 40,
                                  imagePath: post.posterImageUrl,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (_) => ReplyPage(post: post));
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: ((context) => ReplyPage(post: post))));
                                },
                                child: Text(
                                  '${post.replyCount}件の返信',
                                  style: GoogleFonts.nunito(
                                      color: Color.fromARGB(255, 243, 103, 33),
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OfficialIcon extends ConsumerWidget {
  const OfficialIcon({
    Key? key,
    required this.imagePath,
    this.radius = 10,
  }) : super(key: key);
  final String imagePath;
  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageWidget =
        ref.watch(officailIconProvider(imagePath)).value ?? SizedBox();
    SizedBox(
      width: radius,
    );
    return SizedBox(
      width: radius,
      height: radius,
      child: CircleAvatar(
        radius: radius,
        child: ClipOval(
          child: SizedBox(width: radius, height: radius, child: imageWidget),
        ),
      ),
    );
  }
}

final officailIconProvider = FutureProvider.family((ref, String imagePath) {
  final imageUrl = (imagePath != 'Boy' && imagePath != 'Girl')
      ? ref.watch(imageUrlProvider(imagePath)).value
      : null;
  final imageWidget = (imageUrl != null)
      ? CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        )
      : (imagePath == 'Boy' || imagePath == 'Girl')
          ? Image(image: AssetImage('images/${imagePath}Icon.png'))
          : SizedBox();
  return imageWidget;
});
