import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im/core/router.dart';

void main() {
  runApp(const ProviderScope(child: IMApp()));
}

class IMApp extends ConsumerWidget {
  const IMApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return CupertinoApp.router(
      title: 'IM App',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        applyThemeToAll: true,
      ),
      routerConfig: router,
    );
  }
}
