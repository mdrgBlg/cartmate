import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/widgets/layouts/main_layout.dart';
import '/screens/app/profile/my_orders_screen.dart';
import '/utils/custom_navigator.dart';
import '/utils/extensions/date_time_extension.dart';
import 'providers/profile_provider.dart';
import 'widgets/change_date_of_birth.dart';
import 'widgets/change_gender.dart';
import 'widgets/change_user_info.dart';
import 'widgets/change_user_name.dart';
import 'widgets/information_widget.dart';
import 'widgets/logout.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(
        authRepository: context.read(),
        cartRepository: context.read(),
        userRepository: context.read(),
      ),
      child: const _ProfileScreen(),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(
      context,
      listen: false,
    );

    final navigator = CustomNavigator(context);

    return MainLayout(
      showNavBar: true,
      child: SingleChildScrollView(
        child: Consumer<ProfileProvider>(
          builder: (context, value, child) {
            final userInfo = profileProvider.userInfo;
            return Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(
                  userInfo: userInfo,
                  onMyOrdersTap: () => navigator.pushNavigation(
                    routeName: MyOrdersScreen.routeName,
                    screen: const MyOrdersScreen(),
                  ),
                ),
                ProfileSection(
                  title: "Profile information",
                  children: [
                    InformationWidget(
                      sectionTitle: "Name",
                      sectionText:
                          "${userInfo?.firstName} ${userInfo?.lastName}",
                      onTap: () => navigator.pushNavigation(
                        screen: ChangeUserName(
                          sectionTitle: "Name",
                          firstNameController:
                              profileProvider.firstNameController,
                          lastNameController:
                              profileProvider.lastNameController,
                          onSave: profileProvider.changeName,
                          onSuccess: profileProvider.setName,
                        ),
                      ),
                    ),
                    InformationWidget(
                      sectionTitle: "Username",
                      sectionText: "${userInfo?.username}",
                      onTap: () => navigator.pushNavigation(
                        screen: ChangeUserInfo(
                          sectionTitle: "Username",
                          controller: profileProvider.usernameController,
                          onSave: profileProvider.changeUsername,
                          onSuccess: profileProvider.setUsername,
                        ),
                      ),
                    ),
                  ],
                ),
                ProfileSection(
                  title: "Personal information",
                  children: [
                    InformationWidget(
                      sectionTitle: "E-mail",
                      sectionText: "${userInfo?.email}",
                      onTap: () => navigator.pushNavigation(
                        screen: ChangeUserInfo(
                          sectionTitle: "E-mail",
                          controller: profileProvider.emailController,
                          onSave: profileProvider.changeEmail,
                          onSuccess: profileProvider.setEmail,
                        ),
                      ),
                    ),
                    InformationWidget(
                      sectionTitle: "Phone Number",
                      sectionText: "${userInfo?.phoneNumber}",
                      onTap: () => navigator.pushNavigation(
                        screen: ChangeUserInfo(
                          sectionTitle: "Phone Number",
                          controller: profileProvider.phoneController,
                          onSave: profileProvider.changePhoneNumber,
                          onSuccess: profileProvider.setPhoneNumber,
                        ),
                      ),
                    ),
                    InformationWidget(
                      sectionTitle: "Gender",
                      sectionText: "${userInfo?.gender.genderName()}",
                      onTap: () => navigator.pushNavigation(
                        screen: ChangeGender(
                          sectionTitle: "Gender",
                          initialGender: profileProvider.userInfo?.gender,
                          onSave: profileProvider.changeGender,
                          onSuccess: profileProvider.setGender,
                        ),
                      ),
                    ),
                    InformationWidget(
                      sectionTitle: "Date of Birth",
                      sectionText: userInfo?.dateOfBirth.formatDateTime() ?? '',
                      onTap: () => navigator.pushNavigation(
                        screen: ChangeDateOfBirth(
                          sectionTitle: "Date of Birth",
                          initialDate: profileProvider.userInfo?.dateOfBirth,
                          onSave: profileProvider.changeDateOfBirth,
                          onSuccess: profileProvider.setDateOfBirth,
                        ),
                      ),
                    ),
                  ],
                ),
                Logout(signOut: profileProvider.signOut),
              ],
            );
          },
        ),
      ),
    );
  }
}
