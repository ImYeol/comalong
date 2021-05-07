import 'package:comalong/chat/bloc/roomlist_cubit.dart';
import 'package:comalong/chat/model/roomlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomListPage extends StatelessWidget {
  const RoomListPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RoomListPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(context),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          child: RoomListView(),
        ));
  }

  Widget getAppBar(BuildContext context) {
    return AppBar(
        elevation: 1.0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          "RoomList",
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: 25.0,
            ),
            onPressed: () {
              context.watch<RoomListCubit>().makeRoom(context);
            },
          )
        ]);
  }
}

class RoomListView extends StatelessWidget {
  const RoomListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomListCubit, RoomListState>(builder: (context, state) {
      if (state is RoomListLoaded) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.roomList.length,
            itemBuilder: (ctx, index) {
              return RoomListItem(
                roomName: state.roomList[index].name,
              );
            });
      } else if (state is RoomListLoading) {
        context.read<RoomListCubit>().loadRoomList();
        return CircularProgressIndicator();
      }
    });
  }
}

class RoomListItem extends StatelessWidget {
  final String roomName;
  const RoomListItem({Key key, this.roomName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(title: Text(roomName)),
    );
  }
}
