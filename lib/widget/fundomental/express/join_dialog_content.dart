import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:make_friends_app/widget/fundomental/mock/Circle.dart';
import 'package:make_friends_app/widget/fundomental/userIconWidget.dart';

import '../../../provider/auth_provider.dart';
import '../modal/conffeti_dialog.dart';

class JoinDialogContent extends ConsumerWidget {
  const JoinDialogContent({Key? key, required this.uid}) : super(key: key);
  final String uid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myUid = ref.watch(uidProvider);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: MyCircle(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserIcon(uid: myUid ?? "", radius: 90),
            SizedBox(width: 30),
            UserIcon(uid: uid, radius: 90)
          ],
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (() {}), child: Text("TextA")),
            SizedBox(width: 30),
            ElevatedButton(
                onPressed: () async {
                  final _isMoveChat = await showDialog(
                      context: context,
                      builder: ((_) => ConffetiDialog(
                            uid: uid,
                          )));
                  if (_isMoveChat == true) Navigator.of(context).pop(true);
                },
                child: Text("TextB"))
          ],
        )
      ],
    );
  }
}
