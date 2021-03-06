import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/Bloc/Database/database_bloc.dart';
import 'package:diademe/Bloc/Database/database_state.dart';
import 'package:diademe/Models/Saler.dart';
import 'package:diademe/pages/edit_saler.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Locale/locales.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ListSalersPage extends StatefulWidget {
  @override
  _ListSalersState createState() => _ListSalersState();
}

class _ListSalersState extends State<ListSalersPage> {
  late LoadedDatabaseState _databaseState;

  List<Saler> _salers = [];
  bool isLoading = true;

  @override
  void initState() {
    _databaseState =
        BlocProvider.of<DatabaseBloc>(context).state as LoadedDatabaseState;
    fetchSalers();
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.portraitUp,
    //     DeviceOrientation.portraitDown,
    // ]);
  }

  Future<void> fetchSalers() async {
    _salers = await _databaseState.salerDao.findAllSalers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  dispose() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Liste des vendeurs'),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: FittedBox(
                  child: DataTable(
                    // sortColumnIndex: 1,
                    // sortAscending: true,
                    columns: [
                      DataColumn(
                        label: Text(
                          'Image',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Nom',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'T??l??phoe',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Date de naissance',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Date de d??but',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Actif',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Actions',
                        ),
                      ),
                    ],
                    rows: [
                      for (int i = 0; i < _salers.length; i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Container(
                                width: 50,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    child: Card(
                                      elevation: 1.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(300),
                                          side: BorderSide(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(300),
                                        child: Image.file(
                                          File(_databaseState.path +
                                              '/' +
                                              _salers[i].image),
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
                            ),
                            DataCell(ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: width *0.2),
                              child: Text(_salers[i].name))),
                            DataCell(Text(_salers[i].phone)),
                            DataCell(Text(_salers[i].birthday)),
                            DataCell(Text(_salers[i].startday)),
                            DataCell(_salers[i].actif
                                ? Icon(Icons.check, color: Colors.green)
                                : Icon(Icons.dangerous_outlined,
                                    color: Colors.red)),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditSaler(saler: _salers[i])));
                                        setState(() {
                                          isLoading = true;
                                        });
                                        _salers = await _databaseState.salerDao.findAllSalers();
                                        setState(() {
                                          isLoading = false;
                                        });
                                    }, 
                                    icon: Icon(Icons.edit, color: Colors.blue)),
                                IconButton(
                                    onPressed: () {
                                      showDialog<void>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    //title: const Text('AlertDialog Title'),
                                    content: Text('??tes-vous s??r de vouloir supprimer le vendeur "'+_salers[i].name+"\"?",
                                    style: Theme.of(context).textTheme.bodyText1),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: const Text('Annuler'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await _databaseState.salerDao.deleteSaler(_salers[i]);
                                          _salers = await _databaseState.salerDao.findAllSalers();
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        child: Text('Supprimer', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ));
                        
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red))
                              ],
                            )),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
        beginOffset: Offset(0.0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
