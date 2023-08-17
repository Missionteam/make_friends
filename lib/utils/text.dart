import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MainText extends ConsumerWidget {
  MainText(
      {Key? key,
      required this.text,
      this.color = Colors.black,
      this.fontSize = 14,
      this.textHight,
      this.fontWeight = FontWeight.w500,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.leftPadding = 0,
      this.rightPadding = 0,
      this.textAlign})
      : super(key: key);
  String text;
  double fontSize;
  Color color;
  FontWeight fontWeight;
  double? textHight;
  TextAlign? textAlign;
  double topPadding;
  double bottomPadding;
  double leftPadding;
  double rightPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
          top: topPadding,
          bottom: bottomPadding,
          left: leftPadding,
          right: rightPadding),
      child: Text(
        text,
        textAlign: textAlign,
        style: GoogleFonts.yuseiMagic(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: color,
            height: textHight),
      ),
    );
  }
}

class TitleText extends ConsumerWidget {
  TitleText(
      {Key? key,
      required this.text,
      this.color = const Color.fromARGB(255, 16, 16, 16),
      this.fontSize = 24,
      this.fontWeight = FontWeight.w800,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.leftPadding = 0,
      this.rightPadding = 0,
      this.textAlign})
      : super(key: key);
  String text;
  double fontSize;
  Color color;
  FontWeight fontWeight;
  TextAlign? textAlign;
  double topPadding;
  double bottomPadding;
  double leftPadding;
  double rightPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
          top: topPadding,
          bottom: bottomPadding,
          left: leftPadding,
          right: rightPadding),
      child: Text(
        text,
        textAlign: textAlign,
        style: GoogleFonts.nunito(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class NotoText extends ConsumerWidget {
  NotoText(
      {Key? key,
      required this.text,
      this.color = Colors.black,
      this.fontSize = 14,
      this.textHight = 1.2,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.leftPadding = 0,
      this.rightPadding = 0,
      this.fontWeight = FontWeight.w500,
      this.textAlign})
      : super(key: key);
  String text;
  double fontSize;
  Color color;
  FontWeight fontWeight;
  double? textHight;
  double topPadding;
  double bottomPadding;
  double leftPadding;
  double rightPadding;
  TextAlign? textAlign;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
          top: topPadding,
          bottom: bottomPadding,
          left: leftPadding,
          right: rightPadding),
      child: Text(
        text,
        textAlign: textAlign,
        style: GoogleFonts.notoSansJavanese(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: color,
            height: textHight),
      ),
    );
  }
}

class MagicText extends ConsumerWidget {
  MagicText(
      {Key? key,
      required this.text,
      this.color = const Color.fromARGB(255, 35, 35, 35),
      this.fontSize = 24,
      this.fontWeight = FontWeight.w500,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.leftPadding = 0,
      this.rightPadding = 0,
      this.textAlign})
      : super(key: key);
  String text;
  double fontSize;
  Color color;
  FontWeight fontWeight;
  TextAlign? textAlign;
  double topPadding;
  double bottomPadding;
  double leftPadding;
  double rightPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
          top: topPadding,
          bottom: bottomPadding,
          left: leftPadding,
          right: rightPadding),
      child: Text(
        text,
        textAlign: textAlign,
        style: GoogleFonts.yuseiMagic(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
