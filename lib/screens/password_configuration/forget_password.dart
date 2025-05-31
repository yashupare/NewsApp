import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:inbrief/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:inbrief/screens/password_configuration/reset_password.dart';
import 'package:inbrief/utils/constants/text_strings.dart';
import 'package:inbrief/utils/validators/validation.dart';

import '../../utils/constants/sizes.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ForgetPasswordController());

    return Scaffold(
      appBar: AppBar(),
      body: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Heading
          Text(TTexts.forgetPasswordTitle,style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(TTexts.forgetPasswordSubTitle,style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: TSizes.spaceBtwSections * 2),

          ///Text Field
          Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail,
                decoration: const InputDecoration(labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct_right)),
              ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          ///Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () => controller.sendPasswordResetEmail(), child: const Text(TTexts.submit)),
          )
        ],
      ),


      ),
    );
  }
}
