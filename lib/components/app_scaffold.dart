import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          SafeArea(
            child: RawMaterialButton(
              onPressed: () {},
              shape: CircleBorder(),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: Icon(Icons.person),
              ),
            ),
          ),
        ],
      ),
      body: child,
    );
  }
}
