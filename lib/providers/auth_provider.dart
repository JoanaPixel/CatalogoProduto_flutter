import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _logado = false;
  bool _isLoading = true;

  bool get isLoggedIn => _logado;
  bool get isLoading => _isLoading;
  
   // Login com email e senha
  Future<bool> login(String email, String password) async {
    final sucesso = await _authService.signIn(email, password);
    _logado = sucesso;
    notifyListeners();
    return sucesso;
  }
   
  // Registro com email, senha e username
  Future<bool> register(String email, String password, String username) async {
    final sucesso = await _authService.signUp(email, password, username);
    _logado = sucesso;
    notifyListeners();
    return sucesso;
  }
  // Tenta restaurar sessão salva no storage seguro
  Future<void> tryAutoLogin() async {
    _isLoading = true;
    notifyListeners();

    final restaurado = await _authService.restoreSession();
    _logado = restaurado;

    _isLoading = false;
    notifyListeners();
  }

  // Logout do usuário
  Future<void> logout() async {
    await _authService.signOut();
    _logado = false;
    notifyListeners();
  }
}