/*
- Classe auth_provider gerencia o estado de autenticação do usuario 
- Possui metodos para login, logout e auto-login

*/
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _logado = false; // armazena se o usuario está logado
  bool get isLoggedIn => _logado;

  Future<bool> login(String email, String password) async {
    final successo = await _authService.login(email, password);
    _logado = successo;
    notifyListeners();
    return successo;
  }

  Future<void> logout() async {
    await _authService.logout();
    _logado = false;
    notifyListeners();
  }

  // metodo para login automatico
  Future<void> tryAutoLogin() async {
    final restored = await _authService.restoreSession();
    _logado = restored;
    notifyListeners();
  }

  Future<bool> register(String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      return response.user != null;
    } catch (e) {
      print('Erro ao registrar: $e');
      return false;
    }
  }
}
