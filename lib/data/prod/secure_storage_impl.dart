
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mejor_cdt_app/data/secure_storage_repository.dart';

const _userIdKey = 'userId';
const _userNameKey = 'userName';
const _lastUpdate = 'lastUpdate';

class SecureStorageImpl extends SecureStorageRepository {

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<String?> readUserId() async {
    return await _storage.read(key: _userIdKey);
  }

  @override
  Future<bool> updateUserId(String userId) async {
    try{
      await _storage.write(key: _userIdKey, value: userId);
      return true;
    }catch(_){
      return false;
    }
  }

  @override
  Future deleteUserId()async{
    return await _storage.delete(key: _userIdKey);
  }

  @override
  Future<String?> readUserName(String userId) async {
    return await _storage.read(key: userId + _userNameKey);
  }

  @override
  Future<bool> updateUserName(String userId, String userName) async {
    try{
      await _storage.write(key: userId + _userNameKey, value: userName);
      return true;
    }catch(_){
      return false;
    }
  }

  @override
  Future deleteUserName(String userId)async{
    return await _storage.delete(key: userId + _userNameKey);
  }

  @override
  Future<String?> readLastUpdate(String userId) async {
    return await _storage.read(key: userId + _lastUpdate);
  }

  @override
  Future<bool> updateLastUpdate(String userId, String lastUpdate) async {
    try{
      await _storage.write(key: userId + _lastUpdate, value: lastUpdate);
      return true;
    }catch(_){
      return false;
    }
  }

  @override
  Future deleteLastUpdate(String userId)async{
    return await _storage.delete(key: userId + _lastUpdate);
  }
}