import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final String? title;
  ColorButton(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
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
            .copyWith(fontSize: 14, color: Colors.white, letterSpacing: 1.5),
      )),
    );
  }
}
