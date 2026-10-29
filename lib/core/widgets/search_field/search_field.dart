import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/search_provider.dart';
import '/core/l10n/app_localizations.dart';
import '/screens/app/product_details/product_details_screen.dart';
import '../../styles/app_radius.dart';
import '../../styles/app_spacing.dart';
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
    final localization = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Consumer<SearchProvider>(
      builder: (context, provider, child) => Column(
        children: [
          Container(
            height: 52,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.surface, width: 2),
              color: colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(AppRadius.lg),
                topRight: const Radius.circular(AppRadius.lg),
                bottomLeft: Radius.circular(
                  !provider.isFocused || !provider.hasQuery ? AppRadius.lg : 0,
                ),
                bottomRight: Radius.circular(
                  !provider.isFocused || !provider.hasQuery ? AppRadius.lg : 0,
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
                    color: colorScheme.onSurface,
                    height: 1,
                  ),
                  cursorColor: colorScheme.onSurfaceVariant,
                  decoration: InputDecoration(
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    alignLabelWithHint: true,
                    hintStyle: textTheme.bodyLarge!.copyWith(
                      height: 1.4,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    hintText: hintText,
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: colorScheme.onSurfaceVariant,
                    suffixIcon: provider.hasQuery
                        ? InkWell(
                            onTap: provider.clearInput,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: AppSpacing.sm,
                              ),
                              child: UnconstrainedBox(
                                child: Icon(
                                  Icons.close,
                                  color: colorScheme.onSurfaceVariant,
                                ),
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
              height: provider.searchedProducts.isEmpty ? 56 : 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppRadius.md),
                  bottomRight: Radius.circular(AppRadius.md),
                ),
                color: colorScheme.surface,
              ),
              child: provider.searchedProducts.isEmpty
                  ? Center(
                      child: Text(
                        provider.hasError
                            ? localization.somethingWentWrong
                            : localization.searchNoResults,
                        style: textTheme.bodyMedium!.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : Scrollbar(
                      radius: const Radius.circular(2),
                      thumbVisibility: true,
                      controller: provider.searchScrollController,
                      thickness: 4,
                      child: Container(
                        padding: provider.hasQuery
                            ? const EdgeInsets.fromLTRB(
                                AppSpacing.lg,
                                AppSpacing.lg,
                                AppSpacing.lg,
                                AppSpacing.xs,
                              )
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
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.md,
                                ),
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  provider.searchedProducts[index].productName,
                                  style: textTheme.bodyLarge,
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
