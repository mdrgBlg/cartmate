import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/providers/main_provider.dart';
import '/providers/product_details_provider.dart';
import '/screens/app/home/home_providers/home_provider.dart';
import '/screens/app/product_details_screen.dart';
import '/utils/custom_navigator.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    required this.searchController,
    required this.hintText,
    required this.onChanged,
    required this.clearInput,
    super.key,
  });
  final TextEditingController searchController;
  final String hintText;
  final void Function(String) onChanged;
  final void Function() clearInput;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final homeProvider = Provider.of<HomeProvider>(context);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
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
                !homeProvider.isFocused ||
                        homeProvider.searchController.text.isEmpty
                    ? 16
                    : 0,
              ),
              bottomRight: Radius.circular(
                !homeProvider.isFocused ||
                        homeProvider.searchController.text.isEmpty
                    ? 16
                    : 0,
              ),
            ),
          ),
          child: FocusScope(
            child: Focus(
              onFocusChange: (value) => homeProvider.focusChange(value),
              child: TextFormField(
                controller: searchController,
                textAlign: TextAlign.left,
                textInputAction: TextInputAction.next,
                onChanged: onChanged,
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
                  suffixIcon: searchController.text.isNotEmpty
                      ? InkWell(
                          onTap: clearInput,
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
        if (homeProvider.isFocused &&
            homeProvider.searchedProductsList.isNotEmpty)
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  padding: homeProvider.searchController.text.isNotEmpty
                      ? const EdgeInsets.fromLTRB(16, 16, 16, 4)
                      : null,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Scrollbar(
                      radius: const Radius.circular(2),
                      thumbVisibility: true,
                      controller: homeProvider.searchScrollController,
                      thickness: 4,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        controller: homeProvider.searchScrollController,
                        itemCount: homeProvider.searchedProductsList.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () => CustomNavigator(context).pushNavigation(
                            routeName: ProductDetailsScreen.routeName,
                            screen: ChangeNotifierProvider(
                              create: (_) => ProductDetailsProvider(),
                              child: ProductDetailsScreen(
                                product: mainProvider.productsList.singleWhere(
                                  (element) =>
                                      element.id ==
                                      homeProvider
                                          .searchedProductsList[index]
                                          .id,
                                ),
                              ),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 12),
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              homeProvider
                                  .searchedProductsList[index]
                                  .productName,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
