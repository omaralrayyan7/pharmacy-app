import 'package:flutter/material.dart';
import '../cart/cart_page.dart';

/// Skincare / Cosmetics category page (originally called ShoesPage in source).
/// Product list mirrors what was visible in the demo video.
class SkincarePage extends StatefulWidget {
  @override
  _SkincarePageState createState() => _SkincarePageState();
}

class _SkincarePageState extends State<SkincarePage> {
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'HydraGlow Moisturizer',
      'description':
          'A lightweight moisturizer infused with hyaluronic acid for deep hydration and a radiant glow. Perfect for daily use on all skin types.',
      'price': 120.0,
      'quantity': 0,
    },
    {
      'name': 'Radiance Vitamin C Serum',
      'description':
          'Potent antioxidant serum that brightens the skin, reduces dark spots, and promotes an even skin tone with its Vitamin C formula.',
      'price': 180.0,
      'quantity': 0,
    },
    {
      'name': 'Deep Cleanse Clay Mask',
      'description':
          'A purifying clay mask that absorbs excess oil, unclogs pores, and leaves your skin feeling refreshed and smooth.',
      'price': 150.0,
      'quantity': 0,
    },
    {
      'name': 'SilkTouch Sunscreen SPF 50',
      'description':
          'A non-greasy sunscreen offering broad-spectrum protection against UVA and UVB rays. Ideal for outdoor activities and daily wear.',
      'price': 200.0,
      'quantity': 0,
    },
    {
      'name': 'YouthRenew Retinol Cream',
      'description':
          'A rich cream enriched with retinol to reduce the appearance of fine lines and wrinkles while boosting skin elasticity.',
      'price': 220.0,
      'quantity': 0,
    },
    {
      'name': 'Soothing Aloe Vera Gel',
      'description':
          'A cooling gel made with pure aloe vera to calm irritated skin, reduce redness, and provide instant relief for dry patches.',
      'price': 80.0,
      'quantity': 0,
    },
  ];

  final List<Map<String, dynamic>> _cart = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Skincare',
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
                      style:
                          const TextStyle(fontSize: 14, color: Colors.grey)),
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
