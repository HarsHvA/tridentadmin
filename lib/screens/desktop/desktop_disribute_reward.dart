import 'package:TridentAdmin/screens/mobile/mobile_distribute_reward.dart';
import 'package:flutter/material.dart';

class DesktopDistributeReward extends StatefulWidget {
  final String matchId, perKill;
  DesktopDistributeReward(
      {Key key, @required this.matchId, @required this.perKill})
      : super(key: key);
  @override
  _DesktopDistributeRewardState createState() =>
      _DesktopDistributeRewardState(matchId, perKill);
}

class _DesktopDistributeRewardState extends State<DesktopDistributeReward> {
  final String matchId, perKill;
  _DesktopDistributeRewardState(this.matchId, this.perKill);
  @override
  Widget build(BuildContext context) {
    return MobileDistributeReward(matchId: matchId, perKill: perKill);
  }
}
