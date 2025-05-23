import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_title.g.dart';

@riverpod
class AppTitle extends _$AppTitle {
  @override
  String build() {
    return "Notes";
  }

  void setTitle(String title) {
    state = title;
  }
}

void useAppTitle(String title, WidgetRef ref) {
  final notifier = ref.read(appTitleProvider.notifier);
  useEffect(() {
    Future(() => notifier.setTitle(title));
    return null;
  }, [title]);
}
