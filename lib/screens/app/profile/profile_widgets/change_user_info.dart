import 'package:flutter/material.dart';

import '/constants/custom_colors.dart';
import '/helpers/loading.dart';
import '/helpers/snack_bar_popup.dart';
import '/widgets/custom_button.dart';
import '/widgets/input_field.dart';

class ChangeUserInfo extends StatelessWidget {
  final String sectionTitle;
  final Function(String) changeInfo;
  final TextEditingController controller;
  const ChangeUserInfo(
      {super.key,
      required this.sectionTitle,
      required this.changeInfo,
      required this.controller});

  static const routeName = '/change_user_info';

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
                padding: const EdgeInsets.only(top: 12, bottom: 24),
                child: InputField(
                  hintText: sectionTitle,
                  controller: controller,
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
                      success = await changeInfo(controller.text);
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
