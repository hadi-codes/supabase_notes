import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    Key? key,
    required this.title,
    this.hint,
    this.maxLines,
    this.textEditingController,
    this.onChange,
    this.helperText,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  final String title;
  final String? hint;
  final int? maxLines;
  final Function(String)? onChange;
  final TextEditingController? textEditingController;
  final String? helperText;
  final String? errorText;
  final TextInputType keyboardType;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                title,
              )),
          TextField(
            keyboardType: keyboardType,
            onChanged: onChange,
            obscureText: obscureText,
            controller: textEditingController,
            maxLines: maxLines ?? 1,
            style: const TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: hint,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0))),
          ),
        ],
      ),
    );
  }
}
