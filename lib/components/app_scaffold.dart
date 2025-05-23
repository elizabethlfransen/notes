import 'package:flutter/material.dart';

import '../routes.dart';
import 'user_profile_icon.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(horizontal: 16),
        actions: [
          RawMaterialButton(
            constraints: BoxConstraints(minWidth: 36, minHeight: 36),
            onPressed: () {
              SettingsScreenRoute().go(context);
            },
            shape: CircleBorder(),
            child: UserProfileIcon(),
          ),
        ],
      ),
      body: SafeArea(minimum: EdgeInsets.all(8), child: child),
    );
  }
}
