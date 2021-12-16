import 'package:diademe/Dao/SalerDao.dart';
import 'package:diademe/Dao/SalerReviewDao.dart';
import 'package:diademe/database/database.dart';
import 'package:equatable/equatable.dart';

abstract class DatabaseState extends Equatable {

}

class InitialDatabaseState extends DatabaseState {
  @override
  List<Object?> get props => [];

}

class LoadedDatabaseState extends DatabaseState {
  final AppDatabase database;
  final String path;
  final SalerDao salerDao;
  final SalerReviewDao salerReviewDao;

  LoadedDatabaseState(this.database, this.path, this.salerDao, this.salerReviewDao);

  @override
  List<Object?> get props => [database, path, salerDao, salerReviewDao];

}