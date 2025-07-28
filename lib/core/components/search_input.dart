import 'package:cashiru/core/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;
  final VoidCallback? onTap;

  const SearchInput({super.key, required this.controller, this.onChanged, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(width: 1.0, color: AppColors.blueLight.withValues(alpha: 0.02)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        onTap: onTap,
        readOnly: onTap != null,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),
          // suffixIcon: InkWell(
          //   onTap: () {
          //     // context.push(const ScannerPage());
          //   },
          //   child: const Icon(Icons.qr_code_2, color: AppColors.primary),
          // ),
          contentPadding: const EdgeInsets.all(16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.blueLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.blueLight),
          ),
        ),
      ),
    );
  }
}
