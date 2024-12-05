// Enum для типов сообщений
enum LogType { info, success, error }

// Класс для представления записи лога
class LogEntry {
  final String message;
  final LogType type;
  final String timestamp;

  LogEntry(this.message, this.type, this.timestamp);
}
