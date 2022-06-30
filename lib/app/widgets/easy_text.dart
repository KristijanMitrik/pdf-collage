// Flutter imports:
import 'package:flutter/material.dart';

class EasyText extends StatelessWidget {
  const EasyText(this.text,
      {Key? key,
      this.fontSize,
      this.maxLines = 1,
      this.letterSpacing,
      this.textAlign,
      this.overflow = TextOverflow.ellipsis,
      this.fontWeight,
      this.color,
      this.cursor})
      : super(key: key);

  final String text;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final MouseCursor? cursor;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: cursor ?? MouseCursor.defer,
      child: Text(
        text,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.ellipsis,
        maxLines: maxLines,
        style: TextStyle(
            color: color,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight),
      ),
    );
  }
}
