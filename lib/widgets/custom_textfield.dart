import 'package:flutter/material.dart';
import '../theme/style_element.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.isNumberType,
      required this.text,
      required this.maxLength,
      required this.controller,
      required this.isTextInputActionGo,
      this.onSubmitted});

  final bool isNumberType;
  final String text;
  final int maxLength;
  final TextEditingController controller;
  final bool isTextInputActionGo;
  final void Function(String)? onSubmitted;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  AppColorItem appColorItem = AppColorItem();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: TextStyle(color: appColorItem.white),
        controller: widget.controller,
        keyboardType:
            widget.isNumberType ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: widget.text,
          counterText: "",
        ),
        maxLength:
            widget.maxLength > 0 ? widget.maxLength : TextField.noMaxLength,
        textInputAction: widget.isTextInputActionGo
            ? TextInputAction.go
            : TextInputAction.next,
        onFieldSubmitted: widget.onSubmitted);
  }
}
