import 'package:bato_mechanic/src/features/user_account/account_recovery/presentation/recover_password_screen/recover_password_screen.dart';
import 'package:bato_mechanic/src/features/user_account/account_recovery/presentation/recovery_otp_confirmation_screen/recovery_otp_confirmation_screen.dart';
import 'package:bato_mechanic/src/features/user_account/account_recovery/presentation/user_id_confirmation_screen/user_id_confirmation_screen.dart';
import 'package:bato_mechanic/src/features/auth/presentation/setphone/set_user_phone.dart';
import 'package:bato_mechanic/src/features/profile/presentation/user/user_profile_screen.dart';
import 'package:bato_mechanic/src/features/profile/presentation/user/edit_profile/edit_profile_screen.dart';
import 'package:bato_mechanic/src/features/repair_progress/presentation/screens/repair_progress_screen.dart';
import 'package:bato_mechanic/src/features/repair_request/active_repairs/presentation/active_repairs_list_screen.dart';
import 'package:bato_mechanic/src/features/reviews_and_rating/presentation/screens/mechanic_reviews_list_screen/mechanic_reviews_list_screen.dart';
import 'package:bato_mechanic/src/features/user_account/account_verifcation/presentation/identifier_verfication_otp_confirmation_screen/identifier_verification_otp_confirmation_screen.dart';
import 'package:bato_mechanic/src/features/user_account/account_verifcation/presentation/account_verification_set_password_screen/account_verifcation_set_password_screen.dart';
import 'package:bato_mechanic/src/shared/utils/enums/otp_type.dart';
import 'package:bato_mechanic/src/features/auth/presentation/login/login_screen.dart';
import 'package:bato_mechanic/src/features/auth/presentation/signup/signup_screen.dart';
import 'package:bato_mechanic/src/features/feedback_and_contact/presentation/feedback_and_contact_screen.dart';
import 'package:bato_mechanic/src/features/home/presentation/screen/home_screen.dart';
import 'package:bato_mechanic/src/features/payment/presentation/screens/payment_integration_screen.dart';
import 'package:bato_mechanic/src/features/profile/presentation/mechanic/mechanic_profile_screen.dart';
import 'package:bato_mechanic/src/features/repair_request/recent_repairs/presentation/recent_repairs_list_screen.dart';
import 'package:bato_mechanic/src/features/repair_request/presentation/request_mechanic/request_mechanic_screen.dart';
import 'package:bato_mechanic/src/features/repair_request/presentation/vehicles/vehicles_screen.dart';
import 'package:bato_mechanic/src/features/reviews_and_rating/presentation/screens/review_mechanic_screen/review_mechanic_screen.dart';
import 'package:bato_mechanic/src/features/support_chat/presentation/support_chat_screen.dart';

import 'package:go_router/go_router.dart';

import '../features/user_account/account_verifcation/presentation/account_verfication_otp_confirmation_screen/account_verification_otp_confirmation_screen.dart';
import '../features/vehicle_category/presentation/vehicle_category_screen.dart';

// ignore: camel_case_types
enum APP_ROUTE {
  categories,
  vehicles,
  parts,
  requestMechanic,
  auth,
  feedback,
  history,
  payment,
  mechanicProfile,
  customerProfile,
  editProfile,
  reviewMechanic,
  splash,
  supportChat,
  repairProgress,
  recentRepairs,
  activeRepairs,
  buildHome,
  home,
  login,
  signup,
  mechanicReviewsList,
  // ------- Account Recovery and Verification starts here -----------
  confirmUserId,
  confirmRecoveryOTP,
  confirmAccountVerificationOTP,
  confirmIdentifierVerificationOTP,
  accountVerificationSetPassword,
  recoverPassword,
  setUserPhoneNumber
  // ------- Account Recovery and Verification ends here -----------
}

