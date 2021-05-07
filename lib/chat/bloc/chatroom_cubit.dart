import 'package:comalong/chat/model/chatroom_state.dart';
import 'package:comalong/firebase/firebase_chat_repository.dart';
import 'package:comalong/login/model/user_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  final UserInfo user;
  ChatRoomCubit({this.user}) : super(InitialState());

  void okButtonPushed() async {
    FirebaseChatRepository.uploadMessage(user.id, "ok");
  }

  void noButtonPushed() async {
    FirebaseChatRepository.uploadMessage(user.id, "no");
  }

  void waitButtonPushed() async {
    FirebaseChatRepository.uploadMessage(user.id, "wait");
  }
}
