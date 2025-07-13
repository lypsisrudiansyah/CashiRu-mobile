import 'package:flutter/material.dart';
import 'spaces.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String label;
  final Function(T? value)? onChanged;

  const CustomDropdown({super.key, required this.value, required this.items, required this.label, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700))],
    );
  }
}
