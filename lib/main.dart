import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

void main(){
  return runApp(
      MaterialApp(
        home: SafeArea(
          child: Scaffold(
            body: ChatterBox(),
          ),
        ),
      )
  );
}

class ChatterBox extends StatefulWidget {
  @override
  _ChatterBoxState createState() => _ChatterBoxState();
}

class _ChatterBoxState extends State<ChatterBox> {

  String email;
  String password;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            onChanged: (value){
              email = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter username',
            ),
          ),
          TextField(
            onChanged: (value){
              password = value;
            },
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter password',
            ),
          ),
          FlatButton(
            onPressed: () async {
              try{
                //final newUser = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
                final newUser = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
                if(newUser != null){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                }
              }catch(e){
                print(e);
              }
            },
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.pink,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
