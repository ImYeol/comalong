import 'package:comalong/auth/AuthenticationBloc.dart';
import 'package:comalong/auth/AuthenticationState.dart';
import 'package:comalong/chat/roomlist_page.dart';
import 'package:comalong/firebase/firebase_auth_repository.dart';
import 'package:comalong/firebase/firebase_chat_repository.dart';
import 'package:comalong/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// https://github.com/JohannesMilke/firebase_chat_example/
// https://www.youtube.com/watch?v=kcLt5IHOFRI
void main() {
  runApp(MyApp(
      firebaseAuthRepository: FirebaseAuthRepository(),
      firebaseChatRepository: FirebaseChatRepository()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final FirebaseAuthRepository firebaseAuthRepository;
  final FirebaseChatRepository firebaseChatRepository;

  const MyApp({this.firebaseAuthRepository, this.firebaseChatRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: firebaseAuthRepository),
        RepositoryProvider.value(value: firebaseChatRepository)
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: firebaseAuthRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  RoomListPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      //onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
