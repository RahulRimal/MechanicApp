import 'package:bato_mechanic/src/features/user_account/account_recovery/presentation/recovery_otp_confirmation_screen/recovery_otp_confirmation_screen_controller.dart';
import 'package:bato_mechanic/src/features/user_account/account_verifcation/presentation/account_verfication_otp_confirmation_screen/account_verification_otp_confirmation_screen_controller.dart';
import 'package:bato_mechanic/src/features/user_account/providers.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/async_value_extensions.dart';
import 'package:bato_mechanic/src/shared/utils/helpers/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:bato_mechanic/src/routing/app_router.dart';
import 'package:bato_mechanic/src/shared/utils/constants/managers/values_manager.dart';
import 'package:bato_mechanic/src/shared/utils/enums/otp_type.dart';
import 'package:bato_mechanic/src/shared/widgets/butons/submit_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../shared/utils/constants/managers/color_manager.dart';

class AccountVerificationOTPConfirmationScreen extends ConsumerWidget {
  AccountVerificationOTPConfirmationScreen({
    Key? key,
    required this.otpType,
  }) : super(key: key);

  final OTPType otpType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String otp = "";

  _getOTPTitle() {
    switch (otpType) {
      case OTPType.EMAIL:
        return "email";
      case OTPType.PHONE:
        return "mobile number";
      default:
        return "email or phone";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(accountVerificationOtpConfirmationScreenControllerProvider,
        (previous, next) => next.showError(context));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Enter the OTP sent to your ${_getOTPTitle()}',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 16.0),
              // OTPField(
              //   onSaved: (value) {
              //     if (value != null) {
              //       otp += value;
              //     }
              //   },
              // ),
              PinCodeTextField(
                length: 6,
                appContext: context,
                keyboardType: TextInputType.number,
                backgroundColor: ThemeColor.transparent,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: ColorManager.primaryShade10,
                  activeColor: ColorManager.primary,
                  selectedColor: ColorManager.primary,
                ),
                onSaved: (value) => otp = value ?? "",
              ),
              const SizedBox(height: 32.0),
              SubmitButton(
                  label: "Submit OTP",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                    ref.read(otpCodeProvider.notifier).setOtpCode(otp);
                    if (await ref
                        .read(
                            accountVerificationOtpConfirmationScreenControllerProvider
                                .notifier)
                        .checkOtp(otp, ref.read(verifyOtpIdxProvider) ?? "")) {
                      context.replaceNamed(
                          APP_ROUTE.accountVerificationSetPassword.name);
                    } else {
                      ToastHelper.showNotificationWithCloseButton(
                          context, "Invalid OTP Code");
                    }
                  }),
              TextButton(
                onPressed: () {},
                style: const ButtonStyle().copyWith(),
                child: Text(
                  'Resend OTP',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: ThemeColor.primary,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
