import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final int maxLines;
  final String label;
  final String text;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    required this.label,
    required this.text,
    required this.onChanged,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          TextFormField(
            autovalidateMode: AutovalidateMode.always,
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: maxLines,
            onChanged: onChanged,
          ),
        ],
      );
}
