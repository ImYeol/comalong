import 'package:comalong/chat/bloc/makeroom_cubit.dart';
import 'package:comalong/chat/makeroom_page.dart';
import 'package:comalong/chat/model/room.dart';
import 'package:comalong/chat/model/roomlist_state.dart';
import 'package:comalong/login/model/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomListCubit extends Cubit<RoomListState> {
  final UserInfo user;
  RoomListCubit({this.user}) : super(RoomListLoading());

  List<Room> roomList = [
    Room(name: "aaa"),
    Room(name: "bbb"),
    Room(name: "ccc")
  ];

  List<Room> get _roomList => roomList;

  void makeRoom(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => MakeRoomCubit(user: user),
                child: MakeRoomPage())));
  }

  void loadRoomList() async {
    Future.delayed(Duration(milliseconds: 500));
    emit(RoomListLoaded(roomList));
  }
}
