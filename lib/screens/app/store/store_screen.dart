import 'package:flutter/material.dart';

import '../../screen_wrapper.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  static const routeName = '/store';

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Center(
        child: Text("Store"),
      ),
    );
  }
}
