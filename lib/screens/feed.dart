import 'package:TridentAdmin/screens/create_match_page.dart';
import 'package:TridentAdmin/screens/manage_match_page.dart';
import 'package:TridentAdmin/screens/transactions_page.dart';
import 'package:TridentAdmin/services/AuthService.dart';
import 'package:TridentAdmin/services/databse_services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
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
                  return DesktopFeed();
                } else {
                  return MobileFeed();
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
                          Container(
                            child: MaterialButton(
                              onPressed: () {
                                AuthService().signOut();
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.exit_to_app,
                                  ),
                                  AutoSizeText(
                                    'Logout',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: unitWidthValue * 1.2),
                                  )
                                ],
                              ),
                            ),
                          )
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

class DesktopFeed extends StatefulWidget {
  @override
  _DesktopFeedState createState() => _DesktopFeedState();
}

class _DesktopFeedState extends State<DesktopFeed> {
  int _currentIndex = 0;
  final pages = [CreateMatchPage(), ManageMatches(), TransactionsPage()];
  @override
  Widget build(BuildContext context) {
    double unitWidthValue = MediaQuery.of(context).size.width * 0.01;
    return Scaffold(
      body: Container(
        color: Colors.black38,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Card(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.black54])),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.add_box,
                                color: Colors.white,
                              ),
                              AutoSizeText(
                                'Create \n Matches',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: unitWidthValue * 1.2),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            _currentIndex = 1;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.assessment,
                              color: Colors.white,
                            ),
                            AutoSizeText(
                              'Manage \n Matches',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: unitWidthValue * 1.2),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: MaterialButton(
                        focusColor: Colors.black38,
                        onPressed: () {
                          setState(() {
                            _currentIndex = 2;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                            ),
                            AutoSizeText(
                              'Transactions',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: unitWidthValue * 1.2),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: MaterialButton(
                        focusColor: Colors.black38,
                        onPressed: () {
                          AuthService().signOut();
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ),
                            AutoSizeText(
                              'Logout',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: unitWidthValue * 1.2),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width / 1.17,
                height: MediaQuery.of(context).size.height,
                child: pages[_currentIndex],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MobileFeed extends StatefulWidget {
  @override
  _MobileFeedState createState() => _MobileFeedState();
}

class _MobileFeedState extends State<MobileFeed> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dog Mode',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              child: Card(
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_circle_outline,
                      size: unitHeightValue * 10,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "CreateMatch",
                        style: TextStyle(
                            fontSize: unitHeightValue * 2, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/createMatch');
              },
            ),
            Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.account_balance_wallet,
                    size: unitHeightValue * 10,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Withdrawl request",
                      style: TextStyle(
                          fontSize: unitHeightValue * 2, color: Colors.white),
                    ),
                  ),
                ],
              ),
              color: Colors.black,
            ),
            GestureDetector(
              child: Card(
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.assessment,
                      size: unitHeightValue * 10,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Manage matches",
                        style: TextStyle(
                            fontSize: unitHeightValue * 2, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/manageMatches');
              },
            ),
          ],
        ),
      ),
    );
  }
}
