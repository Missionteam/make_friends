import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/text.dart';

void showBaseDialog(BuildContext context,
    {double width = 340,
    double height = 460,
    Color color = Colors.white,
    double containerHorizontalPadding = 20,
    double containerVerticalPadding = 30,
    bool buttonExist = false,
    bool closeIconExist = false,
    required void Function()? onButtonPressd,
    required List<Widget> children}) {
  showDialog(
      context: context,
      builder: (context) => BaseDialog(
            onButtonPressd: onButtonPressd,
            children: children,
            color: color,
            containerHorizontalPadding: containerHorizontalPadding,
            containerVerticalPadding: containerVerticalPadding,
            width: width,
            height: height,
            buttonExist: buttonExist,
            closeIconExist: closeIconExist,
          ));
}

// ignore: must_be_immutable
class BaseDialog extends ConsumerStatefulWidget {
  BaseDialog(
      {super.key,
      this.width = 300,
      this.height = 400,
      this.color = const Color.fromARGB(255, 255, 238, 238),
      this.containerHorizontalPadding = 20,
      this.containerVerticalPadding = 30,
      this.buttonExist = false,
      this.closeIconExist = false,
      required this.onButtonPressd,
      required this.children});
  double width = 340;
  double height = 460;
  double containerHorizontalPadding;
  double containerVerticalPadding;
  void Function()? onButtonPressd;
  List<Widget> children;

  Color color;
  bool buttonExist;
  bool closeIconExist;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DialogState();
}

class _DialogState extends ConsumerState<BaseDialog> {
  @override
  Widget build(BuildContext context) {
    if (widget.buttonExist)
      widget.children.add(
        textButton(context),
      );
    return Center(
      child: GestureDetector(
        onTap: () {
          primaryFocus?.unfocus();
        },
        child: Material(
          color: Color.fromARGB(0, 255, 255, 255),
          child: Container(
              width: widget.width,
              height: widget.height,
              alignment: Alignment.topCenter,
              color: widget.color,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: widget.containerHorizontalPadding,
                          vertical: widget.containerVerticalPadding),
                      child: Column(children: widget.children),
                    ),
                  ),
                  (widget.closeIconExist)
                      ? Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 15,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ))
                      : SizedBox(),
                ],
              )),
        ),
      ),
    );
  }

  TextButton textButton(BuildContext context) {
    return TextButton(
        onPressed: widget.onButtonPressd,
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          fixedSize: Size(150, 40),
        ),
        child: Text(
          '送信',
          style: GoogleFonts.nunito(
              // color: Color.fromARGB(255, 243, 243, 243)),
              color: Colors.white),
        ));
  }
}

Future<void> showConfirmDialog(
  BuildContext context,
  void Function()? onTap,
  WidgetRef ref, {
  String title = '',
  String main = '',
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Color.fromARGB(255, 255, 231, 239),
      title: NotoText(
        text: title,
        fontSize: 18,
      ),
      content: NotoText(text: main),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onTap,
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
