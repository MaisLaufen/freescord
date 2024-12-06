import 'package:Freescord/presentation/pages/loading_screen.dart';
import 'package:Freescord/presentation/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'domain/services/global_navigator.dart';
import 'domain/services/tray_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  setupWindowListeners();
  const Size appSize = Size(400, 600);

  WindowOptions windowOptions = const WindowOptions(
    size: Size(400, 600),
    center: true,
    skipTaskbar: false,
    title: "Freescord",
    maximumSize: appSize,
    minimumSize: appSize,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setIcon('assets/icons/freescord_logo_circle.ico');
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
      builder: (context, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: TitleBar(navigatorKey: GlobalNavigator.navigatorKey),
          ),
          body: child,
        );
      },
      home: const LoadingScreen(),
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
