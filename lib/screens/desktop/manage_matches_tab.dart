import 'package:TridentAdmin/screens/mobile/mobile_manage_page.dart';
import 'package:flutter/material.dart';

class DesktopManageMatch extends StatefulWidget {
  @override
  _DesktopManageMatchState createState() => _DesktopManageMatchState();
}

class _DesktopManageMatchState extends State<DesktopManageMatch> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: (TabBar(tabs: [
            Tab(
              text: 'Upcoming',
            ),
            Tab(
              text: 'Live',
            ),
            Tab(
              text: 'Completed',
            ),
          ])),
          body: TabBarView(children: [
            UpcomingMatches(),
            LiveMatches(),
            CompletedMatches(),
          ]),
        ));
  }
}
