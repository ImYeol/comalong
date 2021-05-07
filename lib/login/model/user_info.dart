import 'package:comalong/chat/model/room.dart';
import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  /// The current user's id as email type
  final String id;

  /// Url for the current user's photo.
  final String photo;

  final List<Room> rooms;

  const UserInfo({this.id, this.photo, this.rooms}) : assert(id != null);

  @override
  // TODO: implement props
  List<Object> get props => [id, photo];

  static const empty = UserInfo(id: '', photo: null, rooms: []);

  UserInfo copyWith({
    String id,
    String photo,
    List<Room> lastMessageTime,
  }) =>
      UserInfo(id: id ?? id, photo: photo ?? photo, rooms: rooms ?? rooms);

  static UserInfo fromJson(Map<String, dynamic> json) => UserInfo(
        id: json['uid'],
        photo: json['photo'],
        rooms: List<Room>.from(json['rooms'].map((x) => Room(name: x))),
      );

  Map<String, dynamic> toJson() => {
        'uid': id,
        'photo': photo,
        'rooms': List<dynamic>.from(rooms.map((x) => x.name)),
      };
}
