import "package:flutter/material.dart";
import "package:lottie/lottie.dart";

import "../../utils/constants/sizes.dart";
import "../../utils/helpers/helper_functions.dart";

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.animation, required this.title, required this.subTitle,
  });

  final String animation, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Lottie.asset(
            animation,
            width: THelperFunctions.screenWidth() * 0.8,
            height: THelperFunctions.screenHeight() * 0.6,
            fit: BoxFit.contain,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

