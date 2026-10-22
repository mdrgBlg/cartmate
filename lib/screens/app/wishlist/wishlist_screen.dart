import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/layouts/main_layout.dart';
import '/widgets/products_grid_view/products_grid_view.dart';
import 'providers/wishlist_provider.dart';

class WhishlistScreen extends StatelessWidget {
  const WhishlistScreen({super.key});

  static const routeName = '/wishlist';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<WishlistProvider>(context, listen: false);
    return MainLayout(
      showNavBar: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 28),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    "Wishlist",
                    style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FutureBuilder(
                  future: provider.wishlistFuture,
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                      ? const Center(child: CircularProgressIndicator())
                      : snapshot.data == null
                      ? Consumer<WishlistProvider>(
                          builder: (_, wishlistProvider, child) =>
                              ProductsGridView(
                                productsList: wishlistProvider.products,
                              ),
                        )
                      :
                        /// TODO Handle error
                        Text("Error"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
