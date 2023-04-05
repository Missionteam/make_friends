// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontConst extends TextStyle {
  FontConst({
    required this.style,
  });
  TextStyle style;

  factory FontConst.instance(
      {double? fontsize, Color? color, FontWeight? fontWeight}) {
    double _fontsize = fontsize ?? 14;
    Color _color = color ?? const Color.fromARGB(255, 90, 90, 90);
    FontWeight _fontWeight = fontWeight ?? FontWeight.w500;
    TextStyle style = GoogleFonts.nunito(
      fontSize: _fontsize,
      fontWeight: _fontWeight,
      color: _color,
    );
    return FontConst(style: style);
  }
}
