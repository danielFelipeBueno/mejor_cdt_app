import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mejor_cdt_app/data/auth_repository.dart';
import 'package:mejor_cdt_app/data/investment_repository.dart';
import 'package:mejor_cdt_app/data/local_database_repository.dart';
import 'package:mejor_cdt_app/data/prod/auth_impl.dart';
import 'package:mejor_cdt_app/data/prod/investments_impl.dart';
import 'package:mejor_cdt_app/data/prod/local_database_impl.dart';
import 'package:mejor_cdt_app/data/prod/secure_storage_impl.dart';
import 'package:mejor_cdt_app/data/secure_storage_repository.dart';
import 'package:mejor_cdt_app/domain/usecases/auth_use_case.dart';
import 'package:mejor_cdt_app/domain/usecases/investments_use_case.dart';
import 'package:mejor_cdt_app/ui/auth/cubit/auth_cubit.dart';
import 'package:mejor_cdt_app/ui/auth/screens/splash_screen.dart';
import 'package:mejor_cdt_app/ui/my_money/cubit/my_money_cubit.dart';
import 'package:mejor_cdt_app/utils/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <RepositoryProvider>[
        //$ Repositories
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthImpl()
        ),
        RepositoryProvider<SecureStorageRepository>(
          create: (_) => SecureStorageImpl()
        ),
        RepositoryProvider<InvestmentRepository>(
          create: (_) => InvestmentsImpl()
        ),
        RepositoryProvider<LocalDatabaseRepository>(
          create: (_) => LocalDatabaseImpl()
        ),
        //$ UseCases
        RepositoryProvider<AuthUseCase>(
          create: (context) => AuthUseCase(
            context.read(), context.read()
          )
        ),
        RepositoryProvider<InvestmentsUseCase>(
          create: (context) => InvestmentsUseCase(
            context.read(), context.read(), context.read()
          )
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit(
            context.read(),
          )),
          BlocProvider(create: (context) => MyMoneyCubit(
            context.read()
          ))
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: kSecondaryColor),
            useMaterial3: true,
          ),
          home: Builder(
            builder: (context) {
              return const SplashScreen();
            }
          ),
        ),
      ),
    );
  }
}


