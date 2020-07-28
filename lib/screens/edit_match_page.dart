import 'package:TridentAdmin/screens/desktop/desktop_edit_match.dart';
import 'package:TridentAdmin/screens/mobile/mobile_edit_match.dart';
import 'package:TridentAdmin/services/databse_services.dart';
import 'package:flutter/material.dart';

class EditMatch extends StatefulWidget {
  final String matchId;
  EditMatch({Key key, @required this.matchId}) : super(key: key);
  @override
  _EditMatchState createState() => _EditMatchState(matchId);
}

class _EditMatchState extends State<EditMatch> {
  final String matchId;
  _EditMatchState(this.matchId);
  @override
  Widget build(BuildContext context) {
    double unitWidthValue = MediaQuery.of(context).size.width * 0.01;
    return FutureBuilder<bool>(
        future: DatabaseService().checkIfAdmin(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 700) {
                  return DesktopEditMatch(
                    matchId: matchId,
                  );
                } else {
                  return MobileEditMatch(matchId: matchId);
                }
              });
            } else {
              return Scaffold(
                body: Center(
                  child: Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You are not an admin!',
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Opps somthing is wrong',
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Loading...',
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
