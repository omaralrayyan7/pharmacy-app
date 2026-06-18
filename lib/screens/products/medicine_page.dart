import 'package:flutter/material.dart';
import '../cart/cart_page.dart';

/// Medicine category page (originally called WomenPage in the source).
/// Shows a list of medicines with quantity selector and Add-to-Cart.
/// Navigates to [CartPage] via the cart icon in the AppBar.
class MedicinePage extends StatefulWidget {
  /// Optional pre-filled products (e.g. merged from another page).
  final List<Map<String, dynamic>> products;

  const MedicinePage({super.key, this.products = const []});

  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  // ── Product catalogue ──────────────────────────────────────────────────
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'panadol advanced',
      'description': 'Effective for headaches and fever',
      'price': 50.0,
      'quantity': 0,
    },
    {
      'name': 'panadol night',
      'description': 'Helps with sleep and pain relief',
      'price': 30.0,
      'quantity': 0,
    },
    {
      'name': 'panadol cold&flo',
      'description': 'Relieves cold and flu symptoms',
      'price': 70.0,
      'quantity': 0,
    },
    {
      'name': 'Tramal',
      'description': 'Strong pain relief medication',
      'price': 90.0,
      'quantity': 0,
    },
    {
      'name': 'Relaxon',
      'description': 'Muscle relaxant and pain reliever',
      'price': 40.0,
      'quantity': 0,
    },
    {
      'name': 'Aspirin 500mg',
      'description': 'Anti-inflammatory and fever reducer',
      'price': 25.0,
      'quantity': 0,
    },
    {
      'name': 'Ibuprofen 400mg',
      'description': 'Reduces inflammation, fever and mild pain',
      'price': 35.0,
      'quantity': 0,
    },
  ];

  final List<Map<String, dynamic>> _cart = [];

  // ── Cart helpers ──────────────────────────────────────────────────────
  void _increment(int i) => setState(() => _products[i]['quantity']++);

  void _decrement(int i) {
    if (_products[i]['quantity'] > 0) {
      setState(() => _products[i]['quantity']--);
    }
  }

  void _addToCart(int i) {
    final p = _products[i];
    if (p['quantity'] == 0) return;
    setState(() {
      final existing = _cart.indexWhere((c) => c['name'] == p['name']);
      if (existing >= 0) {
        _cart[existing]['quantity'] += p['quantity'];
      } else {
        _cart.add(Map<String, dynamic>.from(p));
      }
      _products[i]['quantity'] = 0;
    });
  }

  // ── Build ─────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'medicine',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CartPage(cart: _cart, products: _products),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final p = _products[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['name'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(p['description'],
                      style: const TextStyle(
                          fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text(
                    '\$${(p['price'] as double).toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => _decrement(index),
                          ),
                          Text('${p['quantity']}'),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => _increment(index),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () => _addToCart(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff013220),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Add to Cart'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
