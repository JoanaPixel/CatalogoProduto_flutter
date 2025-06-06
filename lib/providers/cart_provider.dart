import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap(String userId) {
    return {
      'user_id': userId,
      'produto_id': id,
      'quantidade': quantity,
    };
  }
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get cartItems => List.unmodifiable(_items);

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }

  int get itemCount => _items.length;

  // Carrega carrinho do Supabase
  Future<void> fetchCartFromSupabase() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final response = await Supabase.instance.client
        .from('carrinho')
        .select()
        .eq('user_id', user.id);

    _items.clear();

    for (final item in response) {
      // busca os detalhes do produto usando produto_id
      final produtoResp = await Supabase.instance.client
          .from('produtos')
          .select()
          .eq('id', item['produto_id'])
          .single();

      _items.add(
        CartItem(
          id: item['produto_id'],
          title: produtoResp['titulo'] ?? '',
          price: (produtoResp['preco'] ?? 0).toDouble(),
          imageUrl: produtoResp['imagem_url'] ?? '',
          quantity: item['quantidade'] ?? 1,
        ),
      );
    }

    notifyListeners();
  }

  // Adiciona ao carrinho (local e remoto)
  Future<void> addItem({
    required String id,
    required String title,
    required double price,
    required String imageUrl,
  }) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final existingIndex = _items.indexWhere((item) => item.id == id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
      await Supabase.instance.client
          .from('carrinho')
          .update({'quantidade': _items[existingIndex].quantity})
          .eq('user_id', user.id)
          .eq('produto_id', id);
    } else {
      _items.add(
        CartItem(
          id: id,
          title: title,
          price: price,
          imageUrl: imageUrl,
          quantity: 1,
        ),
      );

      await Supabase.instance.client
          .from('carrinho')
          .insert({'user_id': user.id, 'produto_id': id, 'quantidade': 1});
    }

    notifyListeners();
  }

  // Aumenta a quantidade
  Future<void> increaseQuantity(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();

      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        await Supabase.instance.client
            .from('carrinho')
            .update({'quantidade': _items[index].quantity})
            .eq('user_id', user.id)
            .eq('produto_id', id);
      }
    }
  }

  // Diminui a quantidade ou remove
  Future<void> decreaseQuantity(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
        notifyListeners();

        final user = Supabase.instance.client.auth.currentUser;
        if (user != null) {
          await Supabase.instance.client
              .from('carrinho')
              .update({'quantidade': _items[index].quantity})
              .eq('user_id', user.id)
              .eq('produto_id', id);
        }
      } else {
        await removeItem(id);
      }
    }
  }

  // Remove item do carrinho
  Future<void> removeItem(String id) async {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();

    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      await Supabase.instance.client
          .from('carrinho')
          .delete()
          .eq('user_id', user.id)
          .eq('produto_id', id);
    }
  }

  /// 🧹 Limpa local + Supabase
  Future<void> clearCart() async {
    final user = Supabase.instance.client.auth.currentUser;
    _items.clear();
    notifyListeners();

    if (user != null) {
      await Supabase.instance.client
          .from('carrinho')
          .delete()
          .eq('user_id', user.id);
    }
  }
}
