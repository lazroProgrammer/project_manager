import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';

class DarkmodeToggle extends ConsumerWidget {
  const DarkmodeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(darkmodeNotifier);
    return IconButton(
      onPressed: () {
        ref.read(darkmodeNotifier.notifier).toggleDarkmode(!dark);
      },
      icon: TweenAnimationBuilder(
        curve: Easing.legacyAccelerate,
        tween: Tween<double>(begin: 0, end: dark ? 0 : 2),
        duration: const Duration(milliseconds: 500),
        builder: (context, value, child) {
          return Transform.rotate(
            angle: value * 3.14, // Rotation animation
            child: Opacity(
              opacity: (1 - (value % 2)).abs(), // Fading effect
              child: Icon(
                dark ? Icons.dark_mode : Icons.light_mode,
                size: 30,
                color: dark ? Colors.blue[700] : Colors.yellow[700],
              ),
            ),
          );
        },
      ),
    );
  }
}
