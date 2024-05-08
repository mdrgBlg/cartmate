import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screen_wrapper.dart';
import '/providers/main_provider.dart';
import '/widgets/products_grid_view.dart';

class WhishlistScreen extends StatelessWidget {
  const WhishlistScreen({super.key});

  static const routeName = '/whishlist';

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: ScreenWrapper(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Whislist",
                      style: textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Consumer<MainProvider>(
                    builder: (_, __, child) => ProductsGridView(
                      productsList: mainProvider.whishlistProductsList,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
