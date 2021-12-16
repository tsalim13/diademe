import 'package:equatable/equatable.dart';

abstract class DatabaseEvent extends Equatable {

}

class LoadDatabaseEvent extends DatabaseEvent {
  @override
  List<Object?> get props => [];

}