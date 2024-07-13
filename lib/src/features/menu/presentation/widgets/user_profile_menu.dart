import 'package:bato_mechanic/src/shared/widgets/user_circle_avatar.dart';
import 'package:bato_mechanic/src/features/auth/application/auth_state.dart';
import 'package:bato_mechanic/src/routing/app_router.dart';
import 'package:bato_mechanic/src/shared/utils/constants/managers/font_manager.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/build_context_extensions.dart';
import 'package:bato_mechanic/src/shared/utils/helpers/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/providers/user_settings.dart';
import '../../../../shared/widgets/butons/submit_button.dart';
import 'menu_tile_section_widget.dart';
import 'menu_tile_widget.dart';
import '../../../../shared/utils/constants/managers/color_manager.dart';
import '../../../../shared/utils/constants/managers/values_manager.dart';

class UserProfileMenu extends ConsumerWidget {
  const UserProfileMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<MenuTile> profileTiles = [
      MenuTile(
        leadingIcon: Icons.person,
        title: 'Profile',
        trailingWidget: IconButton(
          iconSize: AppSize.s20,
          icon: const Icon(Icons.arrow_forward_ios_outlined),
          color: context.isDarkMode ? ThemeColor.light : ThemeColor.dark,
          onPressed: () => context.pushNamed(APP_ROUTE.customerProfile.name),
        ),
      ),
      MenuTile(
        leadingIcon: Icons.settings,
        title: 'Active Repair',
        trailingWidget: IconButton(
          iconSize: AppSize.s20,
          icon: const Icon(Icons.arrow_forward_ios_outlined),
          color: context.isDarkMode ? ThemeColor.light : ThemeColor.dark,
          onPressed: () => context.pushNamed(APP_ROUTE.activeRepairs.name),
        ),
      ),
      MenuTile(
        leadingIcon: Icons.settings,
        title: 'Recent Repairs',
        trailingWidget: IconButton(
          iconSize: AppSize.s20,
          icon: const Icon(Icons.arrow_forward_ios_outlined),
          color: context.isDarkMode ? ThemeColor.light : ThemeColor.dark,
          onPressed: () => context.pushNamed(APP_ROUTE.recentRepairs.name),
        ),
      ),
    ];

