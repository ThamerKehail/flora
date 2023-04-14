import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/theme.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final String hint;
  final Function validator;
  final TextInputType textType;
  final TextEditingController textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.hint,
    required this.textEditingController,
    required this.textType,
    required this.validator,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          inputFormatters: [],
          // inputFormatters: <TextInputFormatter>[
          //   FilteringTextInputFormatter.allow(RegExp('[0-9۰-۹]')),
          // ],
          controller: widget.textEditingController,
          textInputAction: TextInputAction.next,
          validator: (value) => widget.validator(value),
          keyboardType: widget.textType,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            hintText: widget.hint,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                width: 3,
                color: mainColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: mainColor,
                width: 2.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
