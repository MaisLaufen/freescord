import 'package:flutter/material.dart';

class WillCloseDialog extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onMinimize;

  const WillCloseDialog({
    super.key,
    required this.onClose,
    required this.onMinimize,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Закрыть приложение?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onMinimize();
          },
          child: const Text('Свернуть в трей'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onClose();
          },
          child: const Text('Закрыть'),
        ),
      ],
    );
  }
}
