import 'package:bato_mechanic/src/shared/providers/user_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/domain/user.dart';
part 'auth_state.g.dart';

class AuthState {
  AuthState({required this.isAuthenticated, this.user});

  final bool isAuthenticated;
  final User? user;

  AuthState copyWith({
    bool? isAuthenticated,
    User? user,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
    );
  }
}

@Riverpod(keepAlive: true)
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AuthState build() {
    return AuthState(isAuthenticated: false);
  }

  void setUser(User user) {
    state = state.copyWith(user: user);
  }

  void logIn(User user) {
    state = state.copyWith(isAuthenticated: true);
    state = state.copyWith(user: user);
  }

  void logOut() {
    ref.read(sharedPreferencesProvider).remove('access');
    ref.read(sharedPreferencesProvider).remove('refresh');

    state = state.copyWith(isAuthenticated: false);
    state = state.copyWith(user: null);
  }
}
