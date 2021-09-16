import 'package:flutter/material.dart';
import 'package:nazarih/Views/chatroom/chatroomview_mobile.dart';
import 'package:nazarih/Views/chatroom/chatroomview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ChatRoomView extends StatelessWidget {
  final String id;
  const ChatRoomView({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ChatRoomViewMobile(chatRoomId: id),
      desktop: ChatRoomViewTabletDesktop(
        chatRoomId: id,
      ),
      tablet: ChatRoomViewTabletDesktop(
        chatRoomId: id,
      ),
    );
  }
}
