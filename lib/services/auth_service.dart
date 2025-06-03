import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final supabase = Supabase.instance.client;
  final SupabaseClient _client = Supabase.instance.client;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> login(String email, String senha) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: senha,
      );

      if (response.user != null) {
        await _storage.write(
          key: 'session',
          value: response.session?.toJson().toString(),
        );
        return true;
      }
      return false;
    } catch (e) {
      print('Erro no login: $e');
      return false;
    }
  }

  Future<void> logout() async {
    await _client.auth.signOut();
    await _storage.delete(key: 'session');
  }

  Future<bool> restoreSession() async {
    final sessionStr = await _storage.read(key: 'session');

    if (sessionStr != null) {
      final response = await _client.auth.recoverSession(sessionStr!);
      return response.session != null;
    }
    return false;
  }

  bool isLoggedIn() {
    return _client.auth.currentUser != null;
  }
}
