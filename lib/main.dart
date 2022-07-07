import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'check.dart';
import 'package:vaccination/children.dart';
import 'package:vaccination/parent.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: MyHomePage(),

      theme: ThemeData(
        primaryColor: Color(0XFFB0DCDF),
        accentColor: Color(0XFF25534A),
      ),

    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _isParentreg = false;
  bool _isChildreg = false;
  bool _isCheckreg = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text('Home Page',style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 65,
              child: FlatButton(
                onPressed:  (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Parent()));
                },
                color: Theme.of(context).accentColor,
                child: Text(
                  'Parent registration',
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
            Padding(padding: EdgeInsets.all(10)),
            SizedBox(
              width: 300,
              height: 65,
              child: FlatButton(
                onPressed:  (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Children()));

                },
                color:  Theme.of(context).accentColor,
                child: Text(
                  'Register your children',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Theme.of(context).primaryColor),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10))),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            SizedBox(
              width: 300,
              height: 65,
              child: FlatButton(
                onPressed:  (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Check()));

                },
                color:  Theme.of(context).accentColor,
                child: Text(
                  'Child-vaccine check',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
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
    );
  }
}
