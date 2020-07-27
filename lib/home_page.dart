import 'package:TridentAdmin/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 700) {
        return DesktopBody();
      } else {
        return MobileLogin();
      }
    });
  }
}

class DesktopBody extends StatefulWidget {
  @override
  _DesktopBodyState createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  final formKey = GlobalKey<FormState>();
  String _email, _password, _error;
  bool _autoValidate = false;
  ProgressDialog pr;

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
        backgroundColor: Colors.blue[50],
        body: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          elevation: 5.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2.6,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.only(top: 70.0, right: 50.0, left: 50.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Text(
                            "Trident admin",
                            style: TextStyle(
                                fontSize: unitHeightValue * 5,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontFamily: 'Quickhand'),
                          ),
                        ),
                        SizedBox(
                          height: unitHeightValue * 1.5,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Text(
                            "Login! to get started",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: unitHeightValue * 2.5,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Quickhand'),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: Text(
                            "Only admins with special access can login through this portal.",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: unitHeightValue * 2.5,
                                fontFamily: 'Quickhand'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      showAlert(),
                      Container(
                        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: unitHeightValue * 5,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Quickhand'),
                        ),
                      ),
                      Form(
                        key: formKey,
                        autovalidate: _autoValidate,
                        child: Column(
                          children: [
                            makeInput(label: "Email", validator: validateEmail),
                            makeInput(
                                label: "Password",
                                obscureText: true,
                                validator: validatePassword),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            width: 350,
                            padding: EdgeInsets.only(top: 3, left: 3),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(unitWidthValue * 8),
                                border: Border(
                                  bottom: BorderSide(color: Colors.black),
                                  top: BorderSide(color: Colors.black),
                                  left: BorderSide(color: Colors.black),
                                  right: BorderSide(color: Colors.black),
                                )),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: unitHeightValue * 7,
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();
                                  submit();
                                } else {
                                  setState(() => _autoValidate = true);
                                }
                              },
                              color: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: unitHeightValue * 1.8),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ]),
          ),
        ));
  }

  Widget makeInput({label, obscureText = false, validator}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              validator: validator,
              obscureText: obscureText,
              onSaved: (newValue) {
                switch (label) {
                  case "Email":
                    _email = newValue;
                    break;

                  case "Password":
                    _password = newValue;
                    break;
                }
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  String validatePassword(String value) {
    if (value.length < 8) {
      return 'Invalid Password';
    } else {
      return null;
    }
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  void submit() async {
    pr.show();
    try {
      String uid = await AuthService().signIn(_email, _password);
      print(uid);
      pr.hide();
      Navigator.pop(context);
      Navigator.pushNamed(context, '/feed');
    } catch (e) {
      pr.hide();
      setState(() {
        _error = e.message;
      });
      print(e);
    }
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.red.shade900,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline, color: Colors.white),
            ),
            Expanded(
              child: Text(
                _error,
                maxLines: 3,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}

class MobileLogin extends StatefulWidget {
  @override
  _MobileLoginState createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  final formKey = GlobalKey<FormState>();
  String _email, _password, _error;
  bool _autoValidate = false;
  ProgressDialog pr;

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
        backgroundColor: Colors.blue[50],
        body: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0)),
            elevation: 5.0,
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1.5,
                child: Column(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.6,
                    color: Colors.black,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 70.0, right: 50.0, left: 50.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: Text(
                                "Trident admin",
                                style: TextStyle(
                                    fontSize: unitHeightValue * 3,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontFamily: 'Quickhand'),
                              ),
                            ),
                            SizedBox(
                              height: unitHeightValue * 0.5,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: Text(
                                "Login! to get started",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: unitHeightValue * 1.5,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Quickhand'),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: Text(
                                "Only admins with special access can login through this portal.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: unitHeightValue * 1.5,
                                    fontFamily: 'Quickhand'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          showAlert(),
                          Container(
                            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: unitHeightValue * 5,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Quickhand'),
                            ),
                          ),
                          Form(
                            key: formKey,
                            autovalidate: _autoValidate,
                            child: Column(
                              children: [
                                makeInput(
                                    label: "Email", validator: validateEmail),
                                makeInput(
                                    label: "Password",
                                    obscureText: true,
                                    validator: validatePassword),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                width: 350,
                                padding: EdgeInsets.only(top: 3, left: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        unitWidthValue * 8),
                                    border: Border(
                                      bottom: BorderSide(color: Colors.black),
                                      top: BorderSide(color: Colors.black),
                                      left: BorderSide(color: Colors.black),
                                      right: BorderSide(color: Colors.black),
                                    )),
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: unitHeightValue * 7,
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();
                                      submit();
                                    } else {
                                      setState(() => _autoValidate = true);
                                    }
                                  },
                                  color: Colors.black,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: unitHeightValue * 1.8),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ));
  }

  Widget makeInput({label, obscureText = false, validator}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              validator: validator,
              obscureText: obscureText,
              onSaved: (newValue) {
                switch (label) {
                  case "Email":
                    _email = newValue;
                    break;

                  case "Password":
                    _password = newValue;
                    break;
                }
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  String validatePassword(String value) {
    if (value.length < 8) {
      return 'Invalid Password';
    } else {
      return null;
    }
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  void submit() async {
    pr.show();
    try {
      String uid = await AuthService().signIn(_email, _password);
      print(uid);
      pr.hide();
      Navigator.pop(context);
      Navigator.pushNamed(context, '/feed');
    } catch (e) {
      setState(() {
        _error = e.message;
      });
      pr.hide();
      print(e);
    }
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.red.shade900,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline, color: Colors.white),
            ),
            Expanded(
              child: Text(
                _error,
                maxLines: 3,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}
