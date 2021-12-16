import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/Bloc/Database/database_bloc.dart';
import 'package:diademe/Bloc/Database/database_event.dart';
import 'package:diademe/Bloc/Database/database_state.dart';
import 'package:diademe/Models/Saler.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Locale/locales.dart';
import 'package:diademe/pages/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Saler> _salers = [];
  bool isLoading = true;
  late final int fittingCount;

  static const CROSS_AXIS_COUNT = 5;
  late double h;

  @override
  void initState() {
    BlocProvider.of<DatabaseBloc>(context).add(LoadDatabaseEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<DatabaseBloc, DatabaseState>(
        listener: (context, state) async {
          if (state is LoadedDatabaseState) {
            _salers = await state.salerDao.findAllActifSalers();
            setState(() {
              fittingCount = _salers.length - _salers.length % CROSS_AXIS_COUNT;
              isLoading = false;
            });
          }
        },
        builder: (context, state) {
          return state is InitialDatabaseState || isLoading
              ? Center(child: CircularProgressIndicator())
              : FadedSlideAnimation(
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onDoubleTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginUi()));
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
                                                  color: Colors.black,
                                                  fontSize: 40)),
                                          TextSpan(
                                              text: 'Feedback',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 40)),
                                        ]),
                                  ),
                                  durationInMilliseconds: 600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: h-180,
                          alignment: Alignment.center,
                          child: LayoutBuilder(builder: (context, constraints) {
                            return StaggeredGridView.countBuilder(
                                crossAxisCount: CROSS_AXIS_COUNT,
                                shrinkWrap: true,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                itemCount: _salers.length == fittingCount
                                    ? fittingCount
                                    : fittingCount + 1,
                                itemBuilder: (context, index) {
                                  if (index < fittingCount) {
                                    return AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        child: Card(
                                          elevation: 5.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(300),
                                            side: BorderSide(width: 2, color: Theme.of(context).primaryColor)
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(300),
                                            child: Center(
                                              child: Image.file(
                                                File(
                                                    (state as LoadedDatabaseState)
                                                            .path +
                                                        "/" +
                                                        _salers[index].image),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white54,
                                              blurRadius: 5.0,
                                              offset: Offset(0, 10),
                                              spreadRadius: 0.5,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: _salers
                                            .sublist(
                                                fittingCount, _salers.length)
                                            .map((m) {
                                          return Container(
                                            width: constraints.maxWidth /
                                                    CROSS_AXIS_COUNT -
                                                10,
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: Container(
                                                child: Card(
                                                  elevation: 5.0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            300),
                                                    side: BorderSide(width: 3, color: Theme.of(context).primaryColor)
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            300),
                                                    child: Center(
                                                      child: Image.file(
                                                        File(
                                                            (state as LoadedDatabaseState)
                                                                    .path +
                                                                "/" +
                                                                _salers[index]
                                                                    .image),
                                                        fit: BoxFit.fill,
                                                      ),
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
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList());
                                  }
                                },
                                staggeredTileBuilder: (int index) {
                                  if (index < fittingCount) {
                                    return StaggeredTile.count(1, 1);
                                  } else {
                                    return StaggeredTile.count(
                                        CROSS_AXIS_COUNT, 1);
                                  }
                                });
                          }),
                        ),
                        Spacer(),
                        FadedScaleAnimation(
                          Row(
                            children: [
                              Text(locale.giveYour!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          letterSpacing: 1, fontSize: 25)),
                              SizedBox(
                                width: 5,
                              ),
                              Text(locale.feedback!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
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
                      ],
                    ),
                  ),
                  beginOffset: Offset(0.0, 0.3),
                  endOffset: Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                );
        },
      ),
    );
  }
}
