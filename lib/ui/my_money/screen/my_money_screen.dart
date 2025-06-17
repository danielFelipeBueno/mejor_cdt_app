
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mejor_cdt_app/ui/auth/cubit/auth_cubit.dart';
import 'package:mejor_cdt_app/ui/auth/screens/register_screen.dart';
import 'package:mejor_cdt_app/ui/my_money/cubit/my_money_cubit.dart';
import 'package:mejor_cdt_app/ui/my_money/widgets/CDT_card.dart';
import 'package:mejor_cdt_app/ui/my_money/widgets/app_bar_blur.dart';
import 'package:mejor_cdt_app/ui/my_money/widgets/point_data_investment.dart';
import 'package:mejor_cdt_app/ui/shared/main_background.dart';
import 'package:mejor_cdt_app/utils/constants.dart';
import 'package:mejor_cdt_app/utils/navigator_utils.dart';
import 'package:mejor_cdt_app/utils/size_config.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyMoneyScreen extends StatefulWidget {
  const MyMoneyScreen({super.key});

  @override
  State<MyMoneyScreen> createState() => _MyMoneyScreenState();
}

class _MyMoneyScreenState extends State<MyMoneyScreen> {

  String _valorSeleccionado = '1M';

  final Map<String, Widget> _opciones = const {
    '1M': Text('M'),
    '6M': Text('6M'),
    '1A': Text('A'),
    'ALL': Text('H'),
  };
  
  @override
  void initState() {
    context.read<MyMoneyCubit>().getInvestments();
    super.initState();
    checkConnection();
  }


  void checkConnection() async {
    print('PROBANDO INTERNET');
    bool connected = await context.read<AuthCubit>().hasInternetManually();
    print('HAY INTERNET: $connected');
    if (!connected && mounted) {
      showNoInternetSnackBar(context);
    }
  }

