import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showMyDialog(BuildContext context,
    {double width = 340,
    double height = 460,
    Color color = Colors.white,
    double containerHorizontalPadding = 20,
    double containerVerticalPadding = 30,
    bool buttonExist = true,
    bool closeIconExist = false,
    Widget endChild = const SizedBox(),
    bool endButtonExist = false,
    required void Function()? onButtonPressd,
    required Widget child}) {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            onButtonPressd: onButtonPressd,
            child: child,
            color: color,
            containerHorizontalPadding: containerHorizontalPadding,
            containerVerticalPadding: containerVerticalPadding,
            width: width,
            height: height,
            endButtonExist: endButtonExist,
            endChild: endChild,
            buttonExist: buttonExist,
            closeIconExist: closeIconExist,
          ));
}

// ignore: must_be_immutable
class SimpleDialog extends ConsumerStatefulWidget {
  SimpleDialog(
      {super.key,
      this.width = 300,
      this.height = 400,
      this.color = Colors.white,
      this.containerHorizontalPadding = 20,
      this.containerVerticalPadding = 30,
      this.buttonExist = true,
      this.closeIconExist = false,
      this.endChild = const SizedBox(),
      this.endButtonExist = false,
      required this.onButtonPressd,
      required this.child});
  double width = 340;
  double height = 460;
  double containerHorizontalPadding;
  double containerVerticalPadding;
  void Function()? onButtonPressd;
  Widget child;
  Widget endChild;
  Color color;
  bool buttonExist;
  bool closeIconExist;
  bool endButtonExist;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DialogState();
}

class _DialogState extends ConsumerState<SimpleDialog> {
  @override
  Widget build(BuildContext context) {
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
                  widget.child,
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
}
