import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/managers/color_manager.dart';
import '../../utils/constants/managers/values_manager.dart';
import '../../utils/validators/validation.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    this.title,
    this.labelText,
    this.hintText,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.validator,
  }) : super(key: key);
  final String? title;
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  // take parameter name validator which is a function that return string or null
  final String? Function(String?)? validator;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.title != null)
            Text(
              widget.title as String,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          const SizedBox(
            height: AppHeight.h4,
          ),
          Platform.isIOS
              ? CupertinoTextField(
                  controller: widget.controller,
                  obscureText: _obscurePassword,
                  placeholder: widget.labelText,
                  focusNode: widget.focusNode,
                  textInputAction: widget.nextFocusNode == null
                      ? TextInputAction.done
                      : TextInputAction.next,
                  keyboardType: TextInputType.text,
                  suffix: CupertinoButton(
                    child: Icon(_obscurePassword
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: ColorManager.primary,
                        width: 1,
                      ),
                      right: BorderSide(
                        color: ColorManager.primary,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: ColorManager.primary,
                        width: 1,
                      ),
                      left: BorderSide(
                        color: ColorManager.primary,
                        width: 1,
                      ),
                    ),
                  ),
                  onEditingComplete: () {
                    if (widget.nextFocusNode != null) {
                      FocusScope.of(context).requestFocus(widget.nextFocusNode);
                    }
                  },
                )
              : TextFormField(
                  controller: widget.controller,
                  obscureText: _obscurePassword,
                  focusNode: widget.focusNode,
                  style: const TextStyle().copyWith(color: ThemeColor.dark),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // TODO: uncomment this line to enable validation after development
                  // validator: (value) => widget.validator != null
                  //     ? widget.validator!(value)
                  //     : AppValidator.validatePassword(value),
                  textInputAction: widget.nextFocusNode == null
                      ? TextInputAction.done
                      : TextInputAction.next,
                  keyboardType: TextInputType.text,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration().copyWith(
                    labelText: widget.labelText,
                    hintText: widget.hintText,
                    suffix: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          !_obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        style: Theme.of(context)
                            .iconButtonTheme
                            .style!
                            .copyWith(
                                backgroundColor:
                                    const MaterialStatePropertyAll<Color>(
                                        ThemeColor.transparent)),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        }),
                  ),

                  onFieldSubmitted: (_) {
                    if (widget.nextFocusNode != null) {
                      FocusScope.of(context).requestFocus(widget.nextFocusNode);
                    }
                  },
                ),
        ],
      ),
    );
  }
}
