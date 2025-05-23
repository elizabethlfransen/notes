import 'package:flutter/material.dart';

class UserProfileIcon extends StatelessWidget {
  const UserProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return CircleAvatar(
      backgroundColor: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
      foregroundColor: isDarkMode ? Colors.black : Colors.white,
      child: Icon(Icons.person),
    );
  }
}
