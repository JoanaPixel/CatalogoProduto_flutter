import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class CartItemTile extends StatelessWidget {
  final Product product;

  const CartItemTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return ListTile(
      leading: Image.network(product.image, height: 50),
      title: Text(product.title),
      subtitle: Text("\$${product.price}"),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => cart.removeFromCart(product),
      ),
    );
  }
}
