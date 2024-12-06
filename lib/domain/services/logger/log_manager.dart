import 'package:Freescord/domain/services/logger/log_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogManager {
  static final LogManager _instance = LogManager._internal();

  factory LogManager() {
    return _instance;
  }

  LogManager._internal();

  // Список логов

  // Shouldn't be final.
  final List<LogEntry> _logs = [];

  // Метод для добавления логов
  void addLog(String message, LogType type) {
    String timestamp = DateFormat('HH:mm:ss').format(DateTime.now());
    _logs.add(LogEntry(message, type, timestamp));
    debugPrint("$timestamp - $message"); // Для отладки выводим в консоль
  }

  // Получение списка логов
  List<LogEntry> getLogs() {
    return _logs;
  }

  // Очистка всех логов
  void clearLogs() {
    _logs.clear();
  }
}
