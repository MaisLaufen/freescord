import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gui_zapret/domain/zapret/cfg.dart';

class ProcessManager {
  Process? _process;
  final ValueNotifier<bool> isRunningNotifier = ValueNotifier(false);
  String path = winwsPath;

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