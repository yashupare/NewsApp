import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:inbrief/screens/signup/widgets/signup_controller.dart';
import 'package:inbrief/screens/signup/widgets/verify_email.dart';
import 'package:inbrief/utils/validators/validation.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final dark = THelperFunctions.isDarkMode(context);
    return Form(
      key: controller.signupFormKey,
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.firstName,
                validator: (value) => TValidator.validateEmptyText('First Name', value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user)),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                controller: controller.lastName,
                validator: (value) => TValidator.validateEmptyText('Last Name', value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user)),
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Username
        TextFormField(
          controller: controller.username,
          validator: (value) => TValidator.validateEmptyText('Username', value),
          expands: false,
          decoration: const InputDecoration(
              labelText: TTexts.username, prefixIcon: Icon(Iconsax.user_edit)),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Email
        TextFormField(
          controller: controller.email,
          validator: (value) => TValidator.validateEmail(value),
          expands: false,
          decoration: const InputDecoration(
              labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        ///Phone No
        TextFormField(
          controller: controller.phoneNumber,
          validator: (value) => TValidator.validatePhoneNumber(value),
          expands: false,
          decoration: const InputDecoration(
              labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        ///Password
        Obx(
        () => TextFormField(
          controller: controller.password,
          validator: (value) => TValidator.validatePassword(value),
          obscureText: controller.hidePassword.value,
          decoration: InputDecoration(
            labelText: TTexts.password,
            prefixIcon: Icon(Iconsax.password_check),
            suffixIcon: IconButton(
                onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
            ),
          ),
        ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        /// Signup Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(TTexts.createAccount)),
        )
      ],
    ));
  }
}
