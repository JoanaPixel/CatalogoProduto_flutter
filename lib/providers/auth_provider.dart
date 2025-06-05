import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _logado = false; // Armazena se o usuário está logado
  bool get isLoggedIn => _logado;

  // Login com email e senha
  Future<bool> login(String email, String password) async {
    final sucesso = await _authService.signIn(email, password);
    _logado = sucesso;
    notifyListeners();
    return sucesso;
  }

  // Registrar com usuário, email e senha
  Future<bool> register(String email, String password, String username) async {
    final sucesso = await _authService.signUp(email, password, username);
    _logado = sucesso;
    notifyListeners();
    return sucesso;
  }

  // Tenta restaurar sessão salva
  Future<void> tryAutoLogin() async {
    final restaurado = await _authService.restoreSession();
    _logado = restaurado;
    notifyListeners();
  }

  // Logout do usuário
  Future<void> logout() async {
    await _authService.singOut();
    _logado = false;
    notifyListeners();
  }
}
