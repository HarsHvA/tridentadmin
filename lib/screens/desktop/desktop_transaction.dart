import 'package:TridentAdmin/modals/transaction.dart';
import 'package:TridentAdmin/screens/desktop/userTransactionPage.dart';
import 'package:TridentAdmin/services/databse_services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DesktopTransaction extends StatefulWidget {
  @override
  _DesktopTransactionState createState() => _DesktopTransactionState();
}

class _DesktopTransactionState extends State<DesktopTransaction> {
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
          body: TabBarView(children: [PendingTab(), CompletedTab()]),
        ),
      ),
    );
  }
}

class PendingTab extends StatefulWidget {
  @override
  _PendingTabState createState() => _PendingTabState();
}

class _PendingTabState extends State<PendingTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            child: StreamBuilder<List<TransactionsModel>>(
                stream: DatabaseService().adminPendingTransactions,
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
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserTransactionPage(
                                                              uid: snapshot
                                                                  .data[index]
                                                                  .uid)));
                                            },
                                            child: Text('get Info'),
                                            textColor: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: RaisedButton(
                                            color: Colors.green,
                                            colorBrightness: Brightness.light,
                                            onPressed: () async {
                                              CollectionReference
                                                  pendingTransactions =
                                                  Firestore.instance.collection(
                                                      'pendingTransaction');

                                              try {
                                                await pendingTransactions
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

  _showRewardDialog(uid) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog();
      },
    );
  }
}

class CompletedTab extends StatefulWidget {
  @override
  _CompletedTabState createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            child: StreamBuilder<List<TransactionsModel>>(
                stream: DatabaseService().adminPendingTransactions,
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
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserTransactionPage(
                                                              uid: snapshot
                                                                  .data[index]
                                                                  .uid)));
                                            },
                                            child: Text('get Info'),
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
