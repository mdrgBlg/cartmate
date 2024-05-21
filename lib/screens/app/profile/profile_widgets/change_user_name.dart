import 'package:e_commerce/helpers/loading.dart';
import 'package:e_commerce/helpers/snack_bar_popup.dart';
import 'package:flutter/material.dart';

import '/constants/custom_colors.dart';
import '/widgets/custom_button.dart';
import '/widgets/input_field.dart';

class ChangeUserName extends StatelessWidget {
  final String sectionTitle;
  final Function(String, String) changeInfo;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  const ChangeUserName({
    super.key,
    required this.sectionTitle,
    required this.changeInfo,
    required this.firstNameController,
    required this.lastNameController,
  });

  static const routeName = '/change_user_name';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                child: InputField(
                  hintText: "First name",
                  controller: firstNameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 24),
                child: InputField(
                  hintText: "Last name",
                  controller: lastNameController,
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
                        firstNameController.text,
                        lastNameController.text,
                      );
                    },
                    onFinished: () {
                      if (success) {
                        SnackBarPopup.showMessage(context,
                            message: "User successfully changed $sectionTitle");
                      }
                      Navigator.of(context).pop();
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
