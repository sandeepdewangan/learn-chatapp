import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;
  bool _saving = true;

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser();

      if(user != null){
        loggedUser = user;
        setState(() {
          _saving = false;
        });
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ModalProgressHUD(
        inAsyncCall: _saving,
          child: Text(loggedUser.email)
      ),
    );
  }
}

