import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {

  TextEditingController _parentName = TextEditingController();
  bool _isloading = false;

  EmailValidation() {
    if (RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_parentName.text)) {
      return false;
    } else {
      return true;
    }
  }

  Widget _textfield(String text, TextEditingController controller, Icon icon) {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: icon,
          labelText: text,
          labelStyle: TextStyle(fontSize: 20, color: Theme.of(context).accentColor),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2),
              borderRadius: BorderRadius.circular(16)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2),
              borderRadius: BorderRadius.circular(16)),
        ),
        style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor),
        controller: controller,
      ),
    );
  }


  Future<void> register(String name) async {
    if(_parentName.text.length == 0){
      AlertDialog alert = AlertDialog(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text('Make sure that you filled up all fields',
            style: TextStyle(color: Theme.of(context).accentColor, fontSize: 18)),
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
                  color: Theme
                      .of(context)
                      .accentColor,
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
    }else if (EmailValidation()){
      AlertDialog alert = AlertDialog(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text('Enter a valid E-mail',
            style: TextStyle(color: Theme.of(context).accentColor, fontSize: 18)),
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
                  color: Theme
                      .of(context)
                      .accentColor,
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
    }else{

    setState(() {
      _isloading = true;
    });

    final String url =
        'https://vaccination-system-software.herokuapp.com/api/mail';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "parent": name,
      }),
    );
    print(jsonDecode(response.body));
    setState(() {
      _isloading = false;
    });
    if(jsonDecode(response.body)['response'] == 'this parent has no registered child!'){
      AlertDialog alert = AlertDialog(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text('This parent has no registered child!',
            style: TextStyle(color: Theme.of(context).accentColor, fontSize: 18)),
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
                  color: Theme
                      .of(context)
                      .accentColor,
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

    }else if(jsonDecode(response.body)['response'] == 'this parent name Does Not Exist!'){

      AlertDialog alert = AlertDialog(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text('This parent name does not exist!',
            style: TextStyle(color: Theme.of(context).accentColor, fontSize: 18)),
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
                  color: Theme
                      .of(context)
                      .accentColor,
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
    }else{
      AlertDialog alert = AlertDialog(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text('check your E-mail',
            style: TextStyle(color: Theme.of(context).accentColor, fontSize: 18)),
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
                  color: Theme
                      .of(context)
                      .accentColor,
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


  }
  }




  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Container(
            child: Center(

                  child: CircularProgressIndicator(),),),)
        :Scaffold(

      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text('Check',style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25),),
        iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _textfield('Parent Email', _parentName, Icon(Icons.person, size: 30, color: Theme.of(context).accentColor,)),
              Padding(padding: EdgeInsets.all(6)),
              SizedBox(
                width: 300,
                height: 65,
                child: RaisedButton(
                  onPressed:  () async{
                    await register(_parentName.text);
                  },
                  color:  Theme.of(context).accentColor,
                  child: Text(
                    'Check',
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
        ),
      ),
    );
  }
}
