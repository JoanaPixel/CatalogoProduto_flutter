import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  bool _logado = false;
  bool get logado => _logado;

  Future<void> login(String email, String senha) async {
    final sucesso = await AuthService().login(email, senha);
    if (sucesso) {
      _logado = true;
      notifyListeners();
    } else {
      throw Exception('Email ou senha inválidos');
    }
  }

  void logout() {
    _logado = false;
    notifyListeners();
  }
}
