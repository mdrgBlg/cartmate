import 'package:e_commerce/constants/constants.dart';
import 'package:e_commerce/helpers/custom_navigator.dart';
import 'package:e_commerce/screens/app/profile/profile_widgets/information_widget.dart';
import 'package:e_commerce/screens/auth/login/login_providers/login_provider.dart';
import 'package:e_commerce/screens/auth/login/login_screen.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../constants/custom_colors.dart';
import '../../../providers/main_provider.dart';
import '../../screen_wrapper.dart';
import 'profile_widgets/curved_edges.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
              InformationWidget(
                sectionTitle: "Name",
                sectionText: "${mainProvider.userInfoModel?.firstName} ${mainProvider.userInfoModel?.lastName}",
              ),
              const Gap(12),
              InformationWidget(
                sectionTitle: "Username",
                sectionText: "${mainProvider.userInfoModel?.username}",
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
              InformationWidget(
                sectionTitle: "E-mail",
                sectionText: "${mainProvider.userInfoModel?.email}",
              ),
              const Gap(12),
              InformationWidget(
                sectionTitle: "Phone Number",
                sectionText: "${mainProvider.userInfoModel?.phoneNumber}",
              ),
              const Gap(12),
              InformationWidget(
                sectionTitle: "Gender",
                sectionText: "${mainProvider.userInfoModel?.gender}",
              ),
              const Gap(12),
              InformationWidget(
                sectionTitle: "Date of Birth",
                sectionText: "${mainProvider.userInfoModel?.dateOfBirth}",
              ),
              const Gap(16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: CustomColors.grayDark,
                ),
              ),
              const Gap(16),
              CustomButton(
                buttonText: "Logout",
                enable: true,
                onPress: () => Constants.firebaseAuth.signOut().then(
                      (value) => CustomNavigator.pushReplacement(
                        context: context,
                        routeName: LoginScreen.routeName,
                        screen: ChangeNotifierProvider(
                          create: (_) => LoginProvider(),
                          child: const LoginScreen(),
                        ),
                      ),
                    ),
                style: textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
