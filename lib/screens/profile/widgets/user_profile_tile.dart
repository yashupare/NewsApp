import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:inbrief/screens/profile/widgets/t_circular_image.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';




class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
    required this.userName,
    required this.userEmail,
  });
  final VoidCallback onPressed;
  final String userName;
  final String userEmail;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TCircularImage(
        image: TImages.user,
        width: 70,
        height: 70,
        padding: 0,
      ),
      title: Text(userName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: TColors.white)),
      subtitle: Text(userEmail,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: TColors.white)),
      // trailing: IconButton(onPressed:onPressed, icon: Icon(Iconsax.edit,color: TColors.white)),
    );
  }
}