  void showNoInternetSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sin conexión a internet'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state){
        if(state.isLogout){
          popAllAndPush(context, const RegisterScreen(), popAll: true);
        }
      },
      builder: (context, state) {
        final double statusBarHeight = MediaQuery.of(context).padding.top;
        final double totalTopSpace = statusBarHeight + kToolbarHeight;
        
        List<ChartData> data = generarDatosControlados(
          start: DateTime(2025,05,16),
          end: DateTime(2025,06,16),
          yStart: 58572023,
          yEnd: 59819031
        );
        const textStyle = TextStyle(
          color: Color(0xff939191),
          fontSize: 10
        );
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBarBlur(
            userName: state.userName,
            connected: state.connected,
            onLogout: () {
              context.read<AuthCubit>().logout();
              context.read<MyMoneyCubit>().logout();
            }, 
          ),
          body: BlocBuilder<MyMoneyCubit, MyMoneyState>(
            builder: (context, state) {
              return MainBackground(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: totalTopSpace),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 50),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(!context.read<AuthCubit>().state.connected)
                            FutureBuilder<String>(
                              future: context.read<MyMoneyCubit>().getLastUpdate(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Text("Cargando...");
                                } else if (snapshot.hasError) {
                                  return const Text("Error al cargar");
                                } else if (snapshot.hasData) {
                                  return Text('Última conexión: ${snapshot.data!}');
                                } else {
                                  return const Text("Sin datos");
                                }
                              },
                            ),
                            Text('Mi inversión',
                              style: h1TextStyle.copyWith(color: kPrimaryColor),
                            ),
                            Text('Lo que has invertido',
                              style: h4TextStyle,
                            ),
                            Text(formatCurrency(state.totalInvestment),
                              style: h2TextStyle,
                            ),
                            const SizedBox(height: 10),
                            Text('Lo que has ganado',
                              style: h4TextStyle,
                            ),
                            Text(formatCurrency(state.totalProfit),
                              style: h2TextStyle,
                            ),
                            Text('Tu inversión hoy',
                              style: h3TextStyle,
                            ),
                            Row(
                              children: [
                                Text(formatCurrency(state.totalProfit+state.totalInvestment),
                                  style: h1TextStyle.copyWith(fontSize: 23),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('+${state.growthPercentage.toStringAsFixed(1)}%', style: h3TextStyle.copyWith(color: kPrimaryColor)),
                                    SizedBox(
                                      width: getCustomWidthSize(0.34),
                                      child: Text('Crecimiento', style: h6TextStyle,)
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: CupertinoSlidingSegmentedControl<String>(
                                groupValue: _valorSeleccionado,
                                children: _opciones,
                                onValueChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      _valorSeleccionado = newValue;
                                    });
                                                
                                    // Aquí puedes usar el nuevo valor
                                    print('Seleccionado: $_valorSeleccionado');
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Row(
                              children: [
                                PointDataInvestment(
                                  color: kSoftGrey,
                                  text: 'Hace un més',
                                  value: "\$58'572.023",
                                ),
                                PointDataInvestment(
                                  color: kPrimaryColor,
                                  text: 'Hoy',
                                  value: "\$59'819.031",
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: getAvailableHeight(0.25),
                              child: SfCartesianChart(
                                margin: const EdgeInsets.only(bottom: 0),
                                enableMultiSelection: false,
                                plotAreaBorderWidth: 0,
                                primaryXAxis: DateTimeAxis(
                                  minimum: DateTime(2025, 05, 16),
                                  maximum: DateTime(2025, 06, 16),
                                  isVisible: true, // Necesario para que se muestre la línea
                                  labelStyle: const TextStyle(fontSize: 0), // Oculta labels
                                  majorTickLines: const MajorTickLines(size: 0), // Oculta ticks
                                  majorGridLines: const MajorGridLines(width: 0), // Oculta líneas del grid
                                  axisLine: const AxisLine(width: 1), // Muestra solo la línea inferior
                                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                                ),
                                primaryYAxis: NumericAxis(
                                  isVisible: false,
                                  labelFormat: '{value}',
                                  axisLine: const AxisLine(width: 0),
                                  maximum: data.map((e) => e.y).reduce((a, b) => a > b ? a : b).toDouble()+100000,
                                  minimum: data.map((e) => e.y).reduce((a, b) => a < b ? a : b).toDouble()-100000,
                                ),
                                series:[
                                  ..._getSeries(data),
                                  ScatterSeries<ChartData, DateTime>(
                                    dataSource: [
                                      ChartData(
                                        x: DateTime(2025, 05, 16),
                                        y: 58572023,
                                      )
                                    ],
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    markerSettings: const MarkerSettings(
                                      borderColor: kSoftGrey,
                                      isVisible: true,
                                      color: kSoftGrey,
                                      width: 10,
                                      height: 10,
                                      shape: DataMarkerType.circle,
                                    ),
                                  ),
                              
                                  ScatterSeries<ChartData, DateTime>(
                                    dataSource: [
                                      ChartData(
                                        x: DateTime(2025, 06, 16),
                                        y: 59819031,
                                      )
                                    ],
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    markerSettings: const MarkerSettings(
                                      borderColor: kPrimaryColor,
                                      isVisible: true,
                                      color: kPrimaryColor,
                                      width: 10,
                                      height: 10,
                                      shape: DataMarkerType.circle,
                                    ),
                                  ),
                                ],
                                zoomPanBehavior: ZoomPanBehavior(
                                  enablePinching: true,
                                  zoomMode: ZoomMode.x,
                                  enablePanning: true,
                                  enableMouseWheelZooming: false,
                                ),
                              ),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('16 de Mayo',
                                  style: textStyle,
                                ),
                                Text('16 de Junio',
                                  style: textStyle,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            SizedBox(width: double.infinity,
                              child: CupertinoButton.filled(onPressed: () {}, child: const Text('Simular CDT'))
                            ),
                            const SizedBox(height: 15),
                            Text("Mis CDT's",
                              style: h1TextStyle,
                            ),
                            const SizedBox(height: 12),
                            ...state.investments.map((investment)=>CDTCard(investment: investment))
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // Aquí va la lógica para navegar o abrir el formulario de inversión
              print('Invertir');
            },
            label: const Text('Invertir'),
            icon: const Icon(Icons.add_chart),
            backgroundColor: kSecondaryColor,
          ),

        );
      },
    );
  }

  List<CartesianSeries<dynamic, dynamic>> _getSeries(List<ChartData>? heartRateData) {
    return [
      SplineSeries<ChartData, DateTime>(
        name: 'ppm',
        animationDuration: 2000,
        color: kPrimaryColor.withOpacity(0.45),
        dataSource: heartRateData,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
      ),
    ];
  }
  
}



class ChartData {
  final DateTime x;
  final num y;
  ChartData({required this.x, required this.y});
}

List<ChartData> generarDatosControlados({
  required DateTime start,
  required DateTime end,
  required int yStart,
  required int yEnd,
}) {
  final List<ChartData> data = [];
  final totalDays = end.difference(start).inDays;
  final random = Random();

  final minY = min(yStart, yEnd);
  final maxY = max(yStart, yEnd);
  final range = maxY - minY;

  final stdDev = range * 0.20;

  for (int i = 0; i <= totalDays; i++) {
    final currentDate = start.add(Duration(days: i));

    final t = i / totalDays;
    final baseY = yStart + (yEnd - yStart) * t;

    double ruido = 0;
    for (int j = 0; j < 6; j++) {
      ruido += random.nextDouble();
    }
    ruido = (ruido / 6 - 0.5) * 2;

    final yConRuido = baseY + (ruido * stdDev);
    final yClamped = yConRuido.clamp(minY.toDouble(), maxY.toDouble());

    data.add(ChartData(
      x: currentDate,
      y: i == 0 ? yStart : (i == totalDays ? yEnd : yClamped.round()),
    ));
  }

  return data;
}

