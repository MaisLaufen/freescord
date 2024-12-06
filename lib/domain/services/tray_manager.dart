import 'package:freescord/domain/services/process_manager.dart';
import 'package:freescord/presentation/dialogs/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';

class TrayManager {
  final SystemTray _systemTray = SystemTray();
  final AppWindow _appWindow = AppWindow();

  static final TrayManager _instance = TrayManager._internal();

  TrayManager._internal();

  factory TrayManager() => _instance;

  Future<void> initSystemTray() async {
    await _systemTray.initSystemTray(
      title: "Freescord",
      iconPath: 'assets/icons/freescord_logo_circle.ico',
    );

    _updateTrayMenu();

    ProcessManager().isRunningNotifier.addListener(() {
      _updateTrayMenu();
    });

    _systemTray.registerSystemTrayEventHandler((eventName) {
      if (eventName == kSystemTrayEventClick) {
        _appWindow.show();
      } else if (eventName == kSystemTrayEventRightClick) {
        _systemTray.popUpContextMenu();
      }
    });
  }

  Future<void> handleWindowClose(BuildContext context) async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      showDialog(
        context: context,
        builder: (context) => ExitDialog(
          onExit: () async {
            Navigator.of(context).pop();
            ProcessManager().killProcess();
            await windowManager.destroy(); // Закрыть приложение
          },
          onMinimize: () async {
            Navigator.of(context).pop();
            await windowManager.hide(); // Свернуть в трей
          },
        ),
      );
    }
  }

  void _updateTrayMenu() async {
    final Menu menu = Menu();
    await menu.buildFrom([
      MenuItemLabel(
          label: 'Открыть', onClicked: (menuItem) => _appWindow.show()),
      MenuItemLabel(
        label: ProcessManager().isRunning
            ? 'Остановить процесс'
            : 'Запустить процесс',
        onClicked: (menuItem) {
          if (ProcessManager().isRunning) {
            ProcessManager().killProcess();
          } else {
            ProcessManager().startProcess();
          }
        },
      ),
      MenuItemLabel(
          label: 'Выход',
          onClicked: (menuItem) async {
            await _appWindow.close();
          }),
    ]);

    await _systemTray.setContextMenu(menu);
  }
}
