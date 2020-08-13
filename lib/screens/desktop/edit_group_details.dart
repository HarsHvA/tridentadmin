import 'package:TridentAdmin/modals/Match.dart';
import 'package:TridentAdmin/services/databse_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class EditGroupDetails extends StatefulWidget {
  final int groupNo;
  final String matchId;
  EditGroupDetails({Key key, @required this.groupNo, @required this.matchId});
  @override
  _EditGroupDetailsState createState() =>
      _EditGroupDetailsState(groupNo, matchId);
}

class _EditGroupDetailsState extends State<EditGroupDetails> {
  final int groupNo;
  final String matchId;
  _EditGroupDetailsState(this.groupNo, this.matchId);
  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime _dateTime;
  final key = new GlobalKey<FormState>();
  String _roomId, _roomPassword = '';

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Group Details'),
        ),
        body: StreamBuilder<RoomDetailsModel>(
            stream:
                DatabaseService().getRoomDetails(matchId, groupNo.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Form(
                      key: key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Choose Date and Time (${format.pattern})'),
                              DateTimeField(
                                format: format,
                                onShowPicker: (context, currentValue) async {
                                  final date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100));
                                  if (date != null) {
                                    final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          currentValue ?? DateTime.now()),
                                    );
                                    return DateTimeField.combine(date, time);
                                  } else {
                                    return snapshot.data.time.toDate() ??
                                        currentValue;
                                  }
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
                                onSaved: (value) {
                                  _dateTime =
                                      value ?? snapshot.data.time.toDate();
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Room Id',
                                style: TextStyle(
                                    fontSize: unitHeightValue * 2,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                initialValue: snapshot.data.roomId,
                                onSaved: (value) {
                                  _roomId = value ?? '';
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
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Room password',
                                style: TextStyle(
                                    fontSize: unitHeightValue * 2,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                initialValue: snapshot.data.roomPassword,
                                onSaved: (value) {
                                  _roomPassword = value ?? '';
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                color: Colors.black,
                                colorBrightness: Brightness.light,
                                onPressed: () {
                                  key.currentState.save();
                                  _updateGroup(groupNo.toString(), matchId);
                                },
                                child: Text('Update Group'),
                                textColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error');
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  _updateGroup(id, matchId) async {
    CollectionReference groupCollection =
        Firestore.instance.collection('group');

    try {
      await groupCollection.document(matchId).updateData({
        id: {
          'roomId': _roomId ?? '',
          'roomPassword': _roomPassword ?? '',
          'id': id,
          'time': _dateTime
        }
      });
      Toast.show('Successful', context);
      Navigator.of(context).pop();
    } catch (e) {
      Toast.show(e.toString(), context);
    }
  }
}
