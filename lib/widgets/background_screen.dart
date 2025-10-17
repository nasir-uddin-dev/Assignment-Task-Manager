import 'package:flutter/material.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            "https://images.unsplash.com/photo-1615715162231-336fc572a2be?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDI5fHx8ZW58MHx8fHx8&auto=format&fit=crop&q=60&w=500",
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
          ),
          SafeArea(child: child)
        ],
      ),
    );
  }
}
