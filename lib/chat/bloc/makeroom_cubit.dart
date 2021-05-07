import 'package:comalong/chat/model/makeroom_state.dart';
import 'package:comalong/login/model/user_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeRoomCubit extends Cubit<MakeRoomState> {
  final UserInfo user;
  MakeRoomCubit({this.user}) : super(InitialState());
}
