import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/custom_colors.dart';
import '/utils/loading.dart';
import '/utils/snack_bar_popup.dart';
import '/widgets/custom_button.dart';
import '../../../auth/signup/date_picker.dart';
import '../profile_providers/profile_provider.dart';

class ChangeDateOfBirth extends StatelessWidget {
  const ChangeDateOfBirth({
    required this.sectionTitle,
    required this.changeInfo,
    required this.defaultValue,
    super.key,
  });

  final String sectionTitle;
  final Future<bool> Function(String?) changeInfo;
  final DateTime defaultValue;

  static const routeName = '/change_date_of_birth';

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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
                child: Consumer<ProfileProvider>(
                  builder: (_, __, child) => DatePicker(
                    dateController: profileProvider.controller,
                    pickedDate: profileProvider.pickedDate,
                    onDatePicked: (DateTime? pickedDate) {
                      if (pickedDate != null) {
                        profileProvider.setPickedDate(pickedDate);
                      }
                    },
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
                        profileProvider.pickedDate.toString(),
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
      ),
    );
  }
}
