import 'package:TridentAdmin/home_page.dart';
import 'package:TridentAdmin/screens/create_match_page.dart';
import 'package:TridentAdmin/screens/edit_match_page.dart';
import 'package:TridentAdmin/screens/feed.dart';
import 'package:TridentAdmin/screens/manage_match_page.dart';
import 'package:TridentAdmin/screens/post_result_page.dart';
import 'package:TridentAdmin/services/AuthService.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthService().handler(),
        routes: {
          '/home': (context) => HomePage(),
          '/feed': (context) => Feed(),
          '/createMatch': (context) => CreateMatchPage(),
          '/manageMatches': (context) => ManageMatches(),
          '/postResult': (context) => PostResult(matchId: null),
          '/editMatch': (context) => EditMatch(matchId: null)
        });
  }
}
