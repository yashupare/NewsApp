import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inbrief/features/authentication/controllers/forget_password/forget_password_controller.dart';

import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';
import '../login/login.dart';

class ResetPasswordScreen extends StatelessWidget {

  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.offAll(() => const LoginScreen()), icon: const Icon(CupertinoIcons.clear)),
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
          child:Column(
            children: [
              Image(
                  image: const AssetImage(TImages.deliveredEmailIllustration),
                  width: THelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Title and Subtitle
              Text(email, style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(TTexts.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(TTexts.changeYourPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.offAll(const LoginScreen()),
                      child: const Text(TTexts.done))),
              const SizedBox(height: TSizes.spaceBtwItems),

              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email),
                      child: const Text(TTexts.resendEmail))),


            ],
          )
        ),
      ),

    );
  }
}
