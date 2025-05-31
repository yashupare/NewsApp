import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:inbrief/common/styles/spacing_styles.dart';
import 'package:inbrief/screens/login/widgets/login_form.dart';
import 'package:inbrief/screens/login/widgets/login_header.dart';
import 'package:inbrief/utils/constants/colors.dart';
import 'package:inbrief/utils/constants/sizes.dart';
import 'package:inbrief/utils/helpers/helper_functions.dart';

import '../../utils/constants/image_strings.dart';
import '../../utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo, Title & Sub-Title
              TLoginHeader(),

              /// Form
              TLoginForm(),


            ],
          ),
        ),
      ),
    );
  }
}
