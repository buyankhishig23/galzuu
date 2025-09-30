import 'dart:async';

import 'package:flutter/material.dart';
import 'package:galzuu/main.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => const MainWrapper());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Use current theme

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/logo/logo.png", width: 150, height: 150),
            const SizedBox(height: 16),
            Text(
              "Galzuu App",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor, // Uses theme primary color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
