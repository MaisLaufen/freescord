import 'package:Freescord/presentation/pages/about.dart';
import 'package:Freescord/presentation/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const TitleBar({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        height: 30,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Кнопки навигации
            Row(
              children: [
                _TitleBarButton(
                  icon: Icons.minimize,
                  onPressed: () async => await windowManager.minimize(),
                ),
                _TitleBarButton(
                  icon: Icons.close,
                  onPressed: () async => await windowManager.close(),
                ),
                _TitleBarButton(
                  icon: Icons.info,
                  onPressed: () {
                    navigatorKey.currentState?.push(
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                ),
                _TitleBarButton(
                  icon: Icons.settings,
                  onPressed: () {
                    navigatorKey.currentState?.push(
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _TitleBarButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onPressed,
    );
  }
}
