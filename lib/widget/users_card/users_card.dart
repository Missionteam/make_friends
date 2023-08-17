import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:make_friends_app/widget/fundomental/mock/Circle.dart';
import 'package:make_friends_app/widget/fundomental/userIconWidget.dart';

import '../../provider/auth_provider.dart';

class UsersCard extends ConsumerStatefulWidget {
  const UsersCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UsersCardState();
}

class _UsersCardState extends ConsumerState<UsersCard> {
  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(uidProvider);
    return Card(
      child: Container(
        width: 200,
        height: 160,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserIcon(uid: uid ?? '', radius: 100),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          MyCircle(),
                          SizedBox(width: 10),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text('寺沢遼太郎'),
                      SizedBox(height: 8),
                      Text("今日 19:00", style: TextStyle(fontSize: 10))
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(80, 26),
                    foregroundColor: Color.fromRGBO(25, 118, 210, 1),
                    side: BorderSide(
                      color: Color.fromRGBO(25, 118, 210, 1),
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    '詳細',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                SizedBox(width: 14),
                ElevatedButton(
                  onPressed: (() => {}),
                  style: ElevatedButton.styleFrom(minimumSize: Size(80, 26)),
                  child: Text(
                    '参加',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
