import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Components/colorButton.dart';
import 'package:diademe/Locale/locales.dart';
import 'package:diademe/pages/login.dart';
import 'package:diademe/pages/questionPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: FadedSlideAnimation(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginUi()));
                    },
                    child: FadedScaleAnimation(
                      RichText(
                        text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Diademe',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              TextSpan(
                                  text: 'Feedback',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20)),
                            ]),
                      ),
                      durationInMilliseconds: 600,
                    ),
                  ),
                ],
              ),
              Spacer(),
              FadedScaleAnimation(
                Row(
                  children: [
                    Text(locale.giveYour!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(letterSpacing: 1, fontSize: 25)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(locale.feedback!,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            letterSpacing: 1,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                durationInMilliseconds: 600,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(locale.yourWordMeansALot!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(letterSpacing: 2, color: Colors.grey)),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuestionPage(locale.howWas)));
                      },
                      child: FadedScaleAnimation(
                        ColorButton(locale.bringItOn),
                        durationInMilliseconds: 600,
                      )),
                ],
              ),
              Expanded(
                flex: 5,
                  // height: MediaQuery.of(context).size.height * 0.35,
                  child: Image(image: AssetImage("assets/Layer 15.png"))),
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
