import 'package:flutter/material.dart';

/// Cart screen.
/// Receives [cart] – list of items the user has added – and displays
/// name, quantity, unit price, and line total for each item.
class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cart;
  final List<Map<String, dynamic>> products;

  const CartPage({
    super.key,
    required this.cart,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                final double total =
                    (item['price'] as double) * (item['quantity'] as int);
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text(
                    'Quantity: ${item['quantity']}\nPrice: \$${(item['price'] as double).toStringAsFixed(2)}',
                  ),
                  trailing: Text(
                    'Total: \$${total.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  isThreeLine: true,
                );
              },
            ),
    );
  }
}
