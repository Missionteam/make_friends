import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:make_friends_app/provider/users_provider.dart';
import 'package:make_friends_app/utils/text.dart';
import 'package:make_friends_app/widget/fundomental/userIconWidget.dart';

import '../../functions/firestore_functions.dart';

class OpenSettingPage extends ConsumerStatefulWidget {
  OpenSettingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => OpenSettingPageState();
}

class OpenSettingPageState extends ConsumerState<OpenSettingPage> {
  Map<String, bool> selectedUsersMap = {};
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 70),
        NotoText(
          text: "一緒にご飯に行きたい人を選択",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ref.watch(friendsProvider).when(data: (data) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, left: 10),
                  itemCount: data.docs.length,
                  itemBuilder: (context, index) {
                    final user = data.docs[index].data();
                    final isSelected = selectedUsersMap[user.id] ?? false;
                    const radius = 70.0;
                    return Center(
                      child: Container(
                        width: radius + 20,
                        height: radius + 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        child: Material(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(radius),
                            onTap: () {
                              setState(() {
                                selectedUsersMap[user.id] = !isSelected;
                              });
                            },
                            child: UserIcon(
                              uid: user.id,
                              radius: radius,
                              isSelected: isSelected,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }, error: (_, __) {
                return const Center(
                  child: Text('不具合が発生しました。'),
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                final selectedUserList = getSelectedUids();
                print(selectedUserList);
                updateUserData(ref,
                    field: 'openSettings',
                    value: {"default": selectedUserList});
                Navigator.of(context).pop();
              },
              child: Text('決定'),
            ),
          ),
        )
      ],
    ));
  }

  List<String> getSelectedUids() {
    return selectedUsersMap.entries
        .where((entry) => entry.value) // valueがtrueのものだけフィルタリング
        .map((entry) => entry.key) // key(uid)のみを取得
        .toList(); // リストに変換
  }
}
