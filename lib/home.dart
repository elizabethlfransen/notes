import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notes_app/services/app_title.dart';

const isRunningWithWasm = bool.fromEnvironment('dart.tool.dart2wasm');

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAppTitle("Home", ref);

    return Center(child: Text("Is Running With Wasm: $isRunningWithWasm"));
  }
}
