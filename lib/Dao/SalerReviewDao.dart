import 'package:diademe/Models/SalerReview.dart';
import 'package:floor/floor.dart';

@dao
abstract class SalerReviewDao {
  @Query('SELECT * FROM saler_review')
  Future<List<SalerReview>> findAllSalerReviews();

  @Query('SELECT * FROM saler_review WHERE id = :id')
  Future<SalerReview?> findSalerReviewById(int id);
  //stream

  @insert
  Future<void> insertSalerReview(SalerReview salerReview);

  @update
  Future<void> updateSalerReview(SalerReview salerReview);

  @delete
  Future<void> deleteSalerReview(SalerReview salerReview);
}