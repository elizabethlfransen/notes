import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/components/app_scaffold.dart';
import 'package:notes_app/home.dart';
import 'package:notes_app/settings.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeScreenRoute>(path: "/")
@immutable
class HomeScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@TypedGoRoute<SettingsScreenRoute>(path: "/settings")
@immutable
class SettingsScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}

final router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppScaffold(child: child),
      routes: $appRoutes,
    ),
  ],
);
