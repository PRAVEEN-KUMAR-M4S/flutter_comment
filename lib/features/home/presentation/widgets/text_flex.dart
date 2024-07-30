import 'package:flutter/material.dart';

class TextFlex extends StatelessWidget {
  final String text;
  final TextStyle style;
  const TextFlex({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      width: size * 0.65,
      child: Text(text,style: style,),
    );
  }
}
