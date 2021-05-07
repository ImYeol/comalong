import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comalong/auth/AuthenticationEvent.dart';
import 'package:comalong/auth/AuthenticationState.dart';
import 'package:comalong/firebase/firebase_auth_repository.dart';
import 'package:comalong/login/model/user_info.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required FirebaseAuthRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );
  }

  final FirebaseAuthRepository _authenticationRepository;
  StreamSubscription<UserInfo> _userSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChanged) {
      yield _mapAuthenticationUserChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  AuthenticationState _mapAuthenticationUserChangedToState(
    AuthenticationUserChanged event,
  ) {
    return event.user != UserInfo.empty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated();
  }
}
