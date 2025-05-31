import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:inbrief/firststart/widgets/onboarding_dot_navigator.dart';
import 'package:inbrief/firststart/widgets/onboarding_next_button.dart';
import 'package:inbrief/firststart/widgets/onboarding_page.dart';
import 'package:inbrief/firststart/widgets/onboarding_skip.dart';
import 'package:inbrief/utils/constants/image_strings.dart';
import 'package:inbrief/utils/constants/sizes.dart';
import 'package:inbrief/utils/constants/text_strings.dart';
import 'package:inbrief/utils/helpers/helper_functions.dart';
import 'package:lottie/lottie.dart';

import 'widgets/onboarding_controller.dart';
import '../utils/constants/colors.dart';
import '../utils/device/device_utility.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          /// Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                animation: TImages.onBoardingAnimation1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                animation: TImages.onBoardingAnimation2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                animation: TImages.onBoardingAnimation3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              )
            ],
          ),

          /// Skip Button
          const OnBoardingSkip(),

          /// Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          /// Circular Button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}


