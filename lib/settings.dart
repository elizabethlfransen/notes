import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notes_app/routes.dart';
import 'package:notes_app/services/app_title.dart';
import 'package:notes_app/services/settings.dart';
import 'package:notes_app/util/breakpoints.dart';

final _labelKey = UniqueKey();
final _childKey = UniqueKey();

class _SettingsItem extends StatelessWidget {
  final String label;
  final Widget child;

  const _SettingsItem({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final label = Text(
      this.label.toUpperCase(),
      key: _labelKey,
      style: Theme.of(context).textTheme.labelLarge,
    );
    final child = Container(key: _childKey, child: this.child);
    return BreakpointBuilder(
      small: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [label, child],
      ),
      medium: Row(
        children: [
          Expanded(flex: 1, child: label),
          Expanded(flex: 3, child: child),
        ],
      ),
    );
  }
}

class _ColorThemeSettingItem extends HookConsumerWidget {
  const _ColorThemeSettingItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeSettingProvider).value ?? ThemeMode.system;
    final setTheme = ref.read(
      themeModeSettingProvider.notifier.select((notifier) => notifier.set),
    );
    return _SettingsItem(
      label: "Color Mode",
      child: Align(
        child: SegmentedButton<ThemeMode>(
          segments: <ButtonSegment<ThemeMode>>[
            ButtonSegment(
              value: ThemeMode.system,
              label: Text("System"),
              icon: Icon(Icons.settings_brightness),
            ),
            ButtonSegment(
              value: ThemeMode.dark,
              label: Text("Dark"),
              icon: Icon(Icons.dark_mode),
            ),
            ButtonSegment(
              value: ThemeMode.light,
              label: Text("Light"),
              icon: Icon(Icons.light_mode),
            ),
          ],
          style: SegmentedButton.styleFrom(
            visualDensity: VisualDensity(vertical: 2, horizontal: 2),
          ),
          selected: {theme},
          showSelectedIcon: false,
          onSelectionChanged: (value) {
            setTheme(value.single);
          },
        ),
      ),
    );
  }
}

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAppTitle("Settings", ref);
    return SizedContainer(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          _ColorThemeSettingItem(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () {
                  HomeScreenRoute().go(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Return Home"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
