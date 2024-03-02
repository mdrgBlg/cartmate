import 'package:flutter/material.dart';

import '../../screen_wrapper.dart';

class WhishlistScreen extends StatelessWidget {
  const WhishlistScreen({super.key});

  static const routeName = '/whishlist';

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Center(
        child: Text("Whishlist"),
      ),
    );
  }
}
