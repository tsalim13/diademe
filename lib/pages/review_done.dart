import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/pages/home.dart';
import 'package:diademe/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Components/colorButton.dart';

class ReviewDone extends StatelessWidget {
  TextEditingController passwordFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 15), () {
      Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePage()));
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
                  )
                ),
                Text(
                  "Merci pour votre collaboration",
                  style: TextStyle(
                    fontSize: 50,

                  ),
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
