import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_tile.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Carrinho")),
      body: cart.cart.isEmpty
          ? const Center(child: Text("Seu carrinho está vazio"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cart.length,
                    itemBuilder: (context, index) => CartItemTile(product: cart.cart[index]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Total: \$${cart.totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => cart.clearCart(),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text("Limpar Carrinho"),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
