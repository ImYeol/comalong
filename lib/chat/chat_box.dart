import 'package:comalong/chat/message_widget.dart';
import 'package:comalong/chat/model/message.dart';
import 'package:comalong/firebase/firebase_chat_repository.dart';
import 'package:comalong/login/model/user_info.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  final UserInfo user;
  ChatBox({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
        stream: FirebaseChatRepository.getMessages(user.id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshot.data;

                return messages.isEmpty
                    ? buildText('Say Hi..')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          return MessageWidget(
                            message: message,
                            isMe: message.from == user.id,
                          );
                        },
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
