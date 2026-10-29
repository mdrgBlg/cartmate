import 'package:flutter/material.dart';

import '/core/l10n/app_localizations.dart';
import '/core/styles/app_radius.dart';
import '/core/styles/app_spacing.dart';
import '/data/models/auth_exception.dart';
import '/data/models/user_info_model.dart';
import '/utils/assets/custom_icons.dart';
import '/utils/global_enums.dart';
import 'logout.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.userInfo,
    required this.onMyOrdersTap,
    required this.signOut,
    super.key,
  });

  final UserInfoModel? userInfo;
  final VoidCallback onMyOrdersTap;
  final Future<AuthErrorType?> Function() signOut;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      color: colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localization.profileTitle,
                  style: textTheme.headlineSmall!.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Logout(signOut: signOut),
              ],
            ),
            Row(
              spacing: 12,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: AppRadius.pillAll,
                  ),
                  child: Image.asset(
                    userInfo?.gender == Gender.female
                        ? CustomIcons.femaleAvatar
                        : CustomIcons.manAvatar,
                    color: colorScheme.onSurface,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userInfo?.username ?? '',
                        style: textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        userInfo?.email ?? '',
                        style: textTheme.bodyMedium!.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: onMyOrdersTap,
                  child: Image.asset(
                    CustomIcons.myOrders,
                    color: colorScheme.onPrimary,
                    height: 32,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
