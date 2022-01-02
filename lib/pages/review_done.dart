import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';

class ReviewDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pop(context);
    });
    return Scaffold(
      body: FadedSlideAnimation(
        Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(child: Image.asset("assets/diademe_logo.png")),
              )),
              Text(
                "Merci pour votre collaboration",
                style: TextStyle(fontSize: 50, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
        beginOffset: Offset(0.0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
