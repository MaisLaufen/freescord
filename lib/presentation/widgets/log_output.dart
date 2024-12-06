// lib/presentation/widgets/log_console.dart
import 'package:Freescord/domain/services/logger/log_entry.dart';
import 'package:flutter/material.dart';

class LogConsole extends StatelessWidget {
  final List<LogEntry> logs;

  const LogConsole({required this.logs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Информация:',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xff333333)),
          ),
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final logEntry = logs[index];
              Color logColor;

              switch (logEntry.type) {
                case LogType.success:
                  logColor = Colors.green;
                  break;
                case LogType.error:
                  logColor = Colors.red;
                  break;
                case LogType.info:
                default:
                  logColor = Colors.white;
              }

              return Text(
                '[${logEntry.timestamp}] ${logEntry.message}',
                style: TextStyle(color: logColor, fontFamily: 'Courier'),
              );
            },
          ),
        ),
      ],
    );
  }
}
