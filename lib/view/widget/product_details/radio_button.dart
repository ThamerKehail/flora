import 'package:flutter/material.dart';
import 'package:ward/utils/language_constant.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({Key? key}) : super(key: key);

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
    bool _value = false;
    int val = 2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(translation(context).no),
          leading: Radio(
            value: 1,
            groupValue: val,
            onChanged: (int? value) {
              setState(() {
                val = value!;
                print(val);
              });
            },
            activeColor: Colors.green,
          ),
        ),
        ListTile(
          title: Text(translation(context).yes),
          leading: Radio(
            value: 2,
            groupValue: val,
            onChanged: (int? value) {
              setState(() {
                val = value!;
                print(val);
              });
            },
            activeColor: Colors.green,
          ),
        ),
        val == 2
            ? TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: translation(context).enterMessage,
                ),
              )
            : const SizedBox(
                height: 50,
              ),
      ],
    );
  }
}
