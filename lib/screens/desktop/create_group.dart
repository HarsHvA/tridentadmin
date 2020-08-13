import 'package:TridentAdmin/modals/Match.dart';
import 'package:TridentAdmin/screens/desktop/edit_group_details.dart';
import 'package:TridentAdmin/screens/desktop/groups_details.dart';
import 'package:TridentAdmin/services/databse_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateGroup extends StatefulWidget {
  final int noOfGroups;
  final String matchId;
  CreateGroup({Key key, @required this.noOfGroups, @required this.matchId})
      : super(key: key);
  @override
  _CreateGroupState createState() => _CreateGroupState(noOfGroups, matchId);
}

class _CreateGroupState extends State<CreateGroup> {
  final int noOfGroups;
  final String matchId;
  _CreateGroupState(this.noOfGroups, this.matchId);

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double unitWidthValue = MediaQuery.of(context).size.width * 0.01;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Groups'),
      ),
      body: ListView.builder(
          itemCount: noOfGroups,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Group : $index'),
                    ),
                    ////
                    StreamBuilder<RoomDetailsModel>(
                        stream: DatabaseService()
                            .getRoomDetails(matchId, index.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Card(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(
                                                    unitWidthValue * 33),
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
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: SizedBox(
                                                        height:
                                                            unitHeightValue *
                                                                2.5,
                                                        child: Center(
                                                            child:
                                                                Text('Group')),
                                                      ),
                                                    ))),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .fill,
                                                    child: Center(
                                                        child: Text(
                                                            index.toString())))
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .middle,
                                                    child: Center(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: SizedBox(
                                                        height:
                                                            unitHeightValue *
                                                                2.5,
                                                        child: Center(
                                                            child:
                                                                Text('Time')),
                                                      ),
                                                    ))),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .fill,
                                                    child: Center(
                                                        child: Text(_gameTime(
                                                            snapshot.data.time
                                                                .toDate()))))
                                              ]),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('You have not created the group'));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),

                    ///
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          color: Colors.black,
                          colorBrightness: Brightness.light,
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => GroupDetailsPage(
                                        groupNo: index, matchId: matchId)));
                          },
                          child: Text('Create Group'),
                          textColor: Colors.white,
                        ),
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
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => EditGroupDetails(
                                        groupNo: index, matchId: matchId)));
                          },
                          child: Text('Edit Groups'),
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  _gameTime(time) {
    return DateFormat.yMMMd().add_jm().format(time);
  }
}
