import 'package:flutter/material.dart';
import 'dart:async';

import 'package:gui_zapret/presentation/pages/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadApp();
  }

  Future<void> _loadApp() async {
    // Имитация загрузки данных (например, инициализация ресурсов)
    await Future.delayed(const Duration(seconds: 1));

    // Переход на главный экран
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Логотип или анимация загрузки
            Icon(Icons.autorenew, size: 50, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Загрузка...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
