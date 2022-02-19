import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  Function? onEditingComplete;
  Function? onTap;
  ValueChanged<String>? onChanged;
  FocusNode? focusNode;
  Widget? suffixIcon;
  List<TextInputFormatter>? inputFormatter;
  String hintText;
  bool autoFocus, readOnly, obscureText, enable, error;
  TextCapitalization textCapitalization;
  TextInputType keyboardType;
  TextInputAction textInputAction;

  CustomTextField({
    this.onTap,
    this.onEditingComplete,
    this.controller,
    this.onChanged,
    this.hintText = '',
    this.autoFocus = false,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatter,
    this.obscureText = false,
    this.focusNode,
    this.enable = true,
    this.error = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 52,
      decoration: const BoxDecoration(color: Colors.white),
      child: TextFormField(
        cursorHeight: 20,
        cursorWidth: 1,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
          suffixIcon: suffixIcon,
          labelStyle: const TextStyle(color: Colors.black26),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black26),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: enable
                    ? (error ? Colors.red : theme.primaryColor)
                    : Colors.black.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelText: hintText,
        ),
        onEditingComplete: () => onEditingComplete!(),
        onChanged: onChanged,
        autofocus: autoFocus,
        readOnly: readOnly || !enable,
        textCapitalization: textCapitalization,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onTap: () => onTap!(),
        inputFormatters: inputFormatter,
        obscureText: obscureText,
      ),
    );
  }
}
