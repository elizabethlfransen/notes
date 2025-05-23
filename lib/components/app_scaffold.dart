import 'package:flutter/material.dart';
import 'package:notes_app/routes.dart';

import 'user_profile_icon.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SafeArea(
            child: RawMaterialButton(
              onPressed: () {
                SettingsScreenRoute().go(context);
              },
              shape: CircleBorder(),
              child: UserProfileIcon(),
            ),
          ),
        ],
      ),
      body: SafeArea(minimum: EdgeInsets.all(8), child: child),
    );
  }
}
