import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Parent extends StatefulWidget {
  @override
  _ParentState createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  bool _isloading = false;

  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _id = TextEditingController();

  NameValidation() {
    if (RegExp('^[a-zA-Z]').hasMatch(_name.text)) {
      return false;
    } else {
      return true;
    }
  }

  EmailValidation() {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email.text)) {
      return false;
    } else {
      return true;
    }
  }

  NationalIdValidation() {
    if (RegExp(r'^-?[0-9]+$').hasMatch(_id.text) && _id.text.length == 14) {
      return false;
    } else {
      return true;
    }
  }

  Widget _textfield(String text, TextEditingController controller, Icon icon,
      bool obscureText, TextInputType, String conKey) {
    return SizedBox(
      width: 300,
      child: TextField(
        keyboardType: TextInputType,
        key: Key(conKey),
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: icon,
          labelText: text,
          labelStyle:
              TextStyle(fontSize: 20, color: Theme.of(context).accentColor),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).accentColor, width: 2),
              borderRadius: BorderRadius.circular(16)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).accentColor, width: 2),
              borderRadius: BorderRadius.circular(16)),
        ),
        style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor),
        controller: controller,
      ),
    );
  }

  Future<void> register(
      String name, String email, String password, String id) async {
    if (_name.text.length == 0 ||
        _email.text.length == 0 ||
        _password.text.length == 0 ||
        _id.text.length == 0) {
      AlertDialog alert = AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Make sure that you filled up all fields',
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 18)),
        content: Container(
          height: 80,
          child: Column(
            children: <Widget>[
              Divider(color: Colors.white),
              SizedBox(
                height: 7,
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Theme.of(context).accentColor,
                  child: Text('OK', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      );
      return showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    } else if (NameValidation()) {
      AlertDialog alert = AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Enter a valid name',
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 18)),
        content: Container(
          height: 80,
          child: Column(
            children: <Widget>[
              Divider(color: Colors.white),
              SizedBox(
                height: 7,
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Theme.of(context).accentColor,
                  child: Text('OK', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      );
      return showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    } else if (EmailValidation()) {
      AlertDialog alert = AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Enter a valid E-mail',
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 18)),
        content: Container(
          height: 80,
          child: Column(
            children: <Widget>[
              Divider(color: Colors.white),
              SizedBox(
                height: 7,
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Theme.of(context).accentColor,
                  child: Text('OK', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      );
      return showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    } else if (NationalIdValidation()) {
      AlertDialog alert = AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Enter a valid Id',
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 18)),
        content: Container(
          height: 80,
          child: Column(
            children: <Widget>[
              Divider(color: Colors.white),
              SizedBox(
                height: 7,
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Theme.of(context).accentColor,
                  child: Text('OK', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      );
      return showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    } else {
      setState(() {
        _isloading = true;
      });
      final String url =
          'https://vaccination-system-software.herokuapp.com/api/parent';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "name": name,
          "email": email,
          "password": password,
          "nationalid": id,
        }),
      );
      print(jsonDecode(response.body));
      setState(() {
        _isloading = false;
      });
      if (jsonDecode(response.body)['id'] != null) {
        AlertDialog alert = AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('You successfully registered',
              style: TextStyle(
                  color: Theme.of(context).accentColor, fontSize: 18)),
          content: Container(
            height: 80,
            child: Column(
              children: <Widget>[
                Divider(color: Colors.white),
                SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      setState(() {
                        _name.text = '';
                        _email.text = '';
                        _password.text = '';
                        _id.text = '';
                      });
                      Navigator.of(context).pop();
                    },
                    color: Theme.of(context).accentColor,
                    child: Text('OK', style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        );
        return showDialog(
            context: context,
            builder: (context) {
              return alert;
            });
      } else if (jsonDecode(response.body)['response'] == 'error') {
         AlertDialog alert = AlertDialog(
           backgroundColor: Theme.of(context).primaryColor,
           title: Text('${jsonDecode(response.body)['error_msg'] }',
               style: TextStyle(
                   color: Theme.of(context).accentColor, fontSize: 18)),
           content: Container(
             height: 80,
             child: Column(
               children: <Widget>[
                 Divider(color: Colors.white),
                 SizedBox(
                   height: 7,
                 ),
                 SizedBox(
                   width: double.infinity,
                   child: RaisedButton(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(30),
                     ),
                     onPressed: () {
                       Navigator.of(context).pop();
                     },
                     color: Theme.of(context).accentColor,
                     child: Text('OK', style: TextStyle(color: Colors.white)),
                   ),
                 )
               ],
             ),
           ),
         );
         return showDialog(
             context: context,
             builder: (context) {
               return alert;
             });
       }
      // else {
      //   AlertDialog alert = AlertDialog(
      //     backgroundColor: Theme.of(context).primaryColor,
      //     title: Text('This email is already exists',
      //         style: TextStyle(
      //             color: Theme.of(context).accentColor, fontSize: 18)),
      //     content: Container(
      //       height: 80,
      //       child: Column(
      //         children: <Widget>[
      //           Divider(color: Colors.white),
      //           SizedBox(
      //             height: 7,
      //           ),
      //           SizedBox(
      //             width: double.infinity,
      //             child: FlatButton(
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(30),
      //               ),
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               },
      //               color: Theme.of(context).accentColor,
      //               child: Text('OK', style: TextStyle(color: Colors.white)),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   );
      //   return showDialog(
      //       context: context,
      //       builder: (context) {
      //         return alert;
      //       });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Scaffold(
            backgroundColor: Theme.of(context).accentColor,
            body: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).accentColor,
              title: Text(
                'Parent registration',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 25),
              ),
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            body: Container(
              child: Center(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _textfield(
                        'Parent name',
                        _name,
                        Icon(
                          Icons.person,
                          size: 30,
                          color: Theme.of(context).accentColor,
                        ),
                        false,
                        TextInputType.name,
                        'pname'),
                    Padding(padding: EdgeInsets.all(6)),
                    _textfield(
                        'Email',
                        _email,
                        Icon(
                          Icons.email,
                          size: 30,
                          color: Theme.of(context).accentColor,
                        ),
                        false,
                        TextInputType.emailAddress,
                        'pemail'),
                    Padding(padding: EdgeInsets.all(6)),
                    _textfield(
                        'Password',
                        _password,
                        Icon(
                          Icons.security,
                          size: 30,
                          color: Theme.of(context).accentColor,
                        ),
                        true,
                        TextInputType.visiblePassword,
                        'password'),
                    Padding(padding: EdgeInsets.all(6)),
                    _textfield(
                        'National Id',
                        _id,
                        Icon(
                          Icons.credit_card,
                          size: 30,
                          color: Theme.of(context).accentColor,
                        ),
                        false,
                        TextInputType.number,
                        'pID'),
                    Padding(padding: EdgeInsets.all(6)),
                    SizedBox(
                      width: 300,
                      height: 65,
                      child: RaisedButton(
                        onPressed: () async {
                          await register(_name.text, _email.text,
                              _password.text, _id.text);
                        },
                        color: Theme.of(context).accentColor,
                        key: Key('pregbutton'),
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Theme.of(context).primaryColor),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
  }
}
