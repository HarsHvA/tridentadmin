import 'package:TridentAdmin/screens/desktop/desktop_disribute_reward.dart';
import 'package:TridentAdmin/screens/mobile/mobile_distribute_reward.dart';
import 'package:TridentAdmin/services/databse_services.dart';
import 'package:flutter/material.dart';

class DistributeRewardPage extends StatefulWidget {
  final String matchId, perKill;
  DistributeRewardPage(
      {Key key, @required this.matchId, @required this.perKill})
      : super(key: key);
  @override
  _DistributeRewardPageState createState() =>
      _DistributeRewardPageState(matchId, perKill);
}

class _DistributeRewardPageState extends State<DistributeRewardPage> {
  final String matchId, perKill;
  _DistributeRewardPageState(this.matchId, this.perKill);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: DatabaseService().checkIfAdmin(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 700) {
                  return DesktopDistributeReward(
                    matchId: matchId,
                    perKill: perKill,
                  );
                } else {
                  return MobileDistributeReward(
                    matchId: matchId,
                    perKill: perKill,
                  );
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
