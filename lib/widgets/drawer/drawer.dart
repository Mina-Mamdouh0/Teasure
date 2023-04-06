
import 'package:finology/Widgets/costome_bottombar.dart';
import 'package:finology/Widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'menu_page.dart';

class OpenDrawer extends StatefulWidget {
  const OpenDrawer({Key? key}) : super(key: key);

  @override
  _OpenDrawerState createState() => _OpenDrawerState();
}

class _OpenDrawerState extends State<OpenDrawer> {
  final _drawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ZoomDrawer(
      controller: _drawerController,
      menuScreen: MenuScreen(index: currentIndex),
      mainScreen: CostomeBottomBar(),
      openCurve: Curves.fastOutSlowIn,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: 0,
      style: DrawerStyle.Style1,
      showShadow: true,
      mainScreenScale: .3,
      disableGesture: false,
      angle: 0.0,
      swipeOffset: 3.0,

      slideWidth: MediaQuery.of(context).size.width * (0.65),
      // overlayColor: Colors.black45,
      overlayBlend: BlendMode.screen,
      boxShadow: [
        BoxShadow(color: Colors.white10.withAlpha(50), blurRadius: 0)
      ],
    ));
  }
}

class ActivityDrawer extends StatefulWidget {
  const ActivityDrawer({Key? key}) : super(key: key);

  @override
  _ActivityDrawerState createState() => _ActivityDrawerState();
}

class _ActivityDrawerState extends State<ActivityDrawer> {
  final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ZoomDrawer(
      controller: _drawerController,
      menuScreen: const MenuScreen(),
      mainScreen: const MenuScreen(),
      openCurve: Curves.fastOutSlowIn,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: 0,
      style: DrawerStyle.Style1,
      showShadow: true,
      mainScreenScale: .3,
      disableGesture: false,
      angle: 0.0,
      swipeOffset: 3.0,
      slideWidth: MediaQuery.of(context).size.width * (0.65),
      // overlayColor: Colors.black45,
      overlayBlend: BlendMode.screen,
      boxShadow: [
        BoxShadow(color: Colors.white10.withAlpha(50), blurRadius: 0)
      ],
    ));
  }
}
