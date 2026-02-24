import 'package:cool_app/app/widgets/temperature_content.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:go_router/go_router.dart';
import '../features/home/home.dart';
import '../../di/di.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  debugLogDiagnostics: true,
  initialLocation: '/home',
  navigatorKey: _rootNavigationKey,
  routes: [
    GoRoute(
      path: '/home',
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/detail/:index',
      name: 'detail',
      builder: (context, state) {
        final index = int.parse(state.pathParameters['index'] ?? '0');
        final content = state.extra as TemperatureContent;
        return TemperatureDetailScreen(
          content: content,
          index: index,
        );
      },
    ),
  ],
);