    List<MenuTile> settingsTiles = [
      MenuTile(
        leadingIcon: Icons.dark_mode,
        title: 'Dark mode',
        trailingWidget: IconButton(
          iconSize: AppSize.s20,
          icon: const Icon(Icons.arrow_forward_ios_outlined),
          color: context.isDarkMode ? ThemeColor.light : ThemeColor.dark,
          onPressed: () {
            final darkTile = ListTile(
                title: Text(
                  'Dark mode',
                  style: const TextStyle().copyWith(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  ref
                      .read(bThemeModeProvider.notifier)
                      .setThemeMode(ThemeMode.dark);
                  return;
                });

            final lightTile = ListTile(
                title: Text(
                  'Light mode',
                  style: const TextStyle().copyWith(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  ref
                      .read(bThemeModeProvider.notifier)
                      .setThemeMode(ThemeMode.light);
                  return;
                });

            final systemTile = ListTile(
                title: Text(
                  'System',
                  style: const TextStyle().copyWith(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  ref
                      .read(bThemeModeProvider.notifier)
                      .setThemeMode(ThemeMode.system);
                  return;
                });

            ToastHelper.showCenterAlertWithListOptions(
                context, [darkTile, lightTile, systemTile]);
          },
        ),
      ),
      MenuTile(
        leadingIcon: Icons.miscellaneous_services,
        title: 'Misc',
        trailingWidget: IconButton(
          iconSize: AppSize.s20,
          icon: const Icon(Icons.arrow_forward_ios_outlined),
          color: context.isDarkMode ? ThemeColor.light : ThemeColor.dark,
          onPressed: () {},
        ),
        isLast: true,
      )
    ];

    final List<MenuTile> moreTiles = [
      MenuTile(
        leadingIcon: Icons.notifications,
        title: 'Notifications',
        trailingWidget: IconButton(
          iconSize: AppSize.s20,
          onPressed: () {},
          icon: Icon(
            Icons.arrow_forward_ios,
            color: context.isDarkMode ? ThemeColor.light : ThemeColor.dark,
          ),
        ),
      ),
      MenuTile(
        leadingIcon: Icons.warning,
        title: 'About',
        trailingWidget: IconButton(
          iconSize: AppSize.s20,
          onPressed: () => context.pushNamed(APP_ROUTE.supportChat.name),
          icon: Icon(
            Icons.arrow_forward_ios,
            color: context.isDarkMode ? ThemeColor.light : ThemeColor.dark,
          ),
        ),
      ),
      MenuTile(
        leadingIcon: Icons.warning,
        title: 'Report an issue',
        trailingWidget: IconButton(
          iconSize: AppSize.s20,
          onPressed: () => context.pushNamed(APP_ROUTE.feedback.name),
          icon: Icon(
            Icons.arrow_forward_ios,
            color: context.isDarkMode ? ThemeColor.light : ThemeColor.dark,
          ),
        ),
      ),
      MenuTile(
        leadingIcon: Icons.policy,
        title: 'Privacy Policy ',
        trailingWidget: IconButton(
          iconSize: AppSize.s20,
          onPressed: () => context.pushNamed(APP_ROUTE.supportChat.name),
          icon: Icon(
            Icons.arrow_forward_ios,
            color: context.isDarkMode ? ThemeColor.light : ThemeColor.dark,
          ),
        ),
      ),
      MenuTile(
        leadingIcon: Icons.key,
        title: 'Terms and Conditions',
        trailingWidget: IconButton(
          iconSize: AppSize.s20,
          onPressed: () => context.pushNamed(APP_ROUTE.supportChat.name),
          icon: Icon(
            Icons.arrow_forward_ios,
            color: context.isDarkMode ? ThemeColor.light : ThemeColor.dark,
          ),
        ),
        isLast: true,
      ),
    ];

    List<MenuTile> connectTiles = [
      MenuTile(
        leadingIcon: Icons.feedback,
        title: 'Feedback',
        trailingWidget: IconButton(
          iconSize: AppSize.s20,
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
            color: context.isDarkMode ? ThemeColor.light : ThemeColor.dark,
          ),
          onPressed: () => context.pushNamed(APP_ROUTE.feedback.name),
        ),
      ),
      MenuTile(
        leadingIcon: Icons.wechat,
        title: 'Chat Support',
        trailingWidget: IconButton(
          iconSize: AppSize.s20,
          icon: const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          color: context.isDarkMode ? ThemeColor.light : ThemeColor.dark,
          onPressed: () => context.pushNamed(APP_ROUTE.supportChat.name),
        ),
        isLast: true,
      ),
    ];

    final user = ref.watch(authStateNotifierProvider).user;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p12, vertical: AppPadding.p45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const UserCircleAvatar(
                      radius: AppRadius.r50,
                    ),
                    const SizedBox(
                      width: AppHeight.h30,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? "Unknown user",
                            style: Theme.of(context).textTheme.headlineMedium,
                            softWrap: true,
                          ),
                          const SizedBox(
                            height: AppHeight.h12,
                          ),
                          Text(
                            'Joined',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: ColorManager.primaryTint10),
                          ),
                          Text(
                            '1 year ago',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppHeight.h30,
                ),
                MenuTilesSection(sectionTitle: 'Profile', tiles: profileTiles),
                const SizedBox(
                  height: AppHeight.h30,
                ),
                MenuTilesSection(
                    sectionTitle: 'Settings', tiles: settingsTiles),
                const SizedBox(
                  height: AppHeight.h30,
                ),
                MenuTilesSection(sectionTitle: 'More', tiles: moreTiles),
                const SizedBox(
                  height: AppHeight.h30,
                ),
                MenuTilesSection(sectionTitle: 'Connect', tiles: connectTiles),
                const SizedBox(
                  height: AppHeight.h30,
                ),
                SubmitButton(
                  label: 'Logout',
                  onPressed: () {
                    ref.read(authStateNotifierProvider.notifier).logOut();
                    context.goNamed(APP_ROUTE.login.name);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
