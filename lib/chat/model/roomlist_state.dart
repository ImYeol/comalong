import 'package:comalong/chat/model/room.dart';
import 'package:comalong/chat/roomlist_page.dart';

class RoomListState {}

class RoomListLoaded extends RoomListState {
  List<Room> roomList;

  List<Room> get _roomList => roomList;

  RoomListLoaded(List<Room> roomList);
}

class RoomListLoading extends RoomListState {}
