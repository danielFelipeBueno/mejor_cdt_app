
import 'package:http/http.dart';

abstract class InvestmentRepository {
  Future<Response> generateUserInvestments(String userId);
  Future<Response> getInvestments(String userId);
}