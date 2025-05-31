import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:inbrief/screens/login/login.dart';
import 'package:inbrief/screens/profile/widgets/appbar.dart';
import 'package:inbrief/screens/profile/widgets/primary_header_container.dart';
import 'package:inbrief/screens/profile/widgets/section_heading.dart';
import 'package:inbrief/screens/profile/widgets/setting_menu_tile.dart';
import 'package:inbrief/screens/profile/widgets/theme_controller.dart';
import 'package:inbrief/screens/profile/widgets/user_profile_tile.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/text_strings.dart';
import '../../utils/constants/sizes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Get the ThemeController instance
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -Header
            TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    TAppBar(
                        title: Text('Account',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .apply(color: TColors.white))),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    ///User Profile Card
                    TUserProfileTile(
                        userName: TTexts.userAccount,
                        userEmail: TTexts.userEmail,
                        onPressed: () {}),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                )),

            ///-Body
            Padding(
              padding: EdgeInsets.all(TSizes.spaceBtwSections),
              child: Column(
                children: [
                  /// -- Account Setting
                  const TSectionHeading(title: 'App Settings'),
                  SizedBox(height: TSizes.spaceBtwItems),

                  // TSettingsMenuTile(
                  //   icon: Iconsax.security_user,
                  //   title: 'Terms of Service',
                  //   subTitle: 'Services',
                  //   onTap: () {
                  //     // Navigator.push(context,MaterialPageRoute(builder : (context) => Terms()));
                  //   },
                  // ),

                  // TSettingsMenuTile(
                  //   icon: Iconsax.user,
                  //   title: 'About Us',
                  //   subTitle: 'Know more about us',
                  //   onTap: () {
                  //     // Navigator.push(context,MaterialPageRoute(builder : (context) => About_us()));
                  //   },
                  // ),

                  // Theme switcher with Obx to react to changes
                  Obx(() => TSettingsMenuTile(
                    icon: Iconsax.sun,
                    title: 'Change Theme',
                    subTitle: 'Set theme on the basis of your preference.',
                    trailing: Switch(
                      value: themeController.isDarkMode.value,
                      onChanged: (value) {
                        themeController.toggleTheme();
                      },
                    ),
                  )),

                  ///Logout Button
                  const SizedBox(height: 250),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Using Get instead of Navigator for better navigation management
                          Get.offAll(() => const LoginScreen());
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 16))),
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}