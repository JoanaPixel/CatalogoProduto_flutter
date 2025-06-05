import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> limparCarrinho() async {
  final userId = Supabase.instance.client.auth.currentUser?.id;

  if (userId == null) {
    throw Exception("Usuário não autenticado");
  }

  await Supabase.instance.client
      .from('carrinho')
      .delete()
      .eq('user_id', userId);
}
