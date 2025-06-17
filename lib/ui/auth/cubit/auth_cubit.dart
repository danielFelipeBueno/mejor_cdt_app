import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mejor_cdt_app/domain/models/user_model.dart';
import 'package:mejor_cdt_app/domain/usecases/auth_use_case.dart';
import 'package:http/http.dart' as http;

part 'auth_state.dart';

/// Controlador de texto para el campo de nombre en la UI
final _nameController = TextEditingController();

/// Controlador de texto para el campo de email en la UI
final _emailController = TextEditingController();

/// Cubit que maneja la lógica de autenticación del usuario
class AuthCubit extends Cubit<AuthState> {

  final AuthUseCase _authUseCase;

  AuthCubit(this._authUseCase) 
  : super(AuthState(
      _nameController,
      _emailController,
    ));

  /// Verifica si el usuario está autenticado actualmente.
  /// También actualiza el estado con el nombre del usuario si está autenticado.
  Future<bool> isAuthenticated() async {
    bool isAuthenticated = await _authUseCase.isAuthenticated();
    String? userName = await _authUseCase.readUserName();
    
    if (userName != null) {
      emit(state.copyWith(
        isAuthenticated: isAuthenticated,
        userName: userName,
      ));
      return isAuthenticated;
    }
    return false;
  }

  /// Crea un nuevo usuario usando los datos del formulario (nombre y email).
  /// Actualiza el estado con el usuario creado y lo marca como autenticado.
  /// Si hay un error, actualiza el estado con el mensaje de error.
  Future<void> createUser(BuildContext ctx) async {
    try {
      final User user = await _authUseCase.createUser(
        state.nameController.text,
        state.emailController.text,
      );
      emit(state.copyWith(
        user: user,
        isAuthenticated: true,
        userName: user.name,
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  /// Limpia el mensaje de error del estado actual.
  void resetError() => emit(state.copyWith(errorMessage: ''));

  /// Verifica manualmente si hay conexión a internet haciendo una petición a Google.
  /// Actualiza el estado con el resultado de la conexión (true o false).
  Future<bool> hasInternetManually() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 3));
      
      emit(state.copyWith(connected: true));
      return response.statusCode == 200;
    } catch (e) {
      emit(state.copyWith(connected: false));
      return false;
    }
  }

  /// Cierra la sesión del usuario.
  /// Ejecuta el logout en el `AuthUseCase` y reinicia el estado.
  Future<void> logout() async {
    await _authUseCase.logout();
    
    // Marca el estado como cerrado
    emit(state.copyWith(isLogout: true));
    
    // Reinicia el estado con nuevos controladores
    emit(AuthState(TextEditingController(), TextEditingController()));
  }
}
