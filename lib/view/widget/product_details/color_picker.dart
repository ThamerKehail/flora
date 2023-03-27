import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/const.dart';
import '../../pages/product_details_page/product_details_view_model.dart';

class ColorPicker extends StatefulWidget {
  final bool outBorder;
  final Color color;
  final int? index;
  final String? currentColor;

  const ColorPicker({
    Key? key,
    required this.color,
    required this.outBorder,
    this.index,
    this.currentColor,
  }) : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    final productDetails = context.watch<ProductDetailsViewModel>();
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: InkWell(
        onTap: () {
          productDetails.changeColor(
            index: widget.index ?? 0,
            color: widget.color,
            currentColors: widget.currentColor!,
          );
          bouColor = widget.color;
          print(widget.color);
        },
        child: Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: widget.index == currentColor
                ? Border.all(color: Colors.grey, width: 2)
                : null,
          ),
          child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.rectangle,
              )),
        ),
      ),
    );
  }
}
