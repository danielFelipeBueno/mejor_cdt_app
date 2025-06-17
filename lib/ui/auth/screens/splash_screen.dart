// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mejor_cdt_app/ui/auth/cubit/auth_cubit.dart';
import 'package:mejor_cdt_app/ui/auth/screens/register_screen.dart';
import 'package:mejor_cdt_app/ui/my_money/screen/my_money_screen.dart';
import 'package:mejor_cdt_app/ui/shared/main_background.dart';
import 'package:mejor_cdt_app/utils/navigator_utils.dart';
import 'package:mejor_cdt_app/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startNavigationLogic();
  }

  Future<void> _startNavigationLogic() async {
    await Future.delayed(const Duration(seconds: 2));

    final isAuthenticated = await context.read<AuthCubit>().isAuthenticated();

    if (!mounted) return;

    if (isAuthenticated) {
      popAllAndPush(context, const MyMoneyScreen(), popAll: true);
    } else {
      popAllAndPush(context, const RegisterScreen(), popAll: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: MainBackground(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
