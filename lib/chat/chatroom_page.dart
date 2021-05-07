import 'package:comalong/chat/bloc/chatroom_cubit.dart';
import 'package:comalong/chat/chat_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ChatBox(
            user: context.read<ChatRoomCubit>().user,
          ),
          AnswerWidget()
        ],
      ),
    );
  }

  Widget getAppBar(BuildContext context) {
    return AppBar(
        elevation: 1.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          "Chat",
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 25.0,
            ),
            onPressed: () {
              Navigator.pop(context, null);
            },
          )
        ]);
  }
}

class AnswerWidget extends StatelessWidget {
  const AnswerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          AnswerButton(title: "Ok"),
          AnswerButton(title: "No"),
          AnswerButton(title: "Wait"),
        ],
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  final String title;
  const AnswerButton({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (title == "Ok") {
          context.read<ChatRoomCubit>().okButtonPushed();
        } else if (title == "No") {
          context.read<ChatRoomCubit>().noButtonPushed();
        } else if (title == "Wait") {
          context.read<ChatRoomCubit>().waitButtonPushed();
        }
      },
      child: Text(
        title,
      ),
    );
  }
}
