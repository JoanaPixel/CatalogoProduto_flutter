import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // // Login com email e senha
  Future<bool> signIn(String email, String senha) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: senha,
      );

      if (response.user != null) {
        // Serializa a sessão como JSON válido
        final sessionJson = jsonEncode(response.session?.toJson());
        await _storage.write(key: 'session', value: sessionJson);
        return true;
      }
      return false;
    } catch (e) {
      print('Erro no login: $e');
      return false;
    }
  }

  // Registro com email, senha e criação do perfil na tabela `profiles`
  Future<bool> signUp(String email, String senha, String username) async {
    try {
      final response = await _client.auth.signUp(email: email, password: senha);

      final user = response.user;

      if (user != null) {
        await _client.from('profiles').insert({
          'id': user.id,
          'username': username,
          'created_at': DateTime.now().toIso8601String(),
        });
        return true;
      }
      return false;
    } catch (e) {
      print('Erro ao registrar: $e');
      return false;
    }
  }

  // Logout e limpeza da sessão local
  Future<void> signOut() async {
    await _client.auth.signOut();
    await _storage.delete(key: 'session');
  }

  // Restaura sessão salva no dispositivo
  Future<bool> restoreSession() async {
    // acho que não está certo
    final sessionStr = await _storage.read(key: 'session');
    if (sessionStr != null) { 
      final sessionJson = jsonDecode(sessionStr);
      final response = await _client.auth.recoverSession(sessionJson);
      return response.session != null;
    }
    return false;
  }

  bool isLoggedIn() {
    return _client.auth.currentUser != null;
  }

  Future<void> limparCarrinho() async {
  final userId = Supabase.instance.client.auth.currentUser!.id;

  await Supabase.instance.client
    .from('carrinho')
    .delete()
    .eq('user_id', userId);
}
}
