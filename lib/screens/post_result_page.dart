import 'package:TridentAdmin/modals/Match.dart';
import 'package:TridentAdmin/modals/participants.dart';
import 'package:TridentAdmin/services/databse_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

class PostResult extends StatefulWidget {
  final String matchId;
  final int noOfGroups;
  PostResult({Key key, @required this.matchId, @required this.noOfGroups})
      : super(key: key);
  @override
  _PostResultState createState() => _PostResultState(matchId, noOfGroups);
}

class _PostResultState extends State<PostResult> {
  String matchId;
  int noOfGroups;
  int perKill;
  int userKills;
  int rewards;
  _PostResultState(this.matchId, this.noOfGroups);
  ProgressDialog pr;
  int groupNo = 0;
  final formKey = GlobalKey<FormState>();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double unitWidthValue = MediaQuery.of(context).size.width * 0.01;
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
            'Post Result',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                StreamBuilder<Matches>(
                    stream: DatabaseService().getMatchDetails(matchId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        perKill = snapshot.data.perKill;
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  children: [
                                    Table(
                                      defaultColumnWidth: FixedColumnWidth(
                                          MediaQuery.of(context).size.width /
                                              2),
                                      border: TableBorder.all(
                                          color: Colors.black26,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      children: [
                                        TableRow(children: [
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: SizedBox(
                                                  height: unitHeightValue * 2.5,
                                                  child: Center(
                                                      child: Text('Game')),
                                                ),
                                              ))),
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .fill,
                                              child: Center(
                                                  child:
                                                      Text(snapshot.data.game)))
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: SizedBox(
                                                  height: unitHeightValue * 2.5,
                                                  child: Center(
                                                      child: Text('Name')),
                                                ),
                                              ))),
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .fill,
                                              child: Center(
                                                  child:
                                                      Text(snapshot.data.name)))
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: SizedBox(
                                                  height: unitHeightValue * 2.5,
                                                  child: Center(
                                                      child: Text('Perkill')),
                                                ),
                                              ))),
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .fill,
                                              child: Center(
                                                  child: Text('\u20B9 ' +
                                                      snapshot.data.perKill
                                                          .toString())))
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: SizedBox(
                                                  height: unitHeightValue * 2.5,
                                                  child: Center(
                                                      child:
                                                          Text('NoOfGroups')),
                                                ),
                                              ))),
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .fill,
                                              child: Center(
                                                  child: Text(snapshot
                                                      .data.noOfGroups
                                                      .toString())))
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: SizedBox(
                                                  height: unitHeightValue * 2.5,
                                                  child: Center(
                                                      child: Text('matchNo')),
                                                ),
                                              ))),
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .fill,
                                              child: Center(
                                                  child: Text(
                                                      snapshot.data.matchNo)))
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: SizedBox(
                                                  height: unitHeightValue * 2.5,
                                                  child: Center(
                                                      child: Text('Status')),
                                                ),
                                              ))),
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .fill,
                                              child: Center(
                                                  child: Text(
                                                      snapshot.data.status)))
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: SizedBox(
                                                  height: unitHeightValue * 2.5,
                                                  child: Center(
                                                      child: Text('Ticket')),
                                                ),
                                              ))),
                                          TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .fill,
                                              child: Center(
                                                  child: Text(snapshot
                                                      .data.ticket
                                                      .toString())))
                                        ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error fetching data'),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Group no',
                                style: TextStyle(
                                    fontSize: unitHeightValue * 2,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                initialValue: groupNo.toString(),
                                onSaved: (value) {
                                  groupNo = int.parse(value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[400])),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[400])),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              color: Colors.red,
                              colorBrightness: Brightness.light,
                              onPressed: () {
                                formKey.currentState.save();
                                setState(() {});
                              },
                              child: Text('Change group'),
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   child: RaisedButton(
                //     color: Colors.black,
                //     colorBrightness: Brightness.light,
                //     onPressed: () async {
                //       CollectionReference matchsCollection =
                //           Firestore.instance.collection('customMatchRooms');
                //       pr.show();
                //       try {
                //         await matchsCollection
                //             .document(matchId)
                //             .setData({'result': true}, merge: true);
                //         pr.hide();
                //         Toast.show('Successful!', context);
                //         Navigator.of(context).pop();
                //       } catch (e) {
                //         pr.hide();
                //         Toast.show(e.toString(), context);
                //       }
                //     },
                //     child: Text('Post group result'),
                //     textColor: Colors.white,
                //   ),
                // ),
                Expanded(
                  child: SingleChildScrollView(
                    child: StreamBuilder<List<Participants>>(
                        stream: DatabaseService().getParticipantGroupList(
                            matchId, groupNo.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: FutureBuilder<bool>(
                                              future: DatabaseService()
                                                  .isUserResultOut(matchId,
                                                      snapshot.data[index].uid),
                                              builder: (context, snap) {
                                                if (snap.hasData) {
                                                  if (snap.data) {
                                                    return Container();
                                                  } else {
                                                    return GestureDetector(
                                                      child: Card(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'In-GameName : ' +
                                                                        snapshot
                                                                            .data[index]
                                                                            .gameName ??
                                                                    '',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        unitHeightValue *
                                                                            2),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'Name : ' +
                                                                        snapshot
                                                                            .data[index]
                                                                            .name ??
                                                                    '',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        unitHeightValue *
                                                                            2),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text('UserId : ' +
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .uid ??
                                                                  ''),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        _showDialog(
                                                            snapshot.data[index]
                                                                .uid,
                                                            snapshot.data[index]
                                                                .gameName,
                                                            perKill,
                                                            index);
                                                      },
                                                    );
                                                  }
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                    child: Text(
                                                        'Error fetching data'),
                                                  );
                                                } else {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                              }),
                                        );
                                      })),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  'Error fetching data or no participants'),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _showDialog(uid, gameId, perKill, index) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: key,
            child: Container(
              child: Wrap(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'In-GameName : ' + gameId,
                          style: TextStyle(fontSize: unitHeightValue * 2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'UID : ' + uid,
                          style: TextStyle(fontSize: unitHeightValue * 2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('perKill: \u20B9 ' + perKill.toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'No of kills by the user',
                              style: TextStyle(
                                  fontSize: unitHeightValue * 2,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              onSaved: (value) {
                                userKills = int.parse(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[400])),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[400])),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Reward',
                              style: TextStyle(
                                  fontSize: unitHeightValue * 2,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              onSaved: (value) {
                                rewards = int.parse(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[400])),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[400])),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            color: Colors.red,
                            colorBrightness: Brightness.light,
                            onPressed: () async {
                              key.currentState.save();
                              CollectionReference resultCollection =
                                  Firestore.instance.collection('results');
                              CollectionReference userCollection =
                                  Firestore.instance.collection('users');

                              CollectionReference resultsTokenCollection =
                                  Firestore.instance.collection('resultsToken');

                              pr.show();
                              try {
                                await resultCollection
                                    .document(matchId)
                                    .setData({
                                  groupNo.toString(): FieldValue.arrayUnion([
                                    {
                                      'uid': uid,
                                      'kills': userKills,
                                      'reward': rewards,
                                      'gameId': gameId,
                                    }
                                  ])
                                }, merge: true);

                                int newReward = rewards;
                                int balance = await userCollection
                                    .document(uid)
                                    .get()
                                    .then((value) {
                                  return value.data['walletAmount'] ?? 0;
                                });
                                newReward += balance;
                                await Firestore.instance
                                    .runTransaction((transaction) async {
                                  return await transaction.update(
                                      userCollection.document(uid),
                                      {'walletAmount': newReward});
                                });

                                await resultsTokenCollection
                                    .document(matchId)
                                    .setData({uid: true}, merge: true);

                                pr.hide();
                                Toast.show('Successful!', context);
                                Navigator.of(context).pop();
                                setState(() {});
                              } catch (e) {
                                pr.hide();
                                Toast.show(e.toString(), context);
                              }
                            },
                            child: Text('Post Result'),
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
