import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/utils/helpers.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';
import '/widgets/custom_button.dart';
import '../../../auth/signup/gender_selector.dart';
import '../profile_providers/profile_provider.dart';

class ChangeGender extends StatelessWidget {
  const ChangeGender({
    required this.sectionTitle,
    required this.changeInfo,
    required this.defaultValue,
    super.key,
  });

  final String sectionTitle;
  final Future<bool> Function(String?) changeInfo;
  final String? defaultValue;

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
            style: textTheme.titleLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Consumer<ProfileProvider>(
                builder: (_, profileProvider, child) => GenderSelector(
                  value: profileProvider.selectedGender,
                  onChanged: (newValue) => profileProvider.setGender(newValue),
                  genders: Helpers.genders,
                ),
              ),
            ),
            CustomButton(
              buttonText: "Save",
              enable: true,
              onPress: () {
                bool success = false;
                Loading.callLoading(
                  context: context,
                  callback: () async {
                    success = await changeInfo(
                      profileProvider.selectedGender ?? "",
                    );
                  },
                  onFinished: () {
                    if (success) {
                      SnackBarPopup.showMessage(
                        context,
                        message: "User successfully changed $sectionTitle",
                      );
                    }
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
