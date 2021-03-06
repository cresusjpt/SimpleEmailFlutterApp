import 'package:email_flutter_app/Constants/Layout/BaseAlertDialog.dart';
import 'package:email_flutter_app/Constants/Layout/InputTextField.dart';
import 'package:email_flutter_app/Constants/Layout/PreLoader/ModelRoundedProgressBar.dart';
import 'package:email_flutter_app/Constants/Layout/PreLoader/ProgressBarHandler.dart';
import 'package:email_flutter_app/Constants/StaticContants.dart';
import 'package:email_flutter_app/Objects/Email/Email.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

class EmailOf extends StatefulWidget {
  @override
  _EmailOfState createState() => _EmailOfState();
}

class _EmailOfState extends State<EmailOf> {
  TextEditingController _reicpentController = new TextEditingController();
  TextEditingController _subjectController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  ProgressBarHandler _handler;

  Future _sendEmail(BuildContext tempContext) async {
    Email _email = new Email(
      subject: _subjectController.text,
      body: _emailController.text,
      recipentEmail: _reicpentController.text,
    );
    if (_email.checkIfEmpty()) {
      return showDialog(
        context: tempContext,
        child: new AlertDialog(
          title: new Text("Fields are Empty!"),
          content: new Text("Please Fille the fields and try again!"),
          backgroundColor: Color.fromARGB(220, 117, 218, 255),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              textColor: StaticContants.secondaryDarkerColor,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        ),
      );
    } else {
      _handler.show();
      _subjectController.text = "";
      _reicpentController.text = "";
      _emailController.text = "";
      bool _temp = null;
      _temp = (await _email.sendEmail());
      _handler.dismiss();
      if (_temp == true) {
        return showDialog(
          context: tempContext,
          child: new AlertDialog(
            title: new Text("SUCESS"),
            content: new Text("Email Sent Successfully!"),
            backgroundColor: Color.fromARGB(220, 117, 218, 255),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15)),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                textColor: StaticContants.secondaryDarkerColor,
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          ),
        );
      } else {
        return showDialog(
          context: tempContext,
          child: new AlertDialog(
            title: new Text("Faliure"),
            content: new Text("Email sent failed! \nPlease check your internet connection and Password."),
            backgroundColor: Color.fromARGB(220, 117, 218, 255),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15)),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                textColor: StaticContants.secondaryDarkerColor,
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          ),
        );
      }
      print(_temp.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    SingleChildScrollView _singleChildScrollView = new SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          top: _height / 30,
          left: _width / 40,
          right: _width / 40,
        ),
        child: new Column(
          children: <Widget>[
            new InputTextField(
              controller: _reicpentController,
              icon: Icon(Icons.person_add),
              labelText: "Recpient Email",
              obscure: false,
            ),
            new InputTextField(
              controller: _subjectController,
              icon: Icon(Icons.subject),
              labelText: "Subject",
              obscure: false,
            ),
            new SizedBox(
              height: _height / 2.5,
              child: new TextField(
                controller: _emailController,
                cursorColor: StaticContants.secondaryDarkerColor,
                keyboardType: TextInputType.multiline,
                //minLines:4,
                maxLines: (_height / 60).toInt(),
                decoration: new InputDecoration(
                    focusColor: StaticContants.secondaryDarkerColor,
                    hoverColor: StaticContants.secondaryLighterColor,
                    fillColor: StaticContants.secondaryDarkerColor,
                    prefixIcon: Icon(Icons.email),
                    labelText: "Your Email",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25),
                      borderSide: new BorderSide(
                        color: StaticContants.secondaryDarkerColor,
                      ),
                      gapPadding: 5,
                    )),
                textAlign: TextAlign.left,
              ),
            ),
            new Container(
              padding: EdgeInsets.only(top: _width / 30, bottom: _width / 30),
              child: new RaisedButton(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(left: _width / 25),
                      child: new Text(
                        "SEND",
                        style: new TextStyle(
                          color: StaticContants.backgroundColor,
                          fontSize: _height / 30,
                          letterSpacing: 1.5,
                          wordSpacing: 2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () {
                  _sendEmail(context);
                },
                color: StaticContants.mainColor,
                padding: EdgeInsets.only(
                  top: _height / 80,
                  bottom: _height / 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ModalRoundedProgressBar _progressBar = ModalRoundedProgressBar(
      //getting the handler
      handleCallback: (handler) {
        _handler = handler;
      },
    );
    return Stack(
      children: <Widget>[
        _singleChildScrollView,
        _progressBar,
      ],
    );
  }
}
