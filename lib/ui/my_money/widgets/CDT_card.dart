

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mejor_cdt_app/domain/models/investment_model.dart';
import 'package:mejor_cdt_app/utils/constants.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CDTCard extends StatelessWidget {
  const CDTCard({
    super.key,
    required this.investment
  });

  final Investment investment;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: kGrey),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: kGrey,
                radius: 25,
                child: Image.asset('assets/bank-icon.png', height: 29),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 24,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(
                              child: Text('${(investment.rate*100).toStringAsFixed(1)}% EA',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                            child: Center(
                              child: Text(formatCurrency(investment.amount),
                                style: const TextStyle(fontSize: 20, height: 1, fontWeight: FontWeight.w500)
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(investment.bankName,
                            style: h6TextStyle ,
                          ),
                          Text("+${formatCurrency(investment.roi)}",
                            style: h4TextStyle.copyWith(color: kPrimaryColor),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              SfLinearGauge(
                showTicks: false,
                showLabels: false,
                animateAxis: true,
                axisTrackStyle: const LinearAxisTrackStyle(
                  color: Colors.transparent,
                  thickness: 10,
                  edgeStyle: LinearEdgeStyle.bothCurve,
                  borderWidth: 1,
                  borderColor: Colors.transparent
                ),
                barPointers: <LinearBarPointer>[
                  LinearBarPointer(
                    value: calcularPorcentajeProgreso(investment.startDate, investment.endDate),
                    thickness: 18,
                    edgeStyle: LinearEdgeStyle.bothCurve,
                    color: kSecondaryColor,
                  ),
                ],
              ),
              SfLinearGauge(
                showTicks: false,
                showLabels: false,
                animateAxis: true,
                axisTrackStyle: const LinearAxisTrackStyle(
                  color: Colors.transparent,
                  thickness: 18,
                  edgeStyle: LinearEdgeStyle.bothCurve,
                  borderWidth: 1,
                  borderColor: kPrimaryColor,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(diasRestantesTexto(investment.startDate, investment.endDate), style: h6TextStyle),
              Text(formatearFecha(investment.endDate), style: h6TextStyle),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              TextButton(
                onPressed: (){}, 
                child: const Text('Retirar')
              ),
              const Spacer(),
              TextButton(
                onPressed: (){}, 
                child: const Text('Vender')
              ),
              const Spacer(),
              TextButton(
                onPressed: (){},
                child: const Text('Reinvertir')
              )
            ],
          )
        ],
      ),
    );
  }
}


String formatCurrency(double value) {
  final formatter = NumberFormat.currency(
    locale: 'es_CO',
    symbol: '\$',
    decimalDigits: 0,
    customPattern: '\u00A4#,##0' // \u00A4 representa el símbolo de moneda
  );

  return formatter.format(value);
}

double calcularPorcentajeProgreso(DateTime startDate, DateTime endDate) {
  final hoy = DateTime.now();

  final totalDias = endDate.difference(startDate).inDays;
  final diasTranscurridos = hoy.difference(startDate).inDays;

  if (hoy.isBefore(startDate)) return 0;
  if (hoy.isAfter(endDate)) return 100;

  final porcentaje = (diasTranscurridos / totalDias) * 100;
  return porcentaje.clamp(0, 100); // asegura que esté entre 0 y 100
}

String diasRestantesTexto(DateTime startDate, DateTime endDate) {
  final hoy = DateTime.now();
  if (hoy.isAfter(endDate)) {
    return 'Completado';
  } else if (hoy.isBefore(startDate)) {
    final diasParaIniciar = startDate.difference(hoy).inDays;
    return 'Comienza en $diasParaIniciar días';
  } else {
    final diasRestantes = endDate.difference(hoy).inDays;
    return 'Faltan $diasRestantes días';
  }
}

String formatearFecha(DateTime fecha) {
  // Esto devuelve por ejemplo: "16 de agosto"
  return DateFormat("d 'de' MMMM", 'es_CO').format(fecha);
}
