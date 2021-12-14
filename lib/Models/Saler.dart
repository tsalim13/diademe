import 'package:floor/floor.dart';

@entity
class Saler {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String phone;
  final String birthday;
  final String startday;
  final bool actif;
  final String image;

  Saler({this.id, required this.name, required this.phone, required this.birthday, required this.startday, required this.actif, required this.image});
}