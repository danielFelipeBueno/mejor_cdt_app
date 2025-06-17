import 'package:http/http.dart' as http;
import 'package:mejor_cdt_app/data/investment_repository.dart';
import 'package:mejor_cdt_app/utils/backend_settings.dart';

class InvestmentsImpl extends InvestmentRepository {
  @override
  Future<http.Response> generateUserInvestments(String userId)async{
    final url = Uri.parse(generateUserInvestmentsUrl+userId);
    final header = {'accept': 'application/json'};
    return await http.post(url, headers: header);
  }
  @override
  Future<http.Response> getInvestments(String userId)async{
    final url = Uri.parse(getInvestmentsUrl+userId);
    final header = {'accept': 'application/json'};
    return await http.get(url, headers: header);
  }
}