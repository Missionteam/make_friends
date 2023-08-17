import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/post.dart';
import 'userIconWidget.dart';

class PostWidget extends ConsumerStatefulWidget {
  PostWidget({super.key, required this.post});
  Post post;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends ConsumerState<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
          context: context,
          builder: ((context) => EditPostDialog(
                post: widget.post,
              ))),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(widget.post.text),
          ),
          Positioned(
            left: 5,
            bottom: 0,
            width: 20,
            child: UserIcon(
              radius: 20,
              uid: widget.post.posterId,
            ),
          )
        ],
      ),
    );
  }
}

class EditPostDialog extends ConsumerStatefulWidget {
  EditPostDialog({super.key, required this.post});
  Post post;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPostDialogState();
}

class _EditPostDialogState extends ConsumerState<EditPostDialog> {
  String time = '';
  String toDo = '';
  String where = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 200),
      child: Container(
        height: 100,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 50),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('時間：'),
                SizedBox(width: 40),
                SizedBox(
                  width: 140,
                  child: Material(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        labelText: '例：13-15',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          time = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('活動内容：'),
                SizedBox(width: 20),
                SizedBox(
                  width: 140,
                  child: Material(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: '',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          time = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('集合：'),
                SizedBox(width: 40),
                SizedBox(
                  width: 140,
                  child: Material(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'あとで決める',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          time = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: (() => Navigator.of(context).pop()),
                    child: Text(
                      'CANCEL',
                      // style: TextStyle(color: Colors.green),
                    )),
                ElevatedButton(onPressed: (() => null), child: Text('OK'))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
