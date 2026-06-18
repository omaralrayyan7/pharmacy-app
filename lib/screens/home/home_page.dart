import 'dart:async';
import 'package:flutter/material.dart';

/// Home screen – auto-sliding product banner + category navigation grid.
/// Routes:
///   /medicine  → MedicinePage
///   /men       → MenPage  (needles & syringes)
///   /shoes     → SkincarePage
///   /contact   → ContactUsPage
///   /FeedBack  → ReviewPage
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentPage = 0;

  // Auto-slide banner images (Panadol range)
  final List<String> _images = [
    'https://i-cf65.ch-static.com/content/dam/cf-consumer-healthcare/panadol-reborn/en_IE/newpackshots202406/product-range.jpg?auto=format',
    'https://t4.ftcdn.net/jpg/03/33/62/35/360_F_333623558_6uZRDJTCjqYiYMlyweKoomMilIOWAGGHD.jpg',
    'https://t4.ftcdn.net/jpg/05/01/44/67/360_F_50144672b_0yAnhxRpaDde2LBXPpESA8yRJa0jwQgK.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentPage = (_currentPage + 1) % _images.length;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _buildImageButton(
      BuildContext context, String route, String imageUrl) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.network(
          imageUrl,
          height: 80,
          width: 80,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.broken_image, size: 80),
        ),
      ),
    );
  }

  Widget _categoryButton(
      BuildContext context, String route, String imageUrl, String label) {
    return Column(
      children: [
        _buildImageButton(context, route, imageUrl),
        const Padding(padding: EdgeInsets.all(8)),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, route),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff013220),
            foregroundColor: Colors.white,
          ),
          child: Text(label),
        ),
      ],
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff013220),
        title: const Text(
          'pharmacy',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
            child: const Text('Login', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Banner carousel ───────────────────────────────────────────
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                itemBuilder: (context, index) => Image.network(
                  _images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, __, ___) =>
                      const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),

            // ── Welcome text ──────────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Welcome to our Pharmacy App! Explore medicines, health tips, and services at your fingertips.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // ── Row 1: medicine | needles | skincare ──────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _categoryButton(
                  context,
                  '/medicine',
                  'https://static.vecteezy.com/system/resources/thumbnails/040/502/161/small_2x/3d-illustration-pill-medicine-png.png',
                  'medicine',
                ),
                _categoryButton(
                  context,
                  '/men',
                  'https://static.vecteezy.com/system/resources/thumbnails/019/029/467/small_2x/syringe-and-needle-png.png',
                  'needles',
                ),
                _categoryButton(
                  context,
                  '/shoes',
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZGMlcjqvLQyQQcCWjFY7zfWY4u9drDPn7qg&s',
                  'Skincare',
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ── Row 2: cosmetics (centred) ────────────────────────────────
            _categoryButton(
              context,
              '/shoes',
              'https://static.vecteezy.com/system/resources/thumbnails/038/974/935/small_2x/3d-illustration-cosmetics-products-png.png',
              'cosmetics',
            ),

            const SizedBox(height: 20),

            // ── Contact Us / FeedBack ─────────────────────────────────────
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/contact'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      backgroundColor: const Color(0xff013220),
                    ),
                    child: const Text('Contact Us',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/FeedBack'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      backgroundColor: const Color(0xff013220),
                    ),
                    child: const Text('FeedBack',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
