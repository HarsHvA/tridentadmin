import 'package:flutter/material.dart';

class MobileTransaction extends StatefulWidget {
  @override
  _MobileTransactionState createState() => _MobileTransactionState();
}

class _MobileTransactionState extends State<MobileTransaction> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: (TabBar(tabs: [
            Tab(
              text: 'Pending',
            ),
            Tab(
              text: 'Completed',
            ),
          ])),
          body: TabBarView(children: [PendingTab(), CompletedTab()]),
        ));
  }
}

class PendingTab extends StatefulWidget {
  @override
  _PendingTabState createState() => _PendingTabState();
}

class _PendingTabState extends State<PendingTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CompletedTab extends StatefulWidget {
  @override
  _CompletedTabState createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
