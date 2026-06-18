import 'package:flutter/material.dart';

/// Contact Us screen.
/// Shows pharmacy support email, phone number, and social media info.
class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff013220),
        title: const Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // ── Email ──────────────────────────────────────────────────────
            Row(
              children: [
                Icon(Icons.email, color: const Color(0xff013220)),
                const SizedBox(width: 10),
                const Text(
                  'omaralrayyan7@gmail.com (24/7 Support)',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // ── Phone ──────────────────────────────────────────────────────
            Row(
              children: [
                Icon(Icons.phone, color: const Color(0xff013220)),
                const SizedBox(width: 10),
                const Text(
                  '00962790550787',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Follow Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // ── Facebook ──────────────────────────────────────────────────
            Row(
              children: [
                const Icon(Icons.facebook, color: Colors.blue),
                const SizedBox(width: 10),
                const Text(
                  'Abdalkarim kehail',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
