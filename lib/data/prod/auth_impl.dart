import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mejor_cdt_app/data/auth_repository.dart';
import 'package:mejor_cdt_app/utils/backend_settings.dart';

class AuthImpl extends AuthRepository{
  @override
  Future<http.Response> createUser(String name, String email)async{
    final url = Uri.parse(createUserUrl);
    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode({
      'name': name,
      'email': email,
    });
    return await http.post(url, headers: headers, body: body);
  }
}