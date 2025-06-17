
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mejor_cdt_app/data/investment_repository.dart';
import 'package:mejor_cdt_app/data/local_database_repository.dart';
import 'package:mejor_cdt_app/data/secure_storage_repository.dart';
import 'package:mejor_cdt_app/domain/models/investment_model.dart';

class InvestmentsUseCase {
  final InvestmentRepository _investmentRepository;
  final SecureStorageRepository _secureStorageRepository;
  final LocalDatabaseRepository _localDatabaseRepository;

  InvestmentsUseCase(
    this._investmentRepository,
    this._secureStorageRepository,
    this._localDatabaseRepository
  );

  Future<List<Investment>> generateUserInvestments() async {
    String? userId = await _secureStorageRepository.readUserId();
    if (userId != null) {
      var response = await _investmentRepository.generateUserInvestments(userId);
      if (response.statusCode == 200) {Future<List<Investment>> getInvestments() async {
    try {
      String? userId = await _secureStorageRepository.readUserId();
      if (userId == null) return [];

      String? lastUpdate;
      try {
        lastUpdate = await _secureStorageRepository.readLastUpdate(userId);
      } catch (e) {
        debugPrint('Error leyendo lastUpdate: $e');
      }

      bool shouldUpdate = false;

      if (lastUpdate == null) {
        shouldUpdate = true;
      } else {
        try {
          DateTime date = DateTime.parse(lastUpdate);
          Duration difference = DateTime.now().difference(date);
          if (difference.inHours >= 1) {
            shouldUpdate = true;
          }
        } catch (e) {
          debugPrint('Error parseando fecha: $e');
          shouldUpdate = true; // fallback a update
        }
      }

      if (shouldUpdate) {
        try {
          var response = await _investmentRepository.getInvestments(userId);
          if (response.statusCode == 200) {
            final List<dynamic> jsonList = jsonDecode(response.body);

            try {
              await _localDatabaseRepository.deleteAllInvestments();
              List<Investment> investmets =
                  jsonList.map((e) => Investment.fromJson(e)).toList();
              await _localDatabaseRepository.insertInvestments(investmets);
              return investmets;
            } catch (e) {
              debugPrint('Error guardando en base de datos local: $e');
            }
          } else {
            debugPrint('Error en response: ${response.statusCode}');
          }
        } catch (e) {
          debugPrint('Error haciendo request remoto: $e');
        }
      }

      try {
        List<Map<String, dynamic>> jsonInvestments =
            await _localDatabaseRepository.readAllInvestments();
        return jsonInvestments
            .map((map) => Investment.fromDatabase(map))
            .toList();
      } catch (e) {
        debugPrint('Error leyendo de base de datos local: $e');
      }
    } catch (e) {
      debugPrint('Error general en getInvestments: $e');
    }
    return [];
  }

        await _secureStorageRepository.updateLastUpdate(userId, DateTime.now().toString());
        final List<dynamic> jsonList = jsonDecode(response.body);
        await _localDatabaseRepository.deleteAllInvestments();
        List<Investment> investmets = jsonList.map((e) => Investment.fromJson(e)).toList();
        await _localDatabaseRepository.insertInvestments(investmets);
        return investmets;
      }
    }
    return [];
  }

  Future<List<Investment>> getInvestments() async {
    try {
      String? userId = await _secureStorageRepository.readUserId();
      if (userId == null) return [];
  
      String? lastUpdate;
      try {
        lastUpdate = await _secureStorageRepository.readLastUpdate(userId);
      } catch (e) {
        debugPrint('Error leyendo lastUpdate: $e');
      }
  
      bool shouldUpdate = false;
  
      if (lastUpdate == null) {
        shouldUpdate = true;
      } else {
        try {
          DateTime date = DateTime.parse(lastUpdate);
          Duration difference = DateTime.now().difference(date);
          if (difference.inHours >= 1) {
            shouldUpdate = true;
          }
        } catch (e) {
          debugPrint('Error parseando fecha: $e');
          shouldUpdate = true; // fallback a update
        }
      }
  
      if (shouldUpdate) {
        try {
          var response = await _investmentRepository.getInvestments(userId);
          if (response.statusCode == 200) {
            await _secureStorageRepository.updateLastUpdate(userId, DateTime.now().toString());
            final List<dynamic> jsonList = jsonDecode(response.body);
  
            try {
              await _localDatabaseRepository.deleteAllInvestments();
              List<Investment> investmets =
                  jsonList.map((e) => Investment.fromJson(e)).toList();
              await _localDatabaseRepository.insertInvestments(investmets);
              return investmets;
            } catch (e) {
              debugPrint('Error guardando en base de datos local: $e');
            }
          } else {
            debugPrint('Error en response: ${response.statusCode}');
          }
        } catch (e) {
          debugPrint('Error haciendo request remoto: $e');
        }
      }
  
      try {
        List<Map<String, dynamic>> jsonInvestments =
            await _localDatabaseRepository.readAllInvestments();
        return jsonInvestments
            .map((map) => Investment.fromDatabase(map))
            .toList();
      } catch (e) {
        debugPrint('Error leyendo de base de datos local: $e');
      }
    } catch (e) {
      debugPrint('Error general en getInvestments: $e');
    }
  
    return [];
  }

  Future<String> getLastConnection()async{

    String? userId = await _secureStorageRepository.readUserId();
    if(userId!=null){
      String? lastUpdate = await _secureStorageRepository.readLastUpdate(userId);
      print('LAST CONNECTION: ${lastUpdate}');
      if(lastUpdate!=null){
        DateTime date = DateTime.parse(lastUpdate);
        return formatDateTime(date);
      }
    }
    return '';
  }

  Future<void>logout()async{
    await _localDatabaseRepository.deleteLocalDatabase();
  }

  String formatDateTime(DateTime dateTime) {
    final time = DateFormat('h:mm a', 'es_ES').format(dateTime);      
    final day = DateFormat('d', 'es_ES').format(dateTime);            
    final month = DateFormat('MMMM', 'es_ES').format(dateTime);       
  
    return '$time de $day de $month';
  }
}