import 'package:e_commerce/constants/custom_colors.dart';
import 'package:e_commerce/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screen_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: ScreenWrapper(
        child: Column(
          children: [
            ClipPath(
              child: Container(
                height: 400,
                width: double.infinity,
                color: CustomColors.primary,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "${mainProvider.userInfoModel?.firstName ?? ""} ${mainProvider.userInfoModel?.lastName ?? ""}",
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
