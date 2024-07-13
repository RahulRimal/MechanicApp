import 'package:bato_mechanic/src/features/auth/application/auth_state.dart';
import 'package:bato_mechanic/src/shared/data/fcm_repository.dart';
import 'package:bato_mechanic/src/shared/widgets/butons/facebook_button.dart';
import 'package:bato_mechanic/src/shared/widgets/butons/google_button.dart';
import 'package:bato_mechanic/src/shared/widgets/form_fields/divider_field.dart';
import 'package:bato_mechanic/src/shared/widgets/form_fields/id_field.dart';
import 'package:bato_mechanic/src/shared/utils/constants/managers/default_manager.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/async_value_extensions.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/string_extension.dart';
import 'package:bato_mechanic/src/features/auth/presentation/login/login_screen_controller.dart';
import 'package:bato_mechanic/src/features/auth/presentation/widgets/login_signup_label.dart';
import 'package:bato_mechanic/src/shared/widgets/butons/submit_button.dart';
import 'package:bato_mechanic/src/shared/widgets/form_fields/password_field.dart';
import 'package:bato_mechanic/src/shared/utils/constants/managers/values_manager.dart';
import 'package:bato_mechanic/src/routing/app_router.dart';
import 'package:bato_mechanic/src/shared/utils/helpers/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _idController =
      TextEditingController(text: "9808144809");

  final TextEditingController _passwordController =
      TextEditingController(text: "adminadmin");

  final _emailFocusNode = FocusNode();

  final _passwordFocusNode = FocusNode();

  _login(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      // pop the soft keyboard
      FocusScope.of(context).unfocus();
      final response = await ref
          .read(loginScreenControllerProvider.notifier)
          .signInWithIdAndPassword(
              _idController.text, _passwordController.text);
      if (response) {
        ref.read(fcmDeviceRepositoryProvider).registerNewDevice();
        context.replaceNamed(APP_ROUTE.home.name);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // No need to check isRefreshing and hasError here as this is checked in extension function
    ref.listen(loginScreenControllerProvider,
        (previous, state) => state.showError(context));

    final state = ref.watch(loginScreenControllerProvider);
    // return PopScope(
    //   canPop: true,
    //   onPopInvoked: (didPop) => ToastHelper.onWillPopToast(context),
    return WillPopScope(
      onWillPop: () => ToastHelper.onWillPopToast(context),
      child: SafeArea(
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
                        hintText:
                            "Enter your number or your valid email address"
                                .hardcoded(),
                        controller: _idController,
                        focusNode: _emailFocusNode,
                      ),
                      const SizedBox(
                        height: DefaultManager.defaultSpace,
                      ),
                      PasswordField(
                        title: "Password".hardcoded(),
                        labelText: "Password".hardcoded(),
                        hintText: "Enter your password".hardcoded(),
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                      ),
                      const SizedBox(
                        height: AppHeight.h30,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () =>
                              context.pushNamed(APP_ROUTE.confirmUserId.name),
                          child: Text("Forget Password?".hardcoded(),
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                      ),
                      const SizedBox(
                        height: AppHeight.h30,
                      ),
                      SubmitButton(
                        showSpinner: state.isLoading,
                        label: 'Login'.hardcoded(),
                        onPressed: () => _login(context, ref),
                      ),
                      DividerField(
                        text: 'Or'.hardcoded(),
                      ),
                      GoogleButton(
                          showSpinner: state.isLoading,
                          labelText: "Sign in with Google".hardcoded(),
                          onPressed: () async {
                            await ref
                                .read(loginScreenControllerProvider.notifier)
                                .googleSignIn();
                            if (ref
                                    .read(authStateNotifierProvider)
                                    .user!
                                    .phone ==
                                null) {
                              context
                                  .goNamed(APP_ROUTE.setUserPhoneNumber.name);
                            } else {
                              context.goNamed(APP_ROUTE.home.name);
                            }
                          }),
                      FacebookButton(
                          labelText: 'Log in with Facebook'.hardcoded(),
                          onPressed: () {}),
                      LoginSignUpLabel(
                        infoText: 'Don\'t have an account ?'.hardcoded(),
                        labelText: 'Register'.hardcoded(),
                        onPressed: () =>
                            context.pushNamed(APP_ROUTE.signup.name),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
