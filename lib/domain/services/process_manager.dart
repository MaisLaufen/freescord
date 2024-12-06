import 'dart:io';
import 'package:Freescord/domain/zapret/cfg.dart';
import 'package:flutter/material.dart';

class ProcessManager {
  Process? _process;
  final ValueNotifier<bool> isRunningNotifier = ValueNotifier(false);
  String path = winwsPath;

  // Синглтон
  static final ProcessManager _instance = ProcessManager._internal();
  ProcessManager._internal();
  factory ProcessManager() => _instance;

  Future<void> startProcess(
      {List<String> arguments = defaultDiscordCommand}) async {
    _process = await Process.start(path, arguments);
    isRunningNotifier.value = true;
    debugPrint('winws started with $arguments arguments');
  }

  Future<void> killProcess() async {
    if (_process != null) {
      _process!.kill();
      _process = null;
      isRunningNotifier.value = false;
      debugPrint('winws killed');
    }
  }

  bool get isRunning => isRunningNotifier.value;
}
