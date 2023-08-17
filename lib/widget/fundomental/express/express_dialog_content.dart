import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:make_friends_app/models/express.dart';
import 'package:make_friends_app/utils/text.dart';
import 'package:make_friends_app/widget/fundomental/express/confirm_express_dialog_content.dart';
import 'package:make_friends_app/widget/fundomental/modal/simple_dialog.dart';
import 'package:make_friends_app/widget/users_list/segmented_button.dart';
import 'package:make_friends_app/widget/users_list/segments/express_type.dart';

class ExpressDialogContent extends ConsumerStatefulWidget {
  ExpressDialogContent({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ExpressDialogContentState();
}

class ExpressDialogContentState extends ConsumerState<ExpressDialogContent> {
  List<ExpressItem> selectedExpress = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: NotoText(
                      text: 'How are you fellings today?',
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: 260,
                    height: 140,
                  ),
                  SizedBox(height: 20),
                  SegmentedButton(
                    items: expressType,
                    fillColor: Color.fromARGB(255, 236, 236, 236),
                    selectedBorderColor: Color.fromARGB(255, 236, 236, 236),
                  ),
                  SizedBox(height: 14),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 横に3つ表示
                    ),
                    shrinkWrap: true, // これによりGridViewが自分自身の内容に合わせて高さを調整します
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: expressList.length,
                    itemBuilder: (context, index) {
                      final item = expressList[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            item.isSelected = !item.isSelected;
                            selectedExpress.add(item);
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _buildCircle(isSelected: item.isSelected),
                            SizedBox(height: 6),
                            Text(item.title),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(onPressed: () {}, child: Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                showMyDialog(context,
                    onButtonPressd: (() {}),
                    child: ConfirmExpressDialogContent(
                      selecedExpress: selectedExpress,
                    ));
              },
              child: Text('OK'),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCircle({bool isSelected = false}) {
    return Container(
      width: 60, // こちらのサイズを変えることで円の大きさを調整できます
      height: 60, // こちらのサイズを変えることで円の大きさを調整できます
      decoration: BoxDecoration(
        shape: BoxShape.circle, // 円形にする
        color: isSelected ? Colors.blue : Colors.white, // 背景色
        border: Border.all(
            color: Color.fromARGB(255, 83, 83, 83), width: 1), // 外枠の設定
      ),
    );
  }
}
