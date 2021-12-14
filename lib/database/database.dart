import 'dart:async';
import 'package:diademe/Dao/SalerDao.dart';
import 'package:diademe/Dao/SalerReviewDao.dart';
import 'package:diademe/Models/Saler.dart';
import 'package:diademe/Models/SalerReview.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Saler, SalerReview])
abstract class AppDatabase extends FloorDatabase {
  SalerDao get salerDao;
  SalerReviewDao get salerReviewDao;
}