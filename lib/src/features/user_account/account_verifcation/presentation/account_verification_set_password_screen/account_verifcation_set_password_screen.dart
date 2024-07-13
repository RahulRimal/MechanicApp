import 'package:bato_mechanic/src/features/user_account/account_recovery/presentation/recover_password_screen/recover_password_screen_controller.dart';
import 'package:bato_mechanic/src/features/user_account/account_verifcation/presentation/account_verification_set_password_screen/account_verification_set_password_screen_controller.dart';
import 'package:bato_mechanic/src/features/user_account/providers.dart';
import 'package:bato_mechanic/src/routing/app_router.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/async_value_extensions.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/string_extension.dart';
import 'package:bato_mechanic/src/shared/utils/helpers/toast_helper.dart';
import 'package:bato_mechanic/src/shared/widgets/butons/submit_button.dart';
import 'package:bato_mechanic/src/shared/widgets/form_fields/password_field.dart';
import 'package:bato_mechanic/src/shared/utils/constants/managers/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/utils/validators/validation.dart';

class AccountVerificationSetPasswordScreen extends ConsumerStatefulWidget {
  const AccountVerificationSetPasswordScreen({super.key});

  @override
  ConsumerState<AccountVerificationSetPasswordScreen> createState() =>
      _AccountVerificationSetPasswordScreenState();
}

class _AccountVerificationSetPasswordScreenState
    extends ConsumerState<AccountVerificationSetPasswordScreen> {
  late String oldPassword;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  _changePassword() async {
    if (_formKey.currentState!.validate()) {
      if (await ref
          .read(accountVerificationSetPasswordScreenControllerProvider.notifier)
          .changePassword(_newPasswordController.text)) {
        context.goNamed(APP_ROUTE.login.name);
        ToastHelper.showNotification(context,
            'Account has been verified successfully, please login to continue');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    String? oldPass = ref.read(userIdentifierProvider);
    if (oldPass != null) {
      oldPassword = oldPass;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(accountVerificationSetPasswordScreenControllerProvider,
        (previousState, state) {
      // if (state.hasValue && state.value != null) {
      // ToastHelper.showNotification(context, state.value!);
      // } else {
      state.showError(context);
      // }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter new password',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(
                height: AppHeight.h12,
              ),
              Text(
                'Please enter a secure and strong password',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: AppHeight.h50,
              ),
              const SizedBox(height: 16.0),
              PasswordField(
                controller: _newPasswordController,
                focusNode: _newPasswordFocusNode,
                labelText: 'New Password',
              ),
              const SizedBox(height: 16.0),
              PasswordField(
                controller: _confirmPasswordController,
                labelText: 'Confirm New Password',
                focusNode: _confirmPasswordFocusNode,
                validator: (value) => AppValidator.validateConfirmPassword(
                    value, _newPasswordController.text),
              ),
              const SizedBox(height: 32.0),
              SubmitButton(
                showSpinner: ref
                    .watch(recoverPasswordScreenControllerProvider)
                    .isLoading,
                label: 'Change Password'.hardcoded(),
                onPressed: _changePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
