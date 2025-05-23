import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notes_app/routes.dart';
import 'package:notes_app/services/app_title.dart';
import 'package:notes_app/services/settings.dart';
import 'package:notes_app/theme.dart';

void main() {
  if (const String.fromEnvironment("ENVIRONMENT") != "gh-pages") {
    usePathUrlStrategy();
  }
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(appTitleProvider);
    final themeMode = ref.watch(themeModeSettingProvider);

    return MaterialApp.router(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode.value ?? ThemeMode.system,
      routerConfig: router,
    );
  }
}
