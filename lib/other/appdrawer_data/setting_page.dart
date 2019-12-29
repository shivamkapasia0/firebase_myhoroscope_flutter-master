import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth_demo_flutter/other/data_app/globals.dart';
import 'package:firebase_auth_demo_flutter/Utilities/my_theme_keys.dart';
import 'package:firebase_auth_demo_flutter/Utilities/shared_preference_handler.dart';
import 'package:firebase_auth_demo_flutter/Utilities/theme_handler.dart';
class SettingPage extends StatefulWidget {
  @override
  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
bool upd=true;
  ///Flutter Local Notification

  String notifyTime ="07 : 07 : 07";
  String nhour ="";
  String nminutes ="";
  String nseconds ="";
  String ntime="";
  String storedValue="";

  @override
  initState() {
    super.initState();

init();


  }






  ///end
  bool _lights = true ;
  bool _weeklyUpdates = true;
  bool _darkMode = true;
  SharedPreferences prefs;
///For Daily Notifications
  void init() async {
    prefs=await SharedPreferences.getInstance();
    _lights=prefs.getBool('_lights');
    _changeDailyNotifications(_lights);
  }

  void _changeDailyNotifications(bool _lights) async{
// save new value

   await prefs.setBool('_lights', _lights);

    setState(() {
     _lights ;
    });
    if(_lights==true){
      Fluttertoast.showToast(
          msg:
          "Daily Notifications On",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          // also possible "TOP" and "CENTER"
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white);
    }else{
      Fluttertoast.showToast(
          msg:
          "Daily Notifications Off",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          // also possible "TOP" and "CENTER"
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white);
    }
  }
///End of Daily Notifications.

  ///For Weekly Updates

  bool notify =true ;
  List<String> reportList = [
    "Western",
    "Indian",
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'Settings',
            textScaleFactor: 1.2,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          centerTitle: false,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: settingUI());
  }

  Widget settingUI() {

    return Container(
      color: Theme.of(context).primaryColor,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[




          Card(
            margin: EdgeInsets.all(10.0),
            elevation: 2.0,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 30.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                      image: AssetImage("assets/images/app.png"),
                      fit: BoxFit.scaleDown)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'App updates',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800),
                  ),
                  Switch(
                    value: upd,
                    onChanged: (bool value) {
                      setState(() {
                        upd = value; });
                        if (value==true) {
                          Fluttertoast.showToast(
                              msg:
                              "Apps update On",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              // also possible "TOP" and "CENTER"
                              backgroundColor: Colors.blueGrey,
                              textColor: Colors.white);
                          isDarkTheme = true;
                          isSwitched = true;
                          themeLabel = "Light Mode";
                          _changeTheme(context, MyThemeKeys.LIGHT);
                          SharedPreference.setStringValue(
                              SharedPreference.selectedTheme,
                              MyThemeKeys.LIGHT.toString());
                        } else {
                          Fluttertoast.showToast(
                              msg:
                              "Apps update off!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              // also possible "TOP" and "CENTER"
                              backgroundColor: Colors.blueGrey,
                              textColor: Colors.white);
                          isDarkTheme = true;
                          isSwitched = true;
                          themeLabel = "Dark Mode";
                          _changeTheme(context, MyThemeKeys.DARKER);
                          SharedPreference.setStringValue(
                              SharedPreference.selectedTheme,
                              MyThemeKeys.DARKER.toString());
                        }

                    },
                    inactiveTrackColor: Colors.grey.shade300,
                    inactiveThumbColor: Colors.grey,
                    activeTrackColor: Color.fromRGBO(209, 196, 233, 1),
                    activeColor: Colors.deepPurple,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(10.0),
            elevation: 2.0,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 30.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                      image: AssetImage("assets/images/bel.png"),
                      fit: BoxFit.scaleDown)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Notifications',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800),
                  ),
                  Switch(
                    value: _lights,
                    onChanged: (bool value) async {
                      setState(() {
                        _lights = value;
                        _changeDailyNotifications(_lights);});


                    },
                    inactiveTrackColor: Colors.grey.shade300,
                    inactiveThumbColor: Colors.grey,
                    activeTrackColor: Color.fromRGBO(209, 196, 233, 1),
                    activeColor: Colors.deepPurple,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                  ),
                ],
              ),
            ),
          ),

          Card(
            margin: EdgeInsets.all(10.0),
            elevation: 2.0,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "My Horoscope -v 3.0 ",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                         RaisedButton(
                           color:  Color(0xffffffff),
                                  child: Text('Rate App',
                                    style: TextStyle(
                                      color:  Color(0xff6200ee),
                                    ),),
                                  onPressed: () { _launchURLRateApp();},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30.0),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              color:  Color(0xffffffff),
                              child: Text('Share App',
                                style: TextStyle(
                                  color:  Color(0xff6200ee),
                                ),),
                              onPressed: () { Share.share('Download this amazing app now! \nhttps://play.google.com/store/apps/details?id=com.uptodown.myhoroscope&hl=en_IN');
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30.0),),
                            ),
                          ),
                        ],
                      )
                    // MultiSelectChip(reportList),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(backgroundColor: Theme.of(context).primaryColor,
