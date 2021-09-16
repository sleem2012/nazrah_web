import 'package:flutter/material.dart';
import 'package:nazarih/Views/chats/chatsview_mobile.dart';
import 'package:nazarih/Views/chats/chatsview_tablet_desktop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ChatsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ChatsViewMobile(),
      desktop: ChatsViewTabletDesktop(),
      tablet: ChatsViewTabletDesktop(),
    );
  }
}
