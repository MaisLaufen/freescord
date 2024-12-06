import 'package:freescord/domain/services/logger/log_entry.dart';
import 'package:freescord/domain/services/logger/log_manager.dart';
import 'package:freescord/domain/services/process_manager.dart';
import 'package:freescord/presentation/widgets/log_output.dart';
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
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Запуск обхода Discord',
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
