


import 'dart:convert';
import 'dart:developer';

import 'package:mejor_cdt_app/data/auth_repository.dart';
import 'package:mejor_cdt_app/data/secure_storage_repository.dart';
import 'package:mejor_cdt_app/domain/models/user_model.dart';

class AuthUseCase {
  final AuthRepository _authRepository;
  final SecureStorageRepository _secureStorageRepository;

  AuthUseCase(
    this._authRepository,
    this._secureStorageRepository
  );

  Future<User> createUser(String name, String email) async {
    final response = await _authRepository.createUser(name, email);
    log(response.statusCode.toString());
    log(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final user = User.fromJson(json);
      bool resultUserId = await _secureStorageRepository.updateUserId(user.id);
      bool resultUserName = await _secureStorageRepository.updateUserName(user.id, user.name);
      if(resultUserId&&resultUserName){
        return user;
      }else{
        throw Exception('Error al guardar la información');
      }
    } else if (response.statusCode == 400){
      throw Exception('El usuario ya existe');
    }else{
      throw Exception('Error al crear el usuario: ${response.statusCode}');
    }
  }

  Future<bool> isAuthenticated () async {
    String? userId = await _secureStorageRepository.readUserId();
    if(userId!=null) return true;
    return false;
  }

  Future<String?> readUserName () async {
    String? userId = await _secureStorageRepository.readUserId();
    if(userId!=null){
      String? userName = await _secureStorageRepository.readUserName(userId);
      if(userName!=null){
        return userName;
      }
    }
    return null;
  }

  Future<void> logout () async {
    String? userId = await _secureStorageRepository.readUserId();
    if(userId!=null){
      await _secureStorageRepository.deleteLastUpdate(userId);
      await _secureStorageRepository.deleteUserName(userId);
      await _secureStorageRepository.deleteUserId();
    }
  }
  
}