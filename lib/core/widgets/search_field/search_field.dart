import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/search_provider.dart';
import '/screens/app/product_details/product_details_screen.dart';
import '../../styles/custom_colors.dart';
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
    return Consumer<SearchProvider>(
      builder: (context, provider, child) => Column(
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
                  !provider.isFocused || !provider.hasQuery ? 16 : 0,
                ),
                bottomRight: Radius.circular(
                  !provider.isFocused || !provider.hasQuery ? 16 : 0,
                ),
              ),
            ),
            child: FocusScope(
              child: Focus(
                onFocusChange: provider.focusChange,
                child: TextFormField(
                  controller: provider.searchController,
                  textAlign: TextAlign.left,
                  textInputAction: TextInputAction.next,
                  onChanged: provider.onQueryChanged,
                  style: textTheme.bodyLarge!.copyWith(
                    color: CustomColors.text,
                    height: 1,
                  ),
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    filled: false,
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
                    suffixIcon: provider.hasQuery
                        ? InkWell(
                            onTap: provider.clearInput,
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
          if (provider.showResults)
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
                controller: provider.searchScrollController,
                thickness: 4,
                child: Container(
                  padding: provider.hasQuery
                      ? const EdgeInsets.fromLTRB(16, 16, 16, 4)
                      : null,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      controller: provider.searchScrollController,
                      itemCount: provider.searchedProducts.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          final product = provider.productAt(index);
                          CustomNavigator(context).pushNavigation(
                            routeName: ProductDetailsScreen.routeName,
                            screen: ProductDetailsScreen(
                              productsModel: product,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 12),
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            provider.searchedProducts[index].productName,
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
      ),
    );
  }
}
