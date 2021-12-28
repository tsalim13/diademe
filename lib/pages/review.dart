import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/Bloc/Database/database_bloc.dart';
import 'package:diademe/Bloc/Database/database_state.dart';
import 'package:diademe/Components/textfield.dart';
import 'package:diademe/Models/Saler.dart';
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
      body: FadedSlideAnimation(
        Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 50),
                    width: 350,
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
                              Icon(Icons.star, size: 120, color: Colors.amber),
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
                        itemSize: 80,
                        onRatingUpdate: (rating) {
                          _mark = rating;
                          print(rating);
                        },
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 430,
                        child: EntryField('Un commentaire ?',
                            maxLines: 3,
                            fontSize: 23,
                            textFieldController: _commentFieldController),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ColorButton(locale.cancel,
                        height: 55, width: 200, fontSize: 27),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                //title: const Text('AlertDialog Title'),
                                content: Column(
                                  mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(right: 20),
                                          width: 170,
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                              child: Card(
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(300),
                                                    side: BorderSide(
                                                        width: 3,
                                                        color: Theme.of(context)
                                                            .primaryColor)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(300),
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
                                                borderRadius:
                                                    BorderRadius.circular(300),
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
                                                  EdgeInsets.only(right: 8),
                                              // itemBuilder: (context, _) =>
                                              //     Icon(Icons.star, color: Colors.amber),
                                              ratingWidget: RatingWidget(
                                                full: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Icon(Icons.star_border,
                                                        size: 250,
                                                        color: Colors.amber),
                                                    Icon(Icons.star,
                                                        size: 120,
                                                        color: Colors.amber),
                                                  ],
                                                ),
                                                half: Icon(Icons.star_border,
                                                    size: 90, color: Colors.amber),
                                                empty: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Icon(Icons.star_border,
                                                        size: 250,
                                                        color: Colors.grey[350]),
                                                    Icon(Icons.star,
                                                        size: 120,
                                                        color: Colors.grey[350]),
                                                  ],
                                                ),
                                              ),
                                              itemSize: 55,
                                              onRatingUpdate: (rating) {
                                                _mark = rating;
                                                print(rating);
                                              },
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: 250,
                                              child: Text(_commentFieldController.text, softWrap: true),
                                            ),
                                            SizedBox(height: 30),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Text("Confirmez vous votre feedback?", softWrap: true, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 25)),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context),
                                    child: const Text('Annuler'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context),
                                    child: const Text('Confirmer'),
                                  ),
                                ],
                              ));
                    },
                    child: ColorButton(locale.continueText,
                        height: 55, width: 200, fontSize: 27),
                  ),
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
    );
  }
}
