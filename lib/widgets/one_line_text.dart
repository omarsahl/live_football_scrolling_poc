import 'package:flutter/cupertino.dart';

class OneLineText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const OneLineText({required this.text, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: style,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}
