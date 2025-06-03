import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _logado = false; // Armazena se o usuário está logado
  bool get isLoggedIn => _logado;

  /// Login com email e senha
  Future<bool> login(String email, String password) async {
    final sucesso = await _authService.login(email, password);
    _logado = sucesso;
    notifyListeners();
    return sucesso;
  }

  /// Registrar com email e senha
  Future<bool> register(String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      return response.user != null;
    } catch (e) {
      debugPrint('Erro ao registrar: $e');
      return false;
    }
  }

  /// Tenta restaurar sessão salva
  Future<void> tryAutoLogin() async {
    final restaurado = await _authService.restoreSession();
    _logado = restaurado;
    notifyListeners();
  }

  /// Logout do usuário
  Future<void> logout() async {
    await _authService.logout();
    _logado = false;
    notifyListeners();
  }


}
