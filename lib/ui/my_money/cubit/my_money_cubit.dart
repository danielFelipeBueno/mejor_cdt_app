
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mejor_cdt_app/domain/models/investment_model.dart';
import 'package:mejor_cdt_app/domain/usecases/investments_use_case.dart';
import 'package:http/http.dart' as http;

part 'my_money_state.dart';

class MyMoneyCubit extends Cubit<MyMoneyState> {
  
  final InvestmentsUseCase _investmentsUseCase;

  MyMoneyCubit(this._investmentsUseCase) : super(MyMoneyState());

  /// Genera las inversiones del usuario (simuladas o calculadas) y actualiza el estado.
  Future<void> generateInvestments() async {
    List<Investment> investments = await _investmentsUseCase.generateUserInvestments();
    emit(state.copyWith(investments: investments));
    calculateTotals();
  }

  /// Obtiene las inversiones reales del usuario desde la base de datos o backend.
  Future<void> getInvestments() async {
    List<Investment> investments = await _investmentsUseCase.getInvestments();
    emit(state.copyWith(investments: investments));
    calculateTotals();
  }

  /// Retorna la fecha/hora de la última actualización de datos del usuario.
  Future<String> getLastUpdate() async {
    return await _investmentsUseCase.getLastConnection();
  }

  /// Cierra sesión del usuario y reinicia el estado.
  Future<void> logout() async {
    await _investmentsUseCase.logout();
    emit(MyMoneyState());
  }

  void calculateTotals() {
    // Total invertido
    final double totalInvestment = state.investments.fold(0.0, (sum, inv) => sum + inv.amount);

    // Ganancia total
    final double totalProfit = state.investments.fold(0.0, (sum, inv) => sum + inv.roi);

    // Porcentaje de crecimiento
    final double growthPercentage = totalInvestment > 0
        ? (totalProfit / totalInvestment) * 100
        : 0.0;

    emit(state.copyWith(
      totalInvestment: totalInvestment,
      totalProfit: totalProfit,
      growthPercentage: growthPercentage,
    ));
  }

}
