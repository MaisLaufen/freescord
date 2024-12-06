import 'package:flutter/material.dart';

class ExitDialog extends StatelessWidget {
  final VoidCallback onExit;
  final VoidCallback onMinimize;

  const ExitDialog({
    Key? key,
    required this.onExit,
    required this.onMinimize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Color(0xff333333)), // Светлая рамка
      ),
      elevation: 10, // Тень для выделения
      backgroundColor: Colors.black87, // Немного прозрачный черный
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Вы уверены?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xffffffff),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "Закрыть приложение или свернуть в трей?",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff333333),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: onExit,
                  child: const Text(
                    "Закрыть",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 202, 202, 202),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: onMinimize,
                  child: const Text(
                    "Свернуть",
                    style: TextStyle(color: Color(0xff333333)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
