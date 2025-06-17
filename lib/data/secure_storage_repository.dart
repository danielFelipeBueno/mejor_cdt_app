
abstract class SecureStorageRepository{
  Future<String?> readUserId();
  Future<bool> updateUserId(String userId);
  Future<void> deleteUserId();
  Future<String?> readUserName(String userId);
  Future<bool> updateUserName(String userId, String userName);
  Future<void> deleteUserName(String userId);
  Future<String?> readLastUpdate(String userId);
  Future<bool> updateLastUpdate(String userId, String lastUpdate);
  Future<void> deleteLastUpdate(String userId);

}