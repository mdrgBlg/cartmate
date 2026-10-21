import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/providers/product_details_provider.dart';
import '/providers/search_provider.dart';
import '/screens/app/product_details_screen.dart';
import '/utils/custom_navigator.dart';

class SearchField extends StatelessWidget {
  const SearchField({required this.hintText, super.key});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(
        wishlistRepository: context.read(),
        productRepository: context.read(),
      ),
      child: _SearchFieldView(hintText: hintText),
    );
  }
}

class _SearchFieldView extends StatelessWidget {
  const _SearchFieldView({required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final searchProvider = context.watch<SearchProvider>();
    return Column(
      children: [
        Container(
          height: 52,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.secondary, width: 2),
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(
                !searchProvider.isFocused || !searchProvider.hasQuery ? 16 : 0,
              ),
              bottomRight: Radius.circular(
                !searchProvider.isFocused || !searchProvider.hasQuery ? 16 : 0,
              ),
            ),
          ),
          child: FocusScope(
            child: Focus(
              onFocusChange: searchProvider.focusChange,
              child: TextFormField(
                controller: searchProvider.searchController,
                textAlign: TextAlign.left,
                textInputAction: TextInputAction.next,
                onChanged: searchProvider.onQueryChanged,
                style: textTheme.bodyLarge!.copyWith(
                  color: CustomColors.text,
                  height: 1,
                ),
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  alignLabelWithHint: true,
                  hintStyle: textTheme.bodyLarge!.copyWith(
                    height: 1.4,
                    color: Colors.grey,
                  ),
                  hintText: hintText,
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: Colors.grey,
                  suffixIcon: searchProvider.hasQuery
                      ? InkWell(
                          onTap: searchProvider.clearInput,
                          child: const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: UnconstrainedBox(
                              child: Icon(Icons.close, color: Colors.grey),
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
        if (searchProvider.showResults)
          Container(
            height: 140,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              color: Colors.white,
            ),
            child: Scrollbar(
              radius: const Radius.circular(2),
              thumbVisibility: true,
              controller: searchProvider.searchScrollController,
              thickness: 4,
              child: Container(
                padding: searchProvider.hasQuery
                    ? const EdgeInsets.fromLTRB(16, 16, 16, 4)
                    : null,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    controller: searchProvider.searchScrollController,
                    itemCount: searchProvider.searchedProducts.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        final product = searchProvider.productAt(index);
                        CustomNavigator(context).pushNavigation(
                          routeName: ProductDetailsScreen.routeName,
                          screen: ChangeNotifierProvider(
                            create: (ctx) => ProductDetailsProvider(
                              wishlistRepository: ctx.read(),
                              cartRepository: ctx.read(),
                              product: product,
                            ),
                            child: const ProductDetailsScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 12),
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          searchProvider.searchedProducts[index].productName,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