//      appBar: AppBar(backgroundColor: Theme.of(context).primaryColor,
//        leading: IconButton(icon: Icon(FontAwesomeIcons.arrowLeft,
//          //backgroundColor: Theme.of(context).primaryColor,
//        ), onPressed: () => {
//          Navigator.pop(context),}),
//        title: Text('Setting'),
////Uncomment to add any widget in app bar
//
////        actions: <Widget>[
////          IconButton(icon: Icon(FontAwesomeIcons.coins), onPressed: () {
////
////          }),
////          IconButton(icon: Icon(FontAwesomeIcons.ellipsisV), onPressed: () {
////            //
////          }),
////        ],
//      ),
//      body: Theme( data: Theme.of(context).copyWith(
//        canvasColor: Theme.of(context).primaryColor, //This will change the drawer background to blue.
//        //other styles
//      ),
//        child: Center(
//          child: Container(
//            height: MediaQuery
//                .of(context)
//                .size
//                .height - 60.0,
//            child: ListView(
//              scrollDirection: Axis.horizontal,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Container(
//                    width: MediaQuery
//                        .of(context)
//                        .size
//                        .width - 20.0,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(12.0),
//                      color: Color(0xff5a348b),
//                      gradient: LinearGradient(
//                          // ignore: prefer_const_literals_to_create_immutables
//                          colors: [ Color(0xffebac38), Color(0xffde4d2a)],
//                          begin: Alignment.centerRight,
//                          end: Alignment(-1.0, -1.0)
//                      ), //Gradient
//                    ),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            //Text
//                            Padding(
//                              padding: const EdgeInsets.only(top: 0.0),
//                              child: Container(
//                                child: Text('Settings', style: TextStyle(
//                                  color: Colors.white,
//                                  fontSize: 54.0,
//                                  fontWeight: FontWeight.bold,
//                                ),),
//                              ),
//                            ),
//                            //subText
//                            Container(
//                              child: Text(
//                                'My Horoscope APP ',
//                                style: TextStyle(
//                                  color: Colors.white54,
//                                  fontSize: 20.0,
//                                ),),
//                            ),
//                            //Circle Avatar
//                            Padding(
//                              padding: const EdgeInsets.only(top: 8.0),
//                              child: Container(
//                                  width: 150.0,
//                                  height: 0.0,
//                                  decoration:  BoxDecoration(
//                                    shape: BoxShape.circle,
//                                    color: Colors.white,
//                                  ),
//                                  child: Column(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: <Widget>[
//                                      Container(
//                                        child: Text(
//                                          'Settings', style: TextStyle(
//                                          fontSize: 50.0,
//                                          color: Color(0xff8d70fe),
//                                          fontWeight: FontWeight.bold,
//                                        ),),
//                                      ),
//                                      Container(
//                                        child: Text('Signs', style: TextStyle(
//                                          fontSize: 20.0,
//                                          color: Color(0xff8d70fe),
//                                        ),),),
//                                    ],)
//                              ),
//                            ),
//
//                            //Two Column Table
//                            DataTable(
//                              columns: <DataColumn>[// ignore: prefer_const_literals_to_create_immutables
//                                DataColumn(
//                                  label: Text(''),
//                                ),
////                              DataColumn(
////                                label: Text(''),
////                              ),
//                              ],
//                              rows: <DataRow>[
//                                DataRow(
//                                    cells: <DataCell>[
//                                      DataCell(
//                                        SwitchListTile(
//                                          title: const Text('Daily Notifications            ', ),
//                                          value: _lights,
//                                          onChanged: (bool value)  async{
//                                          setState(() {
//                                            _lights=value;
//                                            _changeDailyNotifications(_lights);
//                                          });},
//                                          secondary: const Icon(Icons.notifications_active),
//                                        ),
//                                      ),
////                                    DataCell(  Text('', style: TextStyle(
////                                      color: Colors.white,
////                                    ),),
////
////                                    ),
//                                    ]
//                                ),
//                                DataRow(
//                                    cells: <DataCell>[
//                                      DataCell(
//                                        SwitchListTile(
//                                          title: const Text('Weekly Updates            ', ),
//                                          value: _lights,
//                                          onChanged: (bool value) { setState(() { _weeklyUpdates = value;
//
//
//                                          });
////                                          if(_weeklyUpdates==true){
////                                            Fluttertoast.showToast(
////                                                msg:
////                                                "Weekly updates On ",
////                                                toastLength: Toast.LENGTH_SHORT,
////                                                gravity: ToastGravity.BOTTOM,
////                                                // also possible "TOP" and "CENTER"
////                                                backgroundColor: Colors.blueGrey,
////                                                textColor: Colors.white);
////                                          }else{
////                                            Fluttertoast.showToast(
////                                                msg:
////                                                "Weekly updates Off",
////                                                toastLength: Toast.LENGTH_SHORT,
////                                                gravity: ToastGravity.BOTTOM,
////                                                // also possible "TOP" and "CENTER"
////                                                backgroundColor: Colors.blueGrey,
////                                                textColor: Colors.white);
////                                          }
//                                          },
//
//
//                                          secondary: const Icon(Icons.notifications),
//                                        ),
//                                      ),
//
//                                    ]
//                                ),
//                                DataRow(
//                                    cells: <DataCell>[
//                                      DataCell(
//                                        SwitchListTile(title: const Text('Auto Dark Theme'),
//                                          value: true,
//                                          onChanged: (value) {//Theme.of(context).primaryColor;
//                                            if(value==true){
//                                              Fluttertoast.showToast(
//                                                  msg:
//                                                  "Dynamic theme always On",
//                                                  toastLength: Toast.LENGTH_SHORT,
//                                                  gravity: ToastGravity.BOTTOM,
//                                                  // also possible "TOP" and "CENTER"
//                                                  backgroundColor: Colors.blueGrey,
//                                                  textColor: Colors.white);
//                                            }else
//                                              {
//                                                Fluttertoast.showToast(
//                                                    msg:
//                                                    "Dynamic theme always On",
//                                                    toastLength: Toast.LENGTH_SHORT,
//                                                    gravity: ToastGravity.BOTTOM,
//                                                    // also possible "TOP" and "CENTER"
//                                                    backgroundColor: Colors.blueGrey,
//                                                    textColor: Colors.white);
//                                              }
//                                          //_changeTheme(context, MyThemeKeys.DARKER);
//                                           ThemeData.fallback();
//
//                                          setState(() {
//                                            _darkMode = value;// ignore: unnecessary_statements
//
//                                          });
//                                          },
//                                          secondary: const Icon(FontAwesomeIcons.sun),
//                                          activeTrackColor: Colors.lightGreenAccent,
//                                          activeColor: Colors.green,
//                                        ),
//                                      ),
////                                    DataCell(  Text('', style: TextStyle(
////                                      color: Colors.white,
////                                    ),),
////
////                                    ),
//                                    ]
//                                ),
//
//                              ],
//                            ),
//
//                            //Button
////                            Padding(
////                              padding: const EdgeInsets.only(top: 60.0),
////                              child: RaisedButton(
////                                  color:  Color(0xffffffff),
////
////                                  child: Text('Notification time - $notifyTime',
////                                    style: TextStyle(
////                                      color:  Color(0xff6200ee),
////                                    ),),
////                                  onPressed: () {
////                                    DatePicker.showTimePicker(context, showTitleActions: true,
////                                        onChanged: (date) {
////                                          print('change $date');
////                                        }, onConfirm: (date) {
////                                          print('confirm $date');
////                                          scheuleAtParticularTime(
////                                              DateTime.fromMillisecondsSinceEpoch(
////                                                  date.millisecondsSinceEpoch));
////                                        }, currentTime: DateTime.now(), locale: LocaleType.en);
////                                  },
////                                  shape: RoundedRectangleBorder(
////                                    borderRadius: BorderRadius.circular(
////                                        30.0),)
////                              ),
////                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(top: 123.0),
//                              child: RaisedButton(
//                                  color:  Color(0xffffffff),
//                                  child: Text('Check for Updates',
//                                    style: TextStyle(
//                                      color:  Color(0xff6200ee),
//                                    ),),
//                                  onPressed: () { _launchURLRateApp();},
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(
//                                        30.0),)
//                              ),
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(top: 23.0),
//                              child: RaisedButton(
//                                  color:  Color(0xffffffff),
//                                  child: Text('Rate App',
//                                    style: TextStyle(
//                                      color:  Color(0xff6200ee),
//                                    ),),
//                                  onPressed: () { _launchURLRateApp();},
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(
//                                        30.0),)
//                              ),
//                            ),
//
//                          ],),
//                      ],),
//                  ),
//                ),
//                //Second ListView
//
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
}

ListTile myRowDataIcon(IconData iconVal, String rowVal) {
  return ListTile(
    leading: Icon(iconVal,
        color:  Color(0xffffffff)),
    title: Text(rowVal, style: TextStyle(
      color: Colors.white,
    ),),
  );
}

void _launchURLRateApp() async {
  const url = 'https://play.google.com/store/apps/details?id=com.myhoroscope&hl=en_IN';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
  CustomTheme.instanceOf(buildContext).changeTheme(key);
}