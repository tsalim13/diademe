import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Theme/colors.dart';

class ReviewScale extends StatefulWidget {
  @override
  _ReviewScaleState createState() => _ReviewScaleState();
}

class _ReviewScaleState extends State<ReviewScale> {
  int currentIndex = -1;
  List reviews = [
    "Excellent Food",
    "Good Food",
    "Average Food",
    "Not Good Food"
  ];
  List imgs = [
    "assets/Reactions/Loved it.gif",
    "assets/Reactions/Good.gif",
    "assets/Reactions/average.gif",
    "assets/Reactions/not good.gif"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: currentIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.white),
              child: Column(
                children: [
                  Text(reviews[index], style: Theme.of(context).textTheme.bodyText1!.copyWith(color: currentIndex!=index?blackColor.withOpacity(0.8):Theme.of(context).scaffoldBackgroundColor),),
                  Spacer(),
                  Container(
                    child: FadedScaleAnimation(
                      Image(image: AssetImage(imgs[index])),
                      durationInMilliseconds: 600,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
