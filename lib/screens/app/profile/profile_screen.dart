import 'package:e_commerce/constants/custom_icons.dart';
import 'package:e_commerce/screens/app/profile/my_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../auth/logout.dart';
import '../../screen_wrapper.dart';
import '/constants/custom_colors.dart';
import '/helpers/custom_navigator.dart';
import '/helpers/date_time_service.dart';
import '/providers/main_provider.dart';
import 'profile_providers/profile_provider.dart';
import 'profile_widgets/change_date_of_birth.dart';
import 'profile_widgets/change_gender.dart';
import 'profile_widgets/change_user_info.dart';
import 'profile_widgets/change_user_name.dart';
import 'profile_widgets/curved_edges.dart';
import 'profile_widgets/information_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );
    final mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    return SafeArea(
      child: ScreenWrapper(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: CurvedEdges(),
                child: Container(
                  width: double.infinity,
                  height: 170,
                  color: CustomColors.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(8),
                        Text(
                          "Profile",
                          style: textTheme.headlineSmall!.copyWith(
                            color: CustomColors.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(16),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                            const Gap(12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${mainProvider.userInfoModel?.username}",
                                  style: textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "${mainProvider.userInfoModel?.email}",
                                  style: textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () => CustomNavigator.pushNavigation(
                                context: context,
                                routeName: MyOrdersScreen.routeName,
                                screen: ChangeNotifierProvider.value(
                                  value: profileProvider,
                                  child: const MyOrdersScreen(),
                                ),
                              ),
                              child: Image.asset(
                                CustomIcons.myOrders,
                                color: Colors.white,
                                height: 32,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(8),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Profile information",
                  style: textTheme.titleLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const Gap(16),
              Consumer<MainProvider>(
                builder: (_, __, child) => InformationWidget(
                  sectionTitle: "Name",
                  sectionText:
                      "${mainProvider.userInfoModel?.firstName} ${mainProvider.userInfoModel?.lastName}",
                  onTap: () => CustomNavigator.pushNavigation(
                    context: context,
                    routeName: ChangeUserName.routeName,
                    screen: ChangeUserName(
                      sectionTitle: "Name",
                      changeInfo: mainProvider.changeUserName,
                      firstNameController: TextEditingController(
                          text: mainProvider.userInfoModel?.firstName),
                      lastNameController: TextEditingController(
                        text: mainProvider.userInfoModel?.lastName,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Consumer<MainProvider>(
                builder: (_, __, child) => InformationWidget(
                  sectionTitle: "Username",
                  sectionText: "${mainProvider.userInfoModel?.username}",
                  onTap: () => CustomNavigator.pushNavigation(
                    context: context,
                    routeName: ChangeUserInfo.routeName,
                    screen: ChangeUserInfo(
                      sectionTitle: "Username",
                      changeInfo: mainProvider.changeUsername,
                      controller: TextEditingController(
                        text: mainProvider.userInfoModel?.username,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: CustomColors.grayDark,
                ),
              ),
              const Gap(8),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Personal information",
                  style: textTheme.titleLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const Gap(16),
              Consumer<MainProvider>(
                builder: (_, __, child) => InformationWidget(
                  sectionTitle: "E-mail",
                  sectionText: "${mainProvider.userInfoModel?.email}",
                  onTap: () => CustomNavigator.pushNavigation(
                    context: context,
                    routeName: ChangeUserInfo.routeName,
                    screen: ChangeUserInfo(
                      sectionTitle: "E-mail",
                      changeInfo: mainProvider.changeEmail,
                      controller: TextEditingController(
                          text: mainProvider.userInfoModel?.email),
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Consumer<MainProvider>(
                builder: (_, __, child) => InformationWidget(
                  sectionTitle: "Phone Number",
                  sectionText: "${mainProvider.userInfoModel?.phoneNumber}",
                  onTap: () => CustomNavigator.pushNavigation(
                    context: context,
                    routeName: ChangeUserInfo.routeName,
                    screen: ChangeUserInfo(
                      sectionTitle: "Phone Number",
                      changeInfo: mainProvider.changeUserPhoneNumber,
                      controller: TextEditingController(
                          text: mainProvider.userInfoModel?.phoneNumber),
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Consumer<MainProvider>(
                builder: (_, __, child) => InformationWidget(
                  sectionTitle: "Gender",
                  sectionText: "${mainProvider.userInfoModel?.gender}",
                  onTap: () {
                    profileProvider.selectedGender =
                        mainProvider.userInfoModel?.gender;
                    CustomNavigator.pushNavigation(
                      context: context,
                      routeName: ChangeGender.routeName,
                      screen: ChangeNotifierProvider.value(
                        value: profileProvider,
                        child: ChangeGender(
                          sectionTitle: "Gender",
                          changeInfo: mainProvider.changeGender,
                          defaultValue: profileProvider.selectedGender,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(12),
              Consumer<MainProvider>(
                builder: (_, __, child) => InformationWidget(
                  sectionTitle: "Date of Birth",
                  sectionText: DateTimeService.formatDateTime(
                    mainProvider.userInfoModel?.dateOfBirth,
                  ),
                  onTap: () {
                    profileProvider.setPickedDate(
                      DateTime.parse(
                        mainProvider.userInfoModel?.dateOfBirth ??
                            DateTime.now().toString(),
                      ),
                    );
                    profileProvider.controller.text =
                        DateTimeService.formatDateTime(
                      mainProvider.userInfoModel?.dateOfBirth ??
                          DateTime.now().toString(),
                    );
                    CustomNavigator.pushNavigation(
                      context: context,
                      routeName: ChangeDateOfBirth.routeName,
                      screen: ChangeNotifierProvider.value(
                        value: profileProvider,
                        child: ChangeDateOfBirth(
                          sectionTitle: "Date of Birth",
                          changeInfo: mainProvider.changeDateOfBirth,
                          defaultValue: DateTime.parse(
                              mainProvider.userInfoModel?.dateOfBirth ??
                                  DateTime.now().toString()),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: CustomColors.grayDark,
                ),
              ),
              const Gap(16),
              const Logout(),
            ],
          ),
        ),
      ),
    );
  }
}
