import 'package:flutter/material.dart';
import 'package:gui_zapret/domain/services/logger/log_entry.dart';
import 'package:gui_zapret/domain/services/logger/log_manager.dart';
import 'package:gui_zapret/domain/services/process_manager.dart';
import 'package:gui_zapret/presentation/pages/about.dart';
import 'package:gui_zapret/presentation/pages/settings.dart';
import 'package:gui_zapret/presentation/widgets/log_output.dart'; // импортируем SettingsPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isProcessRunning = false;

  final logManager = LogManager();
  final processManager = ProcessManager(); // Создаем экземпляр ProcessManager
  List<LogEntry> _logs = [];

  // Метод для начала процесса
  void _startProcess() {
    if (!processManager.isRunning) {
      processManager.startProcess(); // Передайте необходимые аргументы
      logManager.addLog("Процесс запущен", LogType.success);
      setState(() {
        _logs = logManager.getLogs();
      });
    } else {
      logManager.addLog("Процесс уже запущен",
          LogType.info); // Логируем, если процесс уже запущен
      setState(() {
        _logs = logManager.getLogs();
      });
    }
  }

  // Метод для остановки процесса
  void _stopProcess() {
    if (processManager.isRunning) {
      processManager.killProcess();
      logManager.addLog("Процесс остановлен", LogType.error);
      setState(() {
        _logs = logManager.getLogs();
      });
    } else {
      logManager.addLog("Процесс не запущен",
          LogType.info); // Логируем, если процесс не был запущен
      setState(() {
        _logs = logManager.getLogs();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Главная страница'),
          actions: [
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Переключатель
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Запуск процесса'),
                  Switch(
                    value: _isProcessRunning,
                    onChanged: (bool value) {
                      if (value) {
                        _startProcess();
                        _isProcessRunning = !_isProcessRunning;
                      } else {
                        _stopProcess();
                        _isProcessRunning = !_isProcessRunning;
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LogConsole(logs: _logs), // Вставляем новый виджет LogConsole
            ],
          ),
        ));
  }
}
