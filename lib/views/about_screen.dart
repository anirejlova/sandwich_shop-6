import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        title: const Text(
          'About',
          style: heading1,
        ),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  'About Our Sandwich Shop',
                  style: heading2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome to our sandwich shop! We serve the finest sandwiches made with fresh ingredients and love.',
                  style: normalText,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Our mission is to provide delicious, high-quality sandwiches that satisfy every customer.',
                  style: normalText,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
