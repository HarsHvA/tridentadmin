import 'package:TridentAdmin/modals/transaction.dart';
import 'package:TridentAdmin/services/databse_services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class UserTransactionPage extends StatefulWidget {
  final String uid;
  UserTransactionPage({Key key, @required this.uid}) : super(key: key);
  @override
  _UserTransactionPageState createState() => _UserTransactionPageState(uid);
}

class _UserTransactionPageState extends State<UserTransactionPage> {
  final String uid;
  _UserTransactionPageState(this.uid);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: (TabBar(
            tabs: [
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Completed',
              ),
            ],
            labelColor: Colors.red,
          )),
          body: TabBarView(children: [
            PendingTab(uid: uid),
            CompletedTab(
              uid: uid,
            )
          ]),
        ),
      ),
    );
  }
}

class PendingTab extends StatefulWidget {
  final String uid;
  PendingTab({Key key, @required this.uid}) : super(key: key);
  @override
  _PendingTabState createState() => _PendingTabState(uid);
}

class _PendingTabState extends State<PendingTab> {
  final String uid;
  _PendingTabState(this.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            child: StreamBuilder<List<TransactionsModel>>(
                stream: DatabaseService().getUserPendingTransaction(uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('uid : ' +
                                                snapshot.data[index].uid ??
                                            ''),
                                        Text('amount : ' +
                                                snapshot.data[index].amount
                                                    .toString() ??
                                            ''),
                                        Text('mode : ' +
                                                snapshot.data[index].mode ??
                                            ''),
                                        Text('status : ' +
                                                snapshot.data[index].status ??
                                            ''),
                                        Text('mobileNo : ' +
                                                snapshot.data[index].mobileNo
                                                    .toString() ??
                                            ''),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: RaisedButton(
                                            color: Colors.red,
                                            colorBrightness: Brightness.light,
                                            onPressed: () async {
                                              CollectionReference
                                                  transactionCollection =
                                                  Firestore.instance
                                                      .collection('users')
                                                      .document(uid)
                                                      .collection(
                                                          'transactions');

                                              try {
                                                transactionCollection
                                                    .document(snapshot
                                                        .data[index]
                                                        .transactionId)
                                                    .updateData({
                                                  'status': 'completed'
                                                });
                                                Toast.show('Updated', context);
                                                setState(() {});
                                              } catch (e) {
                                                Toast.show(
                                                    e.toString(), context);
                                              }
                                            },
                                            child: Text('Mark as completed'),
                                            textColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Container(
                      child: AutoSizeText('No pending transactions :-)'),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}

class CompletedTab extends StatefulWidget {
  final String uid;
  CompletedTab({Key key, @required this.uid}) : super(key: key);
  @override
  _CompletedTabState createState() => _CompletedTabState(uid);
}

class _CompletedTabState extends State<CompletedTab> {
  final String uid;
  _CompletedTabState(this.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            child: StreamBuilder<List<TransactionsModel>>(
                stream: DatabaseService().getUserCompletedTransaction(uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('uid : ' +
                                                snapshot.data[index].uid ??
                                            ''),
                                        Text('amount : ' +
                                                snapshot.data[index].amount
                                                    .toString() ??
                                            ''),
                                        Text('mode : ' +
                                                snapshot.data[index].mode ??
                                            ''),
                                        Text('status : ' +
                                                snapshot.data[index].status ??
                                            ''),
                                        Text('mobileNo : ' +
                                                snapshot.data[index].mobileNo
                                                    .toString() ??
                                            ''),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                // _showRewardDialog(uid);
                              },
                            ),
                          );
                        });
                  } else {
                    return Container(
                      child: AutoSizeText('No pending transactions :-)'),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
