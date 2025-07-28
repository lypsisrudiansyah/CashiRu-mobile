import 'package:cashiru/core/components/spaces.dart';
import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';

class MenuButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onPressed;
  final bool isImage;
  final double size;

  const MenuButton({
    super.key,
    required this.iconPath,
    required this.label,
    this.isActive = false,
    required this.onPressed,
    this.isImage = false,
    this.size = 35,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      child: Container(
        width: context.deviceWidth,
        padding: const EdgeInsets.all(4.0),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          boxShadow: [
            BoxShadow(
              // offset: const Offset(0, 6),
              blurRadius: 20.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              // color: AppColors.primary.withOpacity(0.9),
              color: AppColors.primary.withValues(alpha: 0.35)
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpaceHeight(8.0),
            isImage
                ? Image.asset(
                    iconPath,
                    width: size,
                    height: size,
                    fit: BoxFit.contain,
                    color: isActive ? AppColors.white : AppColors.primary,
                  )
                : SvgPicture.asset(
                    iconPath,
                    width: size,
                    height: size,
                    colorFilter: ColorFilter.mode(
                      isActive ? AppColors.white : AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
            const SpaceHeight(8.0),
            // text size 20, isActive AppColors.white, not active AppColors.primary
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: isActive ? AppColors.white : AppColors.primary,
                ),
              ),
            ), 
          ],
        ),
      ),
    );
  }
}
