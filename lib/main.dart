import 'package:flutter/material.dart';
import 'package:gui_zapret/presentation/pages/splash_screen.dart';
import 'package:window_manager/window_manager.dart';
import 'domain/services/global_navigator.dart';
import 'domain/services/tray_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  setupWindowListeners();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(400, 600),
    center: true,
    skipTaskbar: false,
    title: "Freescord",
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setIcon('assets/freescord_circle_logo.ico');
    await windowManager.setPreventClose(true);
    await windowManager.show();
    await windowManager.focus();
  });

  await TrayManager().initSystemTray();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      navigatorKey: GlobalNavigator.navigatorKey,
    );
  }
}

class WindowCloseHandler with WindowListener {
  @override
  void onWindowClose() async {
    TrayManager()
        .handleWindowClose(GlobalNavigator.navigatorKey.currentContext!);
  }
}

void setupWindowListeners() {
  windowManager.addListener(WindowCloseHandler());
}
