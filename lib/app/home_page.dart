import 'dart:async';

import 'package:firebase_auth_demo_flutter/common_widgets/avatar.dart';
import 'package:firebase_auth_demo_flutter/common_widgets/platform_alert_dialog.dart';
import 'package:firebase_auth_demo_flutter/common_widgets/platform_exception_alert_dialog.dart';
import 'package:firebase_auth_demo_flutter/constants/keys.dart';
import 'package:firebase_auth_demo_flutter/constants/strings.dart';
import 'package:firebase_auth_demo_flutter/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final AuthService auth = Provider.of<AuthService>(context);
      await auth.signOut();
    } on PlatformException catch (e) {
      await PlatformExceptionAlertDialog(
        title: Strings.logoutFailed,
        exception: e,
      ).show(context);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await PlatformAlertDialog(
      title: Strings.logout,
      content: Strings.logoutAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.logout,
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(body: _buildUserInfo(user),backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('My Profile'),
        actions: <Widget>[
          FlatButton(
            key: Key(Keys.logout),
            child: Text(
              Strings.logout,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
//        bottom: PreferredSize(
//          preferredSize: Size.fromHeight(230.0),
//          child: _buildUserInfo(user),
//        ),
      
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(108.0,8,8,8),
          child: Avatar(
            photoUrl: user.photoUrl,
            radius: 50,
          //  borderColor: Colors.black54,
            borderWidth: 2.0,
          ),
        ),
        SizedBox(height: 8),
//        if (user.displayName != null)
//          Text(
//           '                         Name : '+ user.displayName,
//            //style: TextStyle(color: Colors.white),
//          ),
        SizedBox(height: 18),
        if (user.displayName != null)
        Padding(
          padding: const EdgeInsets.fromLTRB(90.0,8,8,8),
          child: RaisedButton(
              color: Color(0xffffffff),
              child:  Text(user.displayName,
                style: TextStyle(
                  color:  Color(0xff6200ee),
                ),),
              onPressed: () {
                //MaterialPageRoute(builder: (context)=>WebViewContainer('https://en.wikipedia.org/wiki/Terms_of_service'));
                //  MaterialPageRoute(builder: (context) => WebViewContainer('https://i.pinimg.com/originals/9f/4b/e6/9f4be64ff60c5d9d017b2b2776dee6bc.jpg'));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    30.0),)
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(58.0,8,8,8),
          child: RaisedButton(
              color:  Color(0xffffffff),
              child:  Text('Email : '+user.email,
                style: TextStyle(
                  color:  Color(0xff6200ee),
                ),),
              onPressed: () {
                //MaterialPageRoute(builder: (context)=>WebViewContainer('https://en.wikipedia.org/wiki/Terms_of_service'));
                //  MaterialPageRoute(builder: (context) => WebViewContainer('https://i.pinimg.com/originals/9f/4b/e6/9f4be64ff60c5d9d017b2b2776dee6bc.jpg'));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    30.0),)
          ),
        ),

      ],
    );
  }
}