GoRouter goRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/login',
          name: APP_ROUTE.login.name,
          builder: (context, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'signup',
              name: APP_ROUTE.signup.name,
              builder: (context, state) => SignUpScreen(),
              routes: [
                GoRoute(
                    path: 'confirm-verification-otp',
                    name: APP_ROUTE.confirmAccountVerificationOTP.name,
                    builder: (context, state) {
                      final Map? extra = state.extra as Map?;
                      final OTPType? otpType = extra?["otpType"];
                      // final APP_ROUTE? route = extra?["route"];
                      return AccountVerificationOTPConfirmationScreen(
                        otpType: otpType ?? OTPType.EMAIL,
                        // route: route,
                      );
                    }),
                GoRoute(
                  path: 'verification-set-password',
                  name: APP_ROUTE.accountVerificationSetPassword.name,
                  builder: (context, state) =>
                      const AccountVerificationSetPasswordScreen(),
                ),
                GoRoute(
                    path: 'confirm-identifier-verification-otp',
                    name: APP_ROUTE.confirmIdentifierVerificationOTP.name,
                    builder: (context, state) {
                      final Map? extra = state.extra as Map?;
                      final OTPType? otpType = extra?["otpType"];
                      // final APP_ROUTE? route = extra?["route"];
                      return IdentifierVerificationOTPConfirmationScreen(
                        otpType: otpType ?? OTPType.EMAIL,
                        // route: route,
                      );
                    }),
              ],
            ),
          ]),
      GoRoute(
        path: '/',
        name: APP_ROUTE.home.name,
        builder: (context, state) => BuildHomeScreen(),
        // builder: (context, state) => AccountVerificationSetPasswordScreen(),
        routes: [
          GoRoute(
              path: 'confirm-uid',
              name: APP_ROUTE.confirmUserId.name,
              builder: (context, state) {
                final String? recoveryType =
                    (state.extra as Map?)?["recoveryType"];
                if (recoveryType != null) {
                  return UserIdConfirmationScreen(
                    recoveryType: recoveryType,
                  );
                }
                return const UserIdConfirmationScreen();
              },
              routes: [
                GoRoute(
                  path: 'confirm-recovery-otp',
                  name: APP_ROUTE.confirmRecoveryOTP.name,
                  builder: (context, state) => RecoveryOTPConfirmationScreen(
                    otpType: OTPType.EMAIL,
                  ),
                ),
                GoRoute(
                  path: 'recover-password',
                  name: APP_ROUTE.recoverPassword.name,
                  builder: (context, state) => const RecoverPasswordScreen(),
                ),
              ]),
          GoRoute(
            path: 'support-chat',
            name: APP_ROUTE.supportChat.name,
            builder: (context, state) => const SupportChatScreen(),
          ),
          GoRoute(
            path: 'recent_repairs',
            name: APP_ROUTE.recentRepairs.name,
            builder: (context, state) => const RecentRepairsListScreen(),
          ),
          GoRoute(
            path: 'active_repairs',
            name: APP_ROUTE.activeRepairs.name,
            builder: (context, state) => const ActiveRepairsListScreen(),
          ),
          GoRoute(
            path: 'repair_progress',
            name: APP_ROUTE.repairProgress.name,
            builder: (context, state) {
              final repairRequestIdx =
                  (state.extra as Map?)?["repairRequestIdx"];

              return RepairProgressScreen(
                  repairRequestIdx:
                      repairRequestIdx ?? "NqCYPG6oX2jrjsePXZg42Z");
            },
            routes: [
              GoRoute(
                path: 'payment',
                name: APP_ROUTE.payment.name,
                builder: (context, state) => const PaymentIntegrationScreen(),
              ),
              GoRoute(
                  path: 'review_mechanic',
                  name: APP_ROUTE.reviewMechanic.name,
                  builder: (context, state) {
                    final mechanicIdx = (state.extra as Map?)?["mechanicIdx"];
                    final repairRequestIdx =
                        (state.extra as Map?)?["repairRequestIdx"];
                    return ReviewMechanicScreen(
                      mechanicIdx: mechanicIdx,
                      repairRequestIdx: repairRequestIdx,
                    );
                  }),
            ],
          ),
          GoRoute(
            path: 'mechanic-profile',
            name: APP_ROUTE.mechanicProfile.name,
            builder: (context, state) {
              final mechanicIdx = (state.extra as Map)["mechanicIdx"];
              return MechanicProfileScreen(
                mechanicIdx: mechanicIdx ?? '4ebFHe3UfuBLr9WbEroijH',
              );
            },
          ),
          GoRoute(
            path: 'customer-profile',
            name: APP_ROUTE.customerProfile.name,
            builder: (context, state) => const UserProfileScreen(),
          ),
          GoRoute(
              path: 'edit-profile',
              name: APP_ROUTE.editProfile.name,
              builder: (context, state) {
                final user = (state.extra as Map)["user"];
                return EditProfileScreen(
                  user: user,
                );
              }),
          GoRoute(
            path: 'feedback',
            name: APP_ROUTE.feedback.name,
            builder: (context, state) => const FeedbackContactScreen(),
          ),
          GoRoute(
            path: 'categories',
            name: APP_ROUTE.categories.name,
            builder: (context, state) => const VehicleCategoryScreen(),
            routes: [
              GoRoute(
                path: 'vehicles',
                name: APP_ROUTE.vehicles.name,
                builder: (context, state) => const VehiclesScreen(),
                routes: [
                  GoRoute(
                    path: 'request',
                    name: APP_ROUTE.requestMechanic.name,
                    builder: (context, state) => const RequestMechanicScreen(),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
              path: 'mechanic-reviews',
              name: APP_ROUTE.mechanicReviewsList.name,
              builder: (context, state) {
                final mechanicIdx = (state.extra as Map)["mechanicIdx"];
                return MechanicReviewsListScreen(
                    mechanicIdx: mechanicIdx ?? '4ebFHe3UfuBLr9WbEroijH');
              }),
        ],
      ),
    ],
  );
}
