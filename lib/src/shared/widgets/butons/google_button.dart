import 'package:bato_mechanic/src/shared/utils/constants/managers/color_manager.dart';
import 'package:bato_mechanic/src/shared/utils/constants/managers/values_manager.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/double_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({
    Key? key,
    required this.onPressed,
    required this.labelText,
    this.showSpinner = true,
  }) : super(key: key);
  final Function() onPressed;
  final String labelText;
  final bool showSpinner;

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  @override
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () async {
              if (mounted) {
                setState(() {
                  isLoading = true;
                });
              }

              await widget.onPressed();
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            },
      style: const ButtonStyle().copyWith(
        padding:
            const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.all<Color>(ThemeColor.white),
      ),
      child: Container(
        decoration: const BoxDecoration().copyWith(
            borderRadius: BorderRadius.circular(AppRadius.r8),
            border: Border.all(
              width: 0.9.doubleHardcoded(),
              color: ThemeColor.black,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                'assets/icons/google_logo.svg',
                height: 35,
                width: 35,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.showSpinner && isLoading)
                    Padding(
                      padding: const EdgeInsets.only(right: AppPadding.p12),
                      child: SizedBox(
                        height: AppHeight.h20,
                        width: AppHeight.h20,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 3,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              ThemeColor.white),
                          backgroundColor: ColorManager.primary,
                        ),
                      ),
                    ),
                  Text(
                    widget.labelText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
