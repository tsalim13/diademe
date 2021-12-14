import 'package:diademe/Models/Saler.dart';
import 'package:floor/floor.dart';

@dao
abstract class SalerDao {
  @Query('SELECT * FROM Saler')
  Future<List<Saler>> findAllSalers();

  @Query('SELECT * FROM Saler WHERE actif = ''1''')
  Future<List<Saler>> findAllActifSalers();

  @Query('SELECT * FROM Saler WHERE id = :id')
  Future<Saler?> findSalerById(int id);
  //stream

  @insert
  Future<void> insertSaler(Saler saler);

  @update
  Future<void> updateSaler(Saler saler);

  @delete
  Future<void> deleteSaler(Saler saler);
}