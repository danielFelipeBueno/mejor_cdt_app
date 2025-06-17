
import 'package:mejor_cdt_app/domain/models/investment_model.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class LocalDatabaseRepository {
  Future<Database> openLocalDatabase();
  Future<List<Map<String, dynamic>>> readAllInvestments();
  Future<void> insertInvestments(List<Investment> investments);
  Future<void> deleteAllInvestments();
  Future<void> deleteLocalDatabase();
}