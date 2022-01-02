import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/Bloc/Database/database_bloc.dart';
import 'package:diademe/Bloc/Database/database_state.dart';
import 'package:diademe/Components/textfield.dart';
import 'package:diademe/Models/Saler.dart';
import 'package:diademe/Models/SalerReview.dart';
import 'package:diademe/pages/review_done.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Components/colorButton.dart';
import 'package:diademe/Locale/locales.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewPage extends StatefulWidget {
  final Saler saler;

  const ReviewPage({Key? key, required this.saler}) : super(key: key);
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late LoadedDatabaseState _databaseState;

  TextEditingController _commentFieldController = TextEditingController();
  late double _mark;

  @override
  void initState() {
    _databaseState =
        BlocProvider.of<DatabaseBloc>(context).state as LoadedDatabaseState;
    _mark = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: FadedSlideAnimation(
            Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 25),
                        //width: MediaQuery.of(context).size.height - 100 > 360 ? 360: MediaQuery.of(context).size.height - 100 ,
                        width: 280,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            child: Card(
                              elevation: 1.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(300),
                                  side: BorderSide(
                                      width: 3,
                                      color: Theme.of(context).primaryColor)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(300),
                                child: Image.file(
                                  File(_databaseState.path +
                                      '/' +
                                      widget.saler.image),
                                  fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white54,
                                  blurRadius: 5.0,
                                  offset: Offset(0, 15),
                                  spreadRadius: 0.5,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(300),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RatingBar(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.only(right: 8),
                            // itemBuilder: (context, _) =>
                            //     Icon(Icons.star, color: Colors.amber),
                            ratingWidget: RatingWidget(
                              full: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(Icons.star_border,
                                      size: 250, color: Colors.amber),
                                  Icon(Icons.star,
                                      size: 120, color: Colors.amber),
                                ],
                              ),
                              half: Icon(Icons.star_border,
                                  size: 90, color: Colors.amber),
                              empty: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(Icons.star_border,
                                      size: 250, color: Colors.grey[350]),
                                  Icon(Icons.star,
                                      size: 120, color: Colors.grey[350]),
                                ],
                              ),
                            ),
                            itemSize: 90,
                            onRatingUpdate: (rating) {
                              _mark = rating;
                              print(rating);
                            },
                          ),
                          SizedBox(height: 25),
                          Container(
                            width: 450,
                            child: EntryField('Un commentaire ?',
                                maxLines: 3,
                                fontSize: 20,
                                textFieldController: _commentFieldController),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(flex: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: ColorButton("Retour",
                            height: 55, width: 180, fontSize: 25),
                      ),
                      Spacer(flex: 3),
                      GestureDetector(
                        onTap: () {
                          if (_mark > 0) {
                            showDialog<void>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text(
                                          "Confirmez-vous votre feedback?",
                                          softWrap: true,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 20)),
                                      content: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(right: 15),
                                                width: 150,
                                                child: AspectRatio(
                                                  aspectRatio: 1,
                                                  child: Container(
                                                    child: Card(
                                                      elevation: 1.0,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      300),
                                                          side: BorderSide(
                                                              width: 3,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor)),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(300),
                                                        child: Image.file(
                                                          File(_databaseState
                                                                  .path +
                                                              '/' +
                                                              widget
                                                                  .saler.image),
                                                          fit: BoxFit.fill,
                                                          alignment:
                                                              Alignment.center,
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.white54,
                                                          blurRadius: 5.0,
                                                          offset: Offset(0, 15),
                                                          spreadRadius: 0.5,
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              300),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  RatingBar(
                                                    ignoreGestures: true,
                                                    initialRating: _mark,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: false,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        EdgeInsets.only(
                                                            right: 8),
                                                    // itemBuilder: (context, _) =>
                                                    //     Icon(Icons.star, color: Colors.amber),
                                                    ratingWidget: RatingWidget(
                                                      full: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Icon(
                                                              Icons.star_border,
                                                              size: 250,
                                                              color:
                                                                  Colors.amber),
                                                          Icon(Icons.star,
                                                              size: 120,
                                                              color:
                                                                  Colors.amber),
                                                        ],
                                                      ),
                                                      half: Icon(
                                                          Icons.star_border,
                                                          size: 90,
                                                          color: Colors.amber),
                                                      empty: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Icon(
                                                              Icons.star_border,
                                                              size: 250,
                                                              color: Colors
                                                                  .grey[350]),
                                                          Icon(Icons.star,
                                                              size: 120,
                                                              color: Colors
                                                                  .grey[350]),
                                                        ],
                                                      ),
                                                    ),
                                                    itemSize: 60,
                                                    onRatingUpdate: (rating) {
                                                      _mark = rating;
                                                      print(rating);
                                                    },
                                                  ),
                                                  if (_commentFieldController
                                                      .text.isNotEmpty)
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 15),
                                                      width: 300,
                                                      child: Text(
                                                          _commentFieldController
                                                              .text,
                                                          softWrap: true),
                                                    ),
                                                  SizedBox(height: 30),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: ColorButton("Retour",
                                                    height: 45,
                                                    width: 150,
                                                    fontSize: 20),
                                              ),
                                              Spacer(flex: 3),
                                              GestureDetector(
                                                onTap: () {
                                                  _databaseState.salerReviewDao
                                                      .insertSalerReview(SalerReview(
                                                          salerId:
                                                              widget.saler.id!,
                                                          mark: _mark.toInt(),
                                                          comment:
                                                              _commentFieldController
                                                                  .text,
                                                          date: DateTime.now()
                                                              .millisecondsSinceEpoch));
                                                  Navigator.pop(context);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ReviewDone()));
                                                },
                                                child: ColorButton("Confirmer",
                                                    height: 45,
                                                    width: 150,
                                                    fontSize: 20),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.orange,
                                  content: Text('Veuillez attribuer une note',
                                      style: TextStyle(fontSize: 21))),
                            );
                          }
                        },
                        child: ColorButton("Continuer",
                            height: 55, width: 180, fontSize: 25),
                      ),
                      Spacer(),
                    ],
                  ),
                  Spacer()
                ],
              ),
            ),
            beginOffset: Offset(0.0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
        ),
      ),
    );
  }
}
