import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/signup/gender_selector.dart';
import '../profile_providers/profile_provider.dart';
import '/constants/custom_colors.dart';
import '/helpers/helpers.dart';
import '/widgets/custom_button.dart';

class ChangeGender extends StatelessWidget {
  final String sectionTitle;
  final Function(String?) changeInfo;
  final String? defaultValue;
  const ChangeGender({
    super.key,
    required this.sectionTitle,
    required this.changeInfo,
    required this.defaultValue,
  });

  static const routeName = '/change_user_name';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 52,
          backgroundColor: CustomColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Change $sectionTitle",
            style: textTheme.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 24),
                child: Consumer<ProfileProvider>(
                  builder: (_, profileProvider, child) => GenderSelector(
                    value: profileProvider.selectedGender,
                    onChanged: (newValue) =>
                        profileProvider.setGender(newValue),
                    genders: Helpers.genders,
                  ),
                ),
              ),
              CustomButton(
                buttonText: "Save",
                enable: true,
                onPress: () => changeInfo(
                  profileProvider.selectedGender ?? "",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
