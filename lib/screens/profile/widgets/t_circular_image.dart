import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';


class TCircularImage extends StatelessWidget {


  const TCircularImage({
    super.key,
    required this.width ,
    required this.height ,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = TSizes.sm,
    this.isNetworkImage = false,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width;
  final double height;
  final double padding;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(TSizes.sm),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),

      ),
      child: Center(
        child: Image(
          fit: fit,
          image: isNetworkImage ? NetworkImage(image): AssetImage(image) as ImageProvider,
          color: overlayColor,

        ),
      ),
    );
  }
}
