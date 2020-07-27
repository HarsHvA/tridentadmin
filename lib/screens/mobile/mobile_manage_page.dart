import 'package:TridentAdmin/modals/Match.dart';
import 'package:TridentAdmin/screens/post_result_page.dart';
import 'package:TridentAdmin/services/databse_services.dart';
import 'package:flutter/material.dart';

class MobileManageMatch extends StatefulWidget {
  @override
  _MobileManageMatchState createState() => _MobileManageMatchState();
}

class _MobileManageMatchState extends State<MobileManageMatch> {
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
          body: TabBarView(
              children: [UpcomingMatches(), LiveMatches(), CompletedMatches()]),
        ));
  }
}

class UpcomingMatches extends StatefulWidget {
  @override
  _UpcomingMatchesState createState() => _UpcomingMatchesState();
}

class _UpcomingMatchesState extends State<UpcomingMatches> {
  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
      body: StreamBuilder<List<Matches>>(
          stream: DatabaseService().upcomingMatches,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Game : ' + snapshot.data[index].game ??
                                          '',
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'id : ' + snapshot.data[index].id ?? '',
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'matchNo : ' +
                                              snapshot.data[index].matchNo ??
                                          '',
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'status : ' +
                                              snapshot.data[index].status ??
                                          '',
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 2.5,
                                          color: Colors.red.shade900),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('maxParticipants : ' +
                                            snapshot.data[index].maxParticipants
                                                .toString() ??
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'name : ' + snapshot.data[index].name ??
                                            ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('prizePool : ' +
                                            snapshot.data[index].prizePool ??
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('perKill : ' +
                                            snapshot.data[index].perKill
                                                .toString() ??
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('ticket : ' +
                                            snapshot.data[index].ticket
                                                .toString() ??
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('time : ' +
                                            snapshot.data[index].time
                                                .toDate()
                                                .toLocal()
                                                .toString() ??
                                        ''),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                      color: Colors.red,
                                      colorBrightness: Brightness.light,
                                      onPressed: () {},
                                      child: Text('Edit Match'),
                                      textColor: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                      color: Colors.green,
                                      colorBrightness: Brightness.light,
                                      onPressed: () {
                                        String id = snapshot.data[index].id;
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    PostResult(matchId: id)));
                                      },
                                      child: _buttonFunctionName(
                                          snapshot.data[index].resultOut),
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )));
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Somthing must have happened'),
              );
            } else {
              return Center(
                child: Text('Loading...'),
              );
            }
          }),
    );
  }

  _buttonFunctionName(result) {
    if (result) {
      return Text('Edit results');
    } else {
      return Text('Post Result');
    }
  }
}

class LiveMatches extends StatefulWidget {
  @override
  _LiveMatchesState createState() => _LiveMatchesState();
}

class _LiveMatchesState extends State<LiveMatches> {
  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
      body: StreamBuilder<List<Matches>>(
          stream: DatabaseService().ongoingMatches,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Game : ' + snapshot.data[index].game ??
                                          '',
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'id : ' + snapshot.data[index].id ?? '',
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'matchNo : ' +
                                              snapshot.data[index].matchNo ??
                                          '',
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'status : ' +
                                              snapshot.data[index].status ??
                                          '',
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 2.5,
                                          color: Colors.red.shade900),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('maxParticipants : ' +
                                            snapshot.data[index].maxParticipants
                                                .toString() ??
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'name : ' + snapshot.data[index].name ??
                                            ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('prizePool : ' +
                                            snapshot.data[index].prizePool ??
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('perKill : ' +
                                            snapshot.data[index].perKill
                                                .toString() ??
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('ticket : ' +
                                            snapshot.data[index].ticket
                                                .toString() ??
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('time : ' +
                                            snapshot.data[index].time
                                                .toDate()
                                                .toLocal()
                                                .toString() ??
                                        ''),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                      color: Colors.red,
                                      colorBrightness: Brightness.light,
                                      onPressed: () {},
                                      child: Text('Edit Match'),
                                      textColor: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                      color: Colors.green,
                                      colorBrightness: Brightness.light,
                                      onPressed: () {},
                                      child: _buttonFunctionName(
                                          snapshot.data[index].resultOut),
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )));
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Somthing must have happened'),
              );
            } else {
              return Center(
                child: Text('Loading...'),
              );
            }
          }),
    );
  }

  _buttonFunctionName(result) {
    if (result) {
      return Text('Edit results');
    } else {
      return Text('Post Result');
    }
  }
}

class CompletedMatches extends StatefulWidget {
  @override
  _CompletedMatchesState createState() => _CompletedMatchesState();
}

class _CompletedMatchesState extends State<CompletedMatches> {
  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
      body: StreamBuilder<List<Matches>>(
          stream: DatabaseService().completedMatches,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Game : ' + snapshot.data[index].game ??
                                          '',
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'id : ' + snapshot.data[index].id ?? '',
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'matchNo : ' +
                                              snapshot.data[index].matchNo ??
                                          '',
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'status : ' +
                                              snapshot.data[index].status ??
                                          '',
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 2.5,
                                          color: Colors.red.shade900),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('maxParticipants : ' +
                                            snapshot.data[index].maxParticipants
                                                .toString() ??
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'name : ' + snapshot.data[index].name ??
                                            ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('prizePool : ' +
                                            snapshot.data[index].prizePool ??
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('perKill : ' +
                                            snapshot.data[index].perKill
                                                .toString() ??
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('ticket : ' +
                                            snapshot.data[index].ticket
                                                .toString() ??
                                        ''),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('time : ' +
                                            snapshot.data[index].time
                                                .toDate()
                                                .toLocal()
                                                .toString() ??
                                        ''),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                      color: Colors.red,
                                      colorBrightness: Brightness.light,
                                      onPressed: () {},
                                      child: Text('Edit Match'),
                                      textColor: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                      color: Colors.green,
                                      colorBrightness: Brightness.light,
                                      onPressed: () {},
                                      child: _buttonFunctionName(
                                          snapshot.data[index].resultOut),
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )));
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Somthing must have happened'),
              );
            } else {
              return Center(
                child: Text('Loading...'),
              );
            }
          }),
    );
  }

  _buttonFunctionName(result) {
    if (result) {
      return Text('Edit results');
    } else {
      return Text('Post Result');
    }
  }
}
