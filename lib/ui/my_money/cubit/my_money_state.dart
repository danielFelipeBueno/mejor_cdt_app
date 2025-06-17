part of 'my_money_cubit.dart';

class MyMoneyState {
  /// Lista de inversiones del usuario. Puede estar vacía si aún no se han cargado.
  final List<Investment> investments;
  final double totalInvestment, totalProfit, growthPercentage;


  MyMoneyState({
    this.investments = const [],
    this.totalInvestment = 0,
    this.totalProfit = 0,
    this.growthPercentage = 0
  });

  MyMoneyState copyWith({
    List<Investment>? investments,
    double? totalInvestment,
    double? totalProfit,
    double? growthPercentage
  }) {
    return MyMoneyState(
      investments: investments ?? this.investments,
      totalInvestment: totalInvestment??this.totalInvestment,
      totalProfit: totalProfit??this.totalProfit,
      growthPercentage: growthPercentage??this.growthPercentage
    );
  }
}
