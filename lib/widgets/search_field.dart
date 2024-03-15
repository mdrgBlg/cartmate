import 'package:flutter/material.dart';

import '/constants/custom_colors.dart';

class SearchField extends StatelessWidget {
  final TextEditingController searchController;
  final String hintText;
  final Function(String) onChanged;
  final Function() clearInput;
  const SearchField({
    super.key,
    required this.searchController,
    required this.hintText,
    required this.onChanged,
    required this.clearInput,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.secondary,
          width: 2,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
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
          prefixIcon: const Icon(
            Icons.search,
          ),
          prefixIconColor: Colors.grey,
          suffixIcon: searchController.text.isNotEmpty
              ? InkWell(
                  onTap: clearInput,
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                    ),
                    child: UnconstrainedBox(
                      child: Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
