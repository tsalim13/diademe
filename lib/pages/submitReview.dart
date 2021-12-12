import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Locale/locales.dart';
import 'package:diademe/pages/home.dart';

class SubmitReview extends StatefulWidget {
  @override
  _SubmitReviewState createState() => _SubmitReviewState();
}

class _SubmitReviewState extends State<SubmitReview> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  FadedScaleAnimation(
                    RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              letterSpacing: 2, fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Diademe',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            TextSpan(
                                text: 'REVIEW',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20)),
                          ]),
                    ),
                    durationInMilliseconds: 600,
                  ),
                ],
              ),
              Spacer(),
              FadedScaleAnimation(
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.thankYouFor!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(letterSpacing: 1.5, fontSize: 25)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(AppLocalizations.of(context)!.yourFeedback!,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            letterSpacing: 1.5,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                durationInMilliseconds: 600,
              ),
              SizedBox(
                height: 15,
              ),
              FadedScaleAnimation(
                Text(AppLocalizations.of(context)!.weWillTry!,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(letterSpacing: 2, color: Colors.grey)),
                durationInMilliseconds: 600,
              ),
              Spacer(),
              Expanded(
                flex: 5,
                  // height: MediaQuery.of(context).size.height * 0.4,
                  child: FadedScaleAnimation(
                    Image(image: AssetImage("assets/Layer 14.png")),
                    durationInMilliseconds: 600,
                  )),
              SizedBox(
                height: 10,
              )
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
