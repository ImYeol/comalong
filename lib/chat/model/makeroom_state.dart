import 'package:comalong/login/model/user_info.dart';

class MakeRoomState {}

class InitialState extends MakeRoomState {}

class UserFound extends MakeRoomState {
  final UserInfo user;

  UserFound({this.user});
}

class UserNotFound extends MakeRoomState {}
