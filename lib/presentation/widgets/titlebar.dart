import 'package:freescord/presentation/pages/about.dart';
import 'package:freescord/presentation/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const TitleBar({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        height: 30,
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/freescord_logo.png',
                  height: 22,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Freescord',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
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
