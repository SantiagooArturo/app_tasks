import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final Widget? bottomBar;
  final Widget? floatingButton;
  const MainLayout({
    super.key,
    required this.body,
    this.bottomBar,
    this.floatingButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: body,
        ),
      ),
      bottomNavigationBar: bottomBar,
      floatingActionButton: floatingButton,
    );
  }
}
