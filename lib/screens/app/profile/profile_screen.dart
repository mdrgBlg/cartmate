import 'package:flutter/material.dart';

import '../../screen_wrapper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Center(
        child: Text("Profile"),
      ),
    );
  }
}
