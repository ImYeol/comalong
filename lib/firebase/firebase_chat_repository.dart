import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comalong/chat/model/message.dart';
import 'package:comalong/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:comalong/login/model/user_info.dart';

class FirebaseChatRepository {
  // static Stream<List<User>> getUsers() => FirebaseFirestore.instance
  //     .collection('users')
  //     .orderBy(UserField.lastMessageTime, descending: true)
  //     .snapshots()
  //     .transform(Utils.transformer(User.fromJson));

  static Future uploadMessage(String uid, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$uid/messages');

    final newMessage = Message(
      from: uid,
      message: message,
      date: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    // final refUsers = FirebaseFirestore.instance.collection('users');
    // await refUsers
    //     .doc(idUser)
    //     .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String uid) =>
      FirebaseFirestore.instance
          .collection('chats/$uid/messages')
          .orderBy("date", descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Stream<UserInfo> getUser() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .transform(Utils.transformer((json) => UserInfo.fromJson(json)));

  static Future addUser(UserInfo user) async {
    final refUsers = FirebaseFirestore.instance.collection('users');
    final userDoc = refUsers.doc();
    await userDoc.set(user.toJson());
  }

  static Future addRandomUsers(List<UserInfo> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(idUser: userDoc.id);

        await userDoc.set(newUser.toJson());
      }
    }
  }
}
