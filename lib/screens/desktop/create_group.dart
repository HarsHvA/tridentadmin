import 'package:TridentAdmin/screens/desktop/edit_group_details.dart';
import 'package:TridentAdmin/screens/desktop/groups_details.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
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
                          color: Colors.black,
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
}
