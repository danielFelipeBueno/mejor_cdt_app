
import 'package:http/http.dart';

abstract class AuthRepository{
  Future<Response> createUser(String name, String email);
}