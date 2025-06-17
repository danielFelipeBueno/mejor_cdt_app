part of 'auth_cubit.dart';

class AuthState {
  /// Controlador de texto para el campo de nombre en la interfaz.
  TextEditingController nameController;

  /// Controlador de texto para el campo de correo electrónico en la interfaz.
  TextEditingController emailController;

  /// Objeto `User` que representa al usuario autenticado actualmente (puede ser null si no hay sesión).
  User? user;

  /// Mensaje de error actual, usado para mostrar errores en la interfaz.
  String errorMessage;

  /// Indica si el usuario está autenticado o no.
  bool isAuthenticated;

  /// Nombre del usuario autenticado, útil para mostrar en la interfaz.
  String userName;

  /// Indica si el usuario ha cerrado sesión.
  bool isLogout;

  /// Indica si hay conexión a internet.
  bool connected;

  AuthState(
    this.nameController,
    this.emailController, {
    this.user,
    this.errorMessage = '',
    this.isAuthenticated = false,
    this.userName = '',
    this.isLogout = false,
    this.connected = true,
  });

  AuthState copyWith({
    User? user,
    bool resetUser = false,
    String? errorMessage,
    bool? isAuthenticated,
    String? userName,
    bool? isLogout,
    bool? connected,
  }) {
    return AuthState(
      nameController,
      emailController,
      user: resetUser ? null : user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userName: userName ?? this.userName,
      isLogout: isLogout ?? this.isLogout,
      connected: connected ?? this.connected,
    );
  }
}
