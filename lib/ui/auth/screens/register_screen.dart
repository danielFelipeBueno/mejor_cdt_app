
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mejor_cdt_app/ui/auth/cubit/auth_cubit.dart';
import 'package:mejor_cdt_app/ui/auth/widgets/register_text_field.dart';
import 'package:mejor_cdt_app/ui/my_money/cubit/my_money_cubit.dart';
import 'package:mejor_cdt_app/ui/my_money/screen/my_money_screen.dart';
import 'package:mejor_cdt_app/ui/shared/main_background.dart';
import 'package:mejor_cdt_app/utils/navigator_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final firstFocus = FocusNode();
  final secondFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(firstFocus);
    });
  }

  @override
  void dispose() {
    firstFocus.dispose();
    secondFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state.errorMessage.isNotEmpty){
          _showErrorDialog(context,state.errorMessage);
        }
        if(state.isAuthenticated){
          popAllAndPush(context, const MyMoneyScreen(), popAll: true);
          context.read<MyMoneyCubit>().generateInvestments();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: MainBackground(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Spacer(), 
                  const SizedBox(
                    height: 47,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Bienvenido',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  RegisterTextField(
                    controller: state.nameController,
                    hintText: 'Nombre',
                    validator: (value) {
                      if (value == null || value.trim().length <= 3) {
                        return 'Debe tener más de 3 letras';
                      }
                      return null; // válido
                    },
                    focusNode: firstFocus,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(secondFocus);
                    },
                  ),
                  const SizedBox(height: 35),
                  RegisterTextField(
                    controller: state.emailController,
                    hintText: 'Correo',
                    textInputType: TextInputType.emailAddress,
                    focusNode: secondFocus,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value.trim())) {
                        return 'Ingresa un correo válido';
                      }
                      return null; // válido
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const Spacer(flex: 4),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: gradientButton(
            text: 'Ingresar',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<AuthCubit>().createUser(context);
              }
            },
          ),
        );
      },
    );
  }
  void _showErrorDialog(BuildContext context, String message) {
    onPressed(){
      popToPage(context);
      context.read();
    }
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: onPressed,
              child: const Text('OK'),
            )
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }
}

Widget gradientButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return Material(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: Ink(
      width: 150,
      height: 45,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff00AED5), Color(0xff2465DF)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );

  
}


