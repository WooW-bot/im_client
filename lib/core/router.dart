import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im/core/mock_data.dart';
import 'package:im/features/auth/login_screen.dart';
import 'package:im/features/home/home_screen.dart';
import 'package:im/features/chat/chat_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final user = ref.read(authProvider);
      final isLoggedIn = user != null;
      final isLoggingIn = state.uri.toString() == '/login';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/';
      return null;
    },
    refreshListenable: _AuthStateNotifier(ref),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/chat/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ChatScreen(conversationId: id);
        },
      ),
    ],
  );
});

class _AuthStateNotifier extends ChangeNotifier {
  final Ref ref;

  _AuthStateNotifier(this.ref) {
    ref.listen(authProvider, (_, __) => notifyListeners());
  }
}
