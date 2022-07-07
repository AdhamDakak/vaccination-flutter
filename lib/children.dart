import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Children extends StatefulWidget {
  @override
  _ChildrenState createState() => _ChildrenState();
}

class _ChildrenState extends State<Children> {
  bool _isloading = false;
  TextEditingController _parentChild = TextEditingController();
  TextEditingController _childName = TextEditingController();
  TextEditingController _datOfBirth = TextEditingController();
  TextEditingController _childId = TextEditingController();
  TextEditingController _parentPassword=TextEditingController();
  //validation functions
  NameValidation(){
    if(RegExp('^[a-zA-Z]').hasMatch(_childName.text)){
      return false;
    }else{
      return true;
    }

  }
  EmailValidation(){
    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_parentChild.text)){
      return false;
    }else{
      return true;
    }

  }
  NationalIdValidation(){
    if(RegExp(r'^-?[0-9]+$').hasMatch(_childId.text)&&_childId.text.length==14){
      return false;
    }else{
      return true;
    }
  }



  Widget _textfield(String text, TextEditingController controller, Icon icon,bool obscureText, TextInputType,String text2) {
    return SizedBox(
      width: 300,
      child: TextField(
        keyboardType: TextInputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText:text2 ,
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



  Future<void> register(String nameChild, String nameParent, String datOfBirth, String nationalId,String password) async {
    if (_parentChild.text.length==0 || _childName.text.length==0 ||
        _datOfBirth.text.length==0 || _childId.text.length==0 || _parentPassword.text.length==0 ) {
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
    }else if (NameValidation()){
      AlertDialog alert = AlertDialog(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text('Enter a valid name',
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
    } else if(NationalIdValidation()){
      AlertDialog alert = AlertDialog(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text('enter a valid id',
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

    } else {
      setState(() {
        _isloading = true;
      });
      final String url =
          'https://vaccination-system-software.herokuapp.com/api/child';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "name": nameChild,
          "date_of_birth": datOfBirth,
          "parent": nameParent,
          "nationalid": nationalId,
          "password":password,
        }),
      );
      print(jsonDecode(response.body));
      setState(() {
        _isloading = false;
      });
      if(jsonDecode(response.body)['id'] != null){
        setState(() {
          _childName.text = '';
          _parentChild.text = '';
          _datOfBirth.text = '';
          _childId.text = '';
          _parentPassword.text='';
        });
        AlertDialog alert = AlertDialog(
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          title: Text('You successfully registered',
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
      }else if (jsonDecode(response.body)['response'] == 'error') {
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
      // else{
      //   AlertDialog alert = AlertDialog(
      //     backgroundColor: Theme
      //         .of(context)
      //         .primaryColor,
      //     title: Text('Oops. Something went wrong.',
      //         style: TextStyle(color: Theme.of(context).accentColor, fontSize: 18)),
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
      //               color: Theme
      //                   .of(context)
      //                   .accentColor,
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
              child: CircularProgressIndicator(),),),)
        :Scaffold(

      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text('Children registration',style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25),),
        iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Center(
            child: SingleChildScrollView(
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _textfield('Child name', _childName, Icon(Icons.child_care, size: 30, color: Theme.of(context).accentColor, ),false, TextInputType.name,''),
                  Padding(padding: EdgeInsets.all(6)),
                  _textfield('Parent Email', _parentChild, Icon(Icons.person, size: 30, color: Theme.of(context).accentColor,),false, TextInputType.emailAddress,''),
                  Padding(padding: EdgeInsets.all(6)),
                  _textfield('Date of Birth', _datOfBirth, Icon(Icons.date_range, size: 30, color: Theme.of(context).accentColor,),false, TextInputType.number,'yyyy-mm-dd'),
                  Padding(padding: EdgeInsets.all(6)),
                  _textfield('Child National Id', _childId, Icon(Icons.credit_card, size: 30, color: Theme.of(context).accentColor,),false, TextInputType.number,''),
                  Padding(padding: EdgeInsets.all(6)),
                  _textfield('password', _parentPassword, Icon(Icons.shield_sharp, size: 30, color: Theme.of(context).accentColor, ),true, TextInputType.visiblePassword,''),
                  Padding(padding: EdgeInsets.all(6)),
                  SizedBox(
                    width: 300,
                    height: 65,
                    child: RaisedButton(
                      onPressed:  ()
                      async{
                        await register(_childName.text, _parentChild.text, _datOfBirth.text, _childId.text,_parentPassword.text);
                      },
                      color:  Theme.of(context).accentColor,
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
            )
        ),
      ),
    );
  }
}
