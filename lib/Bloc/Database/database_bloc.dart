import 'dart:io';

import 'package:diademe/Bloc/Database/database_event.dart';
import 'package:diademe/Bloc/Database/database_state.dart';
import 'package:diademe/Dao/SalerDao.dart';
import 'package:diademe/Dao/SalerReviewDao.dart';
import 'package:diademe/database/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseBloc() : super(InitialDatabaseState());

  @override
  Stream<DatabaseState> mapEventToState(event) async* {
    if (event is LoadDatabaseEvent) {
      late AppDatabase database;
      late String path;
      late SalerDao salerDao;
      late SalerReviewDao salerReviewDao;

      database = await $FloorAppDatabase
          .databaseBuilder('app_database.db')
          .build();

      salerDao = database.salerDao;
        salerReviewDao = database.salerReviewDao;

      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      path = appDocumentsDirectory.path + '/images';

      if (!await Directory(path).exists()) {
        await Directory(path).create(recursive: true);
      }
      //await Future.delayed(Duration(seconds: 8));
      yield LoadedDatabaseState(database, path, salerDao, salerReviewDao);
    }
  }
}
