import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:make_friends_app/functions/send_express.dart';
import 'package:make_friends_app/models/expressItem.dart';
import 'package:make_friends_app/widget/fundomental/mock/Circle.dart';

class ConfirmExpressDialogContent extends ConsumerStatefulWidget {
  ConfirmExpressDialogContent({super.key, required this.selecedExpress});
  final List<ExpressItem> selecedExpress;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ConfirmExpressDialogContentState();
}

class ConfirmExpressDialogContentState
    extends ConsumerState<ConfirmExpressDialogContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ListView.builder(
                    itemCount: widget.selecedExpress.length,
                    itemBuilder: (context, index) {
                      final item = widget.selecedExpress[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            MyCircle(radius: 20),
                            SizedBox(width: 10),
                            Text(item.title)
                          ],
                        ),
                      );
                    },
                    shrinkWrap: true),
              ],
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              for (final expressItem in widget.selecedExpress)
                sendExpress(ref, expressItem);
              Navigator.of(context).pop();
            },
            child: Text('OK'))
      ],
    );
  }
}
