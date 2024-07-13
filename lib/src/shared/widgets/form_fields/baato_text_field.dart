import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_form_field.dart';

class BaatoTextField extends StatelessWidget {
  const BaatoTextField({
    Key? key,
    this.title,
    this.labelText,
    this.hintText,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.nextFocusNode,
    this.autovalidateMode,
    this.textStyle,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.editable = true,
  }) : super(key: key);

  final String? initialValue;
  final String? title;
  final String? labelText;
  final String? hintText;
  final TextStyle? textStyle;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final AutovalidateMode? autovalidateMode;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return BaseFormField(
      initialValue: initialValue,
      editable: editable,
      title: title,
      labelText: labelText,
      hintText: hintText,
      controller: controller,
      focusNode: focusNode,
      nextFocusNode: nextFocusNode,
      autovalidateMode: autovalidateMode,
      validator: validator ??
          (value) {
            return null;
          },
      textInputType: TextInputType.text,
      onSaved: onSaved,
      onChanged: onChanged,
      textStyle: textStyle,
    );
  }
}
