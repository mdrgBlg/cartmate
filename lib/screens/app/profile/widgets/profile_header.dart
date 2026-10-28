import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/custom_colors.dart';
import '/data/models/user_info_model.dart';
import '/utils/assets/custom_icons.dart';
import '/utils/global_enums.dart';
import 'curved_edges.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.userInfo,
    required this.onMyOrdersTap,
    super.key,
  });

  final UserInfoModel? userInfo;
  final VoidCallback onMyOrdersTap;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return ClipPath(
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
                localization.profileTitle,
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
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Image.asset(
                      userInfo?.gender == Gender.male
                          ? CustomIcons.manAvatar
                          : CustomIcons.manAvatar,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const Gap(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${userInfo?.username}",
                        style: textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${userInfo?.email}",
                        style: textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: onMyOrdersTap,
                    child: Image.asset(
                      CustomIcons.myOrders,
                      color: Colors.white,
                      height: 32,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
