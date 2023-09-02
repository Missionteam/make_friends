import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:make_friends_app/widget/fundomental/mock/Circle.dart';
import 'package:make_friends_app/widget/fundomental/userIconWidget.dart';

import '../../provider/express/express_provider.dart';
import '../fundomental/express/join_dialog_content.dart';
import '../fundomental/modal/simple_dialog.dart';

class ExpressList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categorizedData = ref.watch(expressByCategoryProvider);

    return categorizedData.when(
      data: (categories) => ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: categories.entries.map((entry) {
          final category = entry.key;
          final expressItems = entry.value;
          final hasValue = (expressItems.length > 0);

          return (hasValue)
              ? Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyCircle(color: Colors.yellow, radius: 20),
                      ...expressItems.map((item) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (() => {
                                      showMyDialog(context,
                                          color: Colors.white,
                                          onButtonPressd: null,
                                          height: 280,
                                          buttonExist: false,
                                          child: JoinDialogContent(
                                            uid: item.uid,
                                          ))
                                    }),
                                child: UserIcon(uid: item.uid, radius: 60)),
                          )),
                    ],
                  ),
                )
              : SizedBox();
        }).toList(),
      ),
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
