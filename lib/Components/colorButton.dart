import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final String? title;
  final double? height;
  final double? width;
  final double? fontSize;
  ColorButton(this.title, {this.height, this.width, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40,
      width: width ?? 150,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
          child: Text(
        title!,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: fontSize ?? 14, color: Colors.white, letterSpacing: 1.5),
      )),
    );
  }
}
