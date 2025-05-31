import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:inbrief/screens/signup/widgets/signup_form.dart';
import 'package:inbrief/utils/constants/sizes.dart';
import 'package:inbrief/utils/constants/text_strings.dart';

import '../../../utils/helpers/helper_functions.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Text(TTexts.signupTitle,style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwSections),


            /// Forms
            TSignupForm()
          ],
        )),
      ),
    );
  }
}
