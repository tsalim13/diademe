import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/Dao/SalerDao.dart';
import 'package:diademe/Dao/SalerReviewDao.dart';
import 'package:diademe/Models/Saler.dart';
import 'package:diademe/database/database.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Components/colorButton.dart';
import 'package:diademe/Locale/locales.dart';
import 'package:diademe/pages/login.dart';
import 'package:diademe/pages/questionPage.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppDatabase database;
  late SalerDao salerDao;
  late SalerReviewDao salerReviewDao;

  late final String path;

  late List<Saler> _salers;

  @override
  void initState() {
    super.initState();

    $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .build()
        .then((value) async {
      this.database = value;
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      path = appDocumentsDirectory.path + '/images';
      salerDao = database.salerDao;
      salerReviewDao = database.salerReviewDao;

      if (!await Directory(path).exists()) {
        Directory _new = await Directory(path).create(recursive: true);
      }

      _salers = await salerDao.findAllActifSalers();
    });
  }

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
            for (int i =0; i<_salers.length; i++) 
              Text(_salers[i].name)
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
