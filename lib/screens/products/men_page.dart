import 'package:flutter/material.dart';
import '../cart/cart_page.dart';

/// Needles & Syringes category page (originally called MenPage in the source).
/// Shares the same cart pattern as [MedicinePage].
class MenPage extends StatefulWidget {
  @override
  _MenPageState createState() => _MenPageState();
}

class _MenPageState extends State<MenPage> {
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Insulin Syringe 1ml',
      'description': 'Sterile insulin syringe with ultra-fine needle for precise dosing.',
      'price': 15.0,
      'quantity': 0,
    },
    {
      'name': 'Disposable Syringe 5ml',
      'description': 'Single-use sterile syringe for medical and laboratory use.',
      'price': 8.0,
      'quantity': 0,
    },
    {
      'name': 'IV Cannula 20G',
      'description': 'Intravenous cannula for fluid administration and blood sampling.',
      'price': 12.0,
      'quantity': 0,
    },
    {
      'name': 'Lancet Pen',
      'description': 'Blood glucose lancet device with adjustable depth control.',
      'price': 45.0,
      'quantity': 0,
    },
    {
      'name': 'Butterfly Needle 21G',
      'description': 'Winged infusion set for paediatric and difficult veins.',
      'price': 20.0,
      'quantity': 0,
    },
    {
      'name': 'Glucometer Test Strips (50)',
      'description': 'Compatible test strips for blood glucose monitoring.',
      'price': 60.0,
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
          'Needles & Syringes',
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
