import 'package:TridentAdmin/modals/participants.dart';
import 'package:TridentAdmin/services/databse_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

class MobileDistributeReward extends StatefulWidget {
  final String matchId, perKill;

  MobileDistributeReward(
      {Key key, @required this.matchId, @required this.perKill})
      : super(key: key);
  @override
  _MobileDistributeRewardState createState() =>
      _MobileDistributeRewardState(matchId, perKill);
}

class _MobileDistributeRewardState extends State<MobileDistributeReward> {
  String matchId, perKill;
  _MobileDistributeRewardState(this.matchId, this.perKill);

  final formKey = GlobalKey<FormState>();
  int _reward;
  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
      message: "Please wait...",
      borderRadius: 5.0,
      padding: EdgeInsets.all(25),
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red.shade900),
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w600),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Distribute Reward',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Participants>>(
            stream: DatabaseService().getParticipantList(matchId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
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
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 15,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('gameId : ' +
                                        snapshot.data[index].gameName),
                                    Text('name : ' + snapshot.data[index].name),
                                    Text('uid : ' + snapshot.data[index].uid)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            _showRewardDialog(snapshot.data[index].uid,
                                snapshot.data[index].gameName, perKill);
                          },
                        ),
                      );
                    });
              } else {
                return Center(
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
                );
              }
            }),
      ),
    );
  }

  _showRewardDialog(uid, gameId, perKill) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('uid : ' + uid),
                        Text('gameId : ' + gameId),
                        Text('perKill : ' + perKill),
                        Divider(
                          color: Colors.black,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 300,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Reward',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        onSaved: (newValue) {
                                          _reward = int.parse(newValue);
                                        },
                                        inputFormatters: [
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[400])),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[400])),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: RaisedButton(
                                    color: Colors.black,
                                    colorBrightness: Brightness.light,
                                    onPressed: () async {
                                      formKey.currentState.save();
                                      await _addRewardToUserWallet(uid);
                                    },
                                    child: Text('Add to wallet'),
                                    textColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _addRewardToUserWallet(uid) async {
    pr.show();
    try {
      int newReward = _reward;
      CollectionReference userCollection =
          Firestore.instance.collection('users');
      int reward = await userCollection.document(uid).get().then((value) {
        return value.data['walletAmount'] ?? 0;
      });
      newReward += reward;
      await Firestore.instance.runTransaction((transaction) async {
        return await transaction
            .update(userCollection.document(uid), {'walletAmount': newReward});
      });
      pr.hide();
      Navigator.pop(context);
      Toast.show('Reward added!', context);
    } catch (e) {
      pr.hide();
      Navigator.pop(context);
      Toast.show(e.toString(), context);
      print(e.toString());
    }
  }
}
