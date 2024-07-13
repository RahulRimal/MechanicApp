import 'package:bato_mechanic/src/features/auth/presentation/setphone/set_user_phone_controller.dart';
import 'package:bato_mechanic/src/routing/app_router.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/async_value_extensions.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/string_extension.dart';
import 'package:bato_mechanic/src/shared/widgets/form_fields/phone_number_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/utils/constants/managers/values_manager.dart';
import '../../../../shared/utils/validators/validation.dart';
import '../../../../shared/widgets/butons/submit_button.dart';

class SetUserPhone extends ConsumerWidget {
  SetUserPhone({super.key});

  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFoucsNode = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(setUserPhoneControllerProvider,
        (previous, state) => state.showError(context));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Please enter your phone number",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: AppHeight.h50,
            ),
            const SizedBox(height: 16.0),
            PhoneNumberField(
              controller: _phoneController,
              focusNode: _phoneFoucsNode,
              validator: (value) => AppValidator.validatePhoneNumber(value),
              hintText: "Enter your phone number".hardcoded(),
              labelText: "Phone number".hardcoded(),
            ),
            const SizedBox(height: 16.0),
            SubmitButton(
              showSpinner: ref.watch(setUserPhoneControllerProvider).isLoading,
              onPressed: () async {
                if (await ref
                    .read(setUserPhoneControllerProvider.notifier)
                    .setUserPhoneNumber({
                  "phone": _phoneController.text,
                })) {
                  context.goNamed(APP_ROUTE.home.name);
                }
              },
              label: "Verify phone",
            ),
          ],
        ),
      ),
    );
  }
}
