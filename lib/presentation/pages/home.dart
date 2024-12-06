import 'package:Freescord/domain/services/logger/log_entry.dart';
import 'package:Freescord/domain/services/logger/log_manager.dart';
import 'package:Freescord/domain/services/process_manager.dart';
import 'package:Freescord/presentation/widgets/log_output.dart';
import 'package:flutter/material.dart';

// Цвета:
String primary = '#006FEE';
String success = '#17c964';
String warning = '#f5a524';
String danger = '#f31260';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logManager = LogManager();
  final processManager = ProcessManager();

  List<LogEntry> _logs = [];

  void _startProcess() {
    if (!processManager.isRunning) {
      processManager.startProcess();
      logManager.addLog("Процесс запущен", LogType.success);
      setState(() {
        _logs = logManager.getLogs();
      });
    } else {
      logManager.addLog("Процесс уже запущен", LogType.info);
      setState(() {
        _logs = logManager.getLogs();
      });
    }
  }

  void _stopProcess() {
    if (processManager.isRunning) {
      processManager.killProcess();
      logManager.addLog("Процесс остановлен", LogType.error);
      setState(() {
        _logs = logManager.getLogs();
      });
    } else {
      logManager.addLog("Процесс не запущен", LogType.info);
      setState(() {
        _logs = logManager.getLogs();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная страница',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Запуск процесса',
                    style: TextStyle(color: Colors.white)),
                ValueListenableBuilder<bool>(
                  valueListenable: processManager.isRunningNotifier,
                  builder: (context, isRunning, child) {
                    return Switch(
                      value: isRunning,
                      onChanged: (bool value) {
                        if (value) {
                          _startProcess();
                        } else {
                          _stopProcess();
                        }
                      },
                      activeColor: Color(0xff393939),
                      activeTrackColor: Color(0xffffffff),
                      inactiveTrackColor: Color(0xff333333),
                      inactiveThumbColor: Colors.white,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            LogConsole(logs: _logs),
          ],
        ),
      ),
    );
  }
}
