import 'package:flutter/material.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';

class TrayManager {
  final SystemTray _systemTray = SystemTray();
  bool isProcessRunning = false;

  static final TrayManager _instance = TrayManager._internal();

  TrayManager._internal();

  factory TrayManager() => _instance;

  Future<void> initSystemTray() async {
    final AppWindow appWindow = AppWindow();

    await _systemTray.initSystemTray(
      title: "Flutter Tray App",
      iconPath: 'assets/freescord_circle_logo.ico', // Укажите путь к иконке
    );

    final Menu menu = Menu();
    await menu.buildFrom([
      MenuItemLabel(
          label: 'Открыть', onClicked: (menuItem) => windowManager.show()),
      MenuItemLabel(
        label: isProcessRunning ? 'Остановить процесс' : 'Запустить процесс',
        onClicked: (menuItem) {
          isProcessRunning = !isProcessRunning;
        },
      ),
      MenuItemLabel(
          label: 'Выход',
          onClicked: (menuItem) async {
            await windowManager.destroy();
          }),
    ]);

    await _systemTray.setContextMenu(menu);
    _systemTray.registerSystemTrayEventHandler((eventName) {
      if (eventName == kSystemTrayEventClick) {
        appWindow.show();
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
        builder: (context) => AlertDialog(
          title: const Text('Закрыть приложение?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await windowManager.hide();
              },
              child: const Text('Свернуть в трей'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await windowManager.destroy();
              },
              child: const Text('Закрыть'),
            ),
          ],
        ),
      );
    }
  }
}
