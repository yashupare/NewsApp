import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:inbrief/features/authentication/controllers/login/login_controller.dart';
import 'package:inbrief/utils/validators/validation.dart';

import '../../../navigation_menu.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../password_configuration/forget_password.dart';
import '../../signup/widgets/signup.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
      child: Form(
        key: controller.loginFormKey,
        child: Column(
          children: [
            /// Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => TValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                /// Forget Password
                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: Text(TTexts.forgetPassword)),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Sign In Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.emailAndPasswordSignIn(),
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(10)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 16))),
                    child: Text(TTexts.signIn))),
            const SizedBox(height: TSizes.spaceBtwItems),

            ///Create Account Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.to(() => const SignupScreen()),
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(10)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 16))),
                    child: Text(TTexts.createAccount))),
            const SizedBox(height: TSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
