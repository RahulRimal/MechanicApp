import 'package:bato_mechanic/src/features/user_account/providers.dart';
import 'package:bato_mechanic/src/shared/utils/enums/otp_type.dart';
import 'package:bato_mechanic/src/shared/widgets/butons/submit_button.dart';
import 'package:bato_mechanic/src/shared/widgets/form_fields/baato_text_field.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/async_value_extensions.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/string_extension.dart';
import 'package:bato_mechanic/src/features/auth/presentation/signup/signup_screen_controller.dart';
import 'package:bato_mechanic/src/shared/utils/constants/managers/values_manager.dart';
import 'package:bato_mechanic/src/routing/app_router.dart';
import 'package:bato_mechanic/src/shared/utils/helpers/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/data/fcm_repository.dart';
import '../../../../shared/widgets/butons/facebook_button.dart';
import '../../../../shared/widgets/butons/google_button.dart';
import '../../../../shared/widgets/form_fields/divider_field.dart';
import '../../../../shared/widgets/form_fields/id_field.dart';
import '../../../../shared/utils/constants/managers/default_manager.dart';
import '../../application/auth_state.dart';
import '../login/login_screen_controller.dart';
import '../widgets/login_signup_label.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _idController =
      TextEditingController(text: "9887656748");
  final TextEditingController _nameController =
      TextEditingController(text: "Samual Jackson");

  final _emailFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();

  _signUp(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      // pop the soft keyboard
      FocusScope.of(context).unfocus();

      ref
          .read(userIdentifierProvider.notifier)
          .setUserIdentifier(_idController.text);

      final response = await ref
          .read(signUpScreenControllerProvider.notifier)
          .createUserWithoutPassword(_idController.text, _nameController.text);
      if (response) {
        ToastHelper.showNotification(
            context, 'Please verify the otp sent to you'.hardcoded());
        context.pushNamed(APP_ROUTE.confirmAccountVerificationOTP.name, extra: {
          "otpType": OTPType.PHONE,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(signUpScreenControllerProvider,
        (previous, state) => state.showError(context));
    final state = ref.watch(signUpScreenControllerProvider);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IdField(
                      title: 'Id'.hardcoded(),
                      labelText: "Phone/email".hardcoded(),
                      hintText: "Enter your number or your valid email address"
                          .hardcoded(),
                      controller: _idController,
                      focusNode: _emailFocusNode,
                    ),
                    const SizedBox(
                      height: DefaultManager.defaultSpace,
                    ),
                    // PasswordField(
                    //   title: "Password".hardcoded(),
                    //   labelText: "Password".hardcoded(),
                    //   hintText: "Enter your password".hardcoded(),
                    //   controller: _passwordController,
                    //   focusNode: _passwordFocusNode,
                    // ),
                    // const SizedBox(
                    // height: DefaultManager.defaultSpace,
                    // ),
                    BaatoTextField(
                      title: "Name".hardcoded(),
                      labelText: "Name".hardcoded(),
                      hintText: "Enter your full name".hardcoded(),
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                    ),
                    const SizedBox(
                      height: AppHeight.h30,
                    ),
                    SubmitButton(
                      showSpinner: state.isLoading,
                      label: 'Register'.hardcoded(),
                      onPressed: () => _signUp(context, ref),
                    ),
                    DividerField(
                      text: 'Or'.hardcoded(),
                    ),
                    GoogleButton(
                        labelText: "Sign in with Google".hardcoded(),
                        onPressed: () async {
                          await ref
                              .read(signUpScreenControllerProvider.notifier)
                              .googleSignIn();
                          if (ref.read(authStateNotifierProvider).user!.phone ==
                              null) {
                            context.goNamed(APP_ROUTE.setUserPhoneNumber.name);
                          } else {
                            context.goNamed(APP_ROUTE.home.name);
                          }
                        }),

                    FacebookButton(
                        labelText: 'Log in with Facebook'.hardcoded(),
                        onPressed: () {}),
                    LoginSignUpLabel(
                      infoText: 'Already have an account ?'.hardcoded(),
                      labelText: 'Login'.hardcoded(),
                      onPressed: () => context.goNamed(APP_ROUTE.login.name),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
