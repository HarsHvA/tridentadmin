import 'package:TridentAdmin/screens/desktop/desktop_transaction.dart';
import 'package:flutter/material.dart';

class MobileTransaction extends StatefulWidget {
  @override
  _MobileTransactionState createState() => _MobileTransactionState();
}

class _MobileTransactionState extends State<MobileTransaction> {
  @override
  Widget build(BuildContext context) {
    return DesktopTransaction();
  }
}
