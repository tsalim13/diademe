import 'package:diademe/Models/Saler.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'saler_review',
  foreignKeys: [
    ForeignKey(
      childColumns: ['saler_id'],
      parentColumns: ['id'],
      entity: Saler,
    )
  ],
)
class SalerReview {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'saler_id')
  final int salerId;
  final int mark;
  final String comment;
  final int date;

  SalerReview({this.id, required this.salerId, required this.mark, required this.comment, required this.date});
}