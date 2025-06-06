import 'package:supabase_flutter/supabase_flutter.dart';

// Apaga todos os itens do carrinho do usuário logado
Future<void> limparCarrinho() async {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) throw Exception("Usuário não autenticado");

  await Supabase.instance.client
      .from('carrinho')
      .delete()
      .eq('user_id', userId);
}

// Adiciona um item ao carrinho no Supabase
Future<void> adicionarAoCarrinho({
  required String produtoId,
  required int quantidade,
}) async {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) throw Exception("Usuário não autenticado");

  await Supabase.instance.client.from('carrinho').insert({
    'user_id': userId,
    'produto_id': produtoId,
    'quantidade': quantidade,
  });
}
