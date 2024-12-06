import 'package:flutter/material.dart';
import 'package:freescord/presentation/widgets/repositories.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: null, // Убираем стандартный title
        flexibleSpace: Center(
          child: const Text(
            'О приложении',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Image.asset(
              'assets/images/freescord_logo.png',
              width: 250,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Freescord - графический интерфейс для обхода блокировок Discord и YouTube, работающий с инструментом WinDivert, основанный на zapret и zapret-discord-youtube.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 40),
          RepositoriesList()
        ],
      ),
    );
  }
}
