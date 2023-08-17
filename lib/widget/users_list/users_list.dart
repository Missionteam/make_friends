import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:make_friends_app/widget/fundomental/mock/Circle.dart';
import 'package:make_friends_app/widget/fundomental/userIconWidget.dart';

import '../../provider/auth_provider.dart';

class UsersList extends ConsumerStatefulWidget {
  UsersList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => UsersListState();
}

class UsersListState extends ConsumerState<UsersList> {
  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(uidProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          MyCircle(
            radius: 20,
            color: Colors.yellow,
          ),
          SizedBox(width: 20),
          UserIcon(uid: uid ?? '', radius: 60),
          SizedBox(width: 10),
          UserIcon(uid: uid ?? '', radius: 60),
          SizedBox(width: 10),
          UserIcon(uid: uid ?? '', radius: 60),
          SizedBox(width: 10),
          UserIcon(uid: uid ?? '', radius: 60),
        ],
      ),
    );
  }
}
