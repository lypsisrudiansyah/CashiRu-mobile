// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cashiru/core/assets/assets.gen.dart';
import 'package:cashiru/core/components/spaces.dart';
import 'package:cashiru/core/constants/colors.dart';


class ColumnButton extends StatelessWidget {
  final String label;
  final SvgGenImage svgGenImage;
  final VoidCallback onPressed;
  final bool isActive;

  const ColumnButton({
    super.key,
    required this.label,
    required this.svgGenImage,
    required this.onPressed,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: isActive
                    ? AppColors.primary
                    : AppColors.grey.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: svgGenImage.svg(),
          ),
          const SpaceHeight(8.0),
          Text(
            label,
            style: TextStyle(
              color: isActive
                  ? AppColors.primary
                  : AppColors.grey.withOpacity(0.5),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
