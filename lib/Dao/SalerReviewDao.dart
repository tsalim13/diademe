import 'package:diademe/Models/SalerReview.dart';
import 'package:floor/floor.dart';

@dao
abstract class SalerReviewDao {
  @Query('SELECT * FROM saler_review')
  Future<List<SalerReview>> findAllSalerReviews();

  @Query('SELECT * FROM saler_review WHERE id = :id')
  Future<SalerReview?> findSalerReviewById(int id);

  @Query('SELECT * FROM saler_review WHERE saler_id IN (:ids) AND date BETWEEN :start AND :end')
  Future<List<SalerReview>> findSalerReviewBySalerIdDateRange(List<int> ids, int start, int end);
  
  @Query('SELECT * FROM saler_review WHERE saler_id IN (:ids)')
  Future<List<SalerReview>> findSalerReviewBySalerId(List<int> ids);

  @insert
  Future<void> insertSalerReview(SalerReview salerReview);

  @update
  Future<void> updateSalerReview(SalerReview salerReview);

  @delete
  Future<void> deleteSalerReview(SalerReview salerReview);
}