

import 'package:flutter/material.dart';
import 'package:mejor_cdt_app/data/local_database_repository.dart';
import 'package:mejor_cdt_app/domain/models/investment_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


String sqlScript ='''
CREATE TABLE IF NOT EXISTS investments (
  id TEXT PRIMARY KEY,
  amount REAL NOT NULL,
  rate REAL NOT NULL,
  start_date TEXT NOT NULL,
  end_date TEXT NOT NULL,
  roi REAL NOT NULL,
  status INTEGER NOT NULL,
  bank_name TEXT NOT NULL,
  created_at TEXT NOT NULL
);
''';

class LocalDatabaseImpl extends LocalDatabaseRepository {
  @override
  Future<Database> openLocalDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'investments.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: _onCreateDatabase,
  );
}

  Future<void> _onCreateDatabase(Database db, int version) async {
    debugPrint("onCreate ejecutado.");
    for (final statement in sqlScript.split(';')) {
      final trimmed = statement.trim();
      if (trimmed.isEmpty) continue;
      try {
        await db.execute(trimmed);
        debugPrint("Ejecutado: $trimmed");
      } catch (e) {
        debugPrint("Error ejecutando $trimmed: $e");
      }
    }
  }
  
  @override
  Future<List<Map<String, dynamic>>> readAllInvestments() async {
    final db = await openLocalDatabase();
    final List<Map<String, dynamic>> maps = await db.query('investments');
    print('---REGISTROS EN LA BASE DE DATOS: ${maps.length}');
    return maps;
  }

  @override
  Future<void> insertInvestments(List<Investment> investments) async {
    final db = await openLocalDatabase();

    final batch = db.batch();
    int i = 0;
    for (final investment in investments) {
      i++;
      print('---INSERTADO EN LA BASE DE DATOS: $i');
      batch.insert(
        'investments',
        investment.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<void> deleteAllInvestments() async {
    final db = await openLocalDatabase();
    print('---BORRANDO REGISTROS');
    await db.delete('investments');
  }


  @override
  Future<void> deleteLocalDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'investments.db');
    print('---BORRANDO BASE DE DATOS');
    await databaseFactory.deleteDatabase(path);
  }
}