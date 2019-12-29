

import 'package:firebase_auth_demo_flutter/other/data_app/globals.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:launch_review/launch_review.dart';

import 'package:firebase_auth_demo_flutter/other/data_app/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic _onAlertButtonsPressed (BuildContext context) async {
    Alert(
      context: context,
      type: AlertType.info,
      title: "$zodiacSign",
      desc: "Your zodiacSign is $zodiacSign",
      buttons: [
        DialogButton(gradient: LinearGradient(colors: [
        Color.fromRGBO(116, 116, 191, 1.0),
    Color.fromRGBO(52, 138, 199, 1.0)
    ]),
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
  String zodiacSign=" ";
  String dob=" ";
String day;
String month;
String year;
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
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: false,
        title: Text(
          'Zodiac Sign Finder',
          textScaleFactor: 1.2,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: bannerImg(context),
      ),
    );
  }

  Widget bannerImg(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            // height: 190.0,
            child: Image(
              image: AssetImage("assets/images/search.png"),
              // height: 200.0,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20.0, 320.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
//                    Image(
//                      image: AssetImage("assets/images/ic_launcher.png"),
//                      height: 30.0,
//                      width: 30.0,
//                    ),
//                    Text(
//                      " MY",
//                      style: TextStyle(
//                        fontWeight: FontWeight.bold,
//                        fontSize: 18.0,
//                      ),
//                    ),
//                    Text(
//                      " horoscope".toUpperCase(),
//                      style: TextStyle(
//                          fontWeight: FontWeight.normal,
//                          fontSize: 16.0,
//                          color: Colors.grey.shade600),
//                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  indent: 5.0,
                  endIndent:20.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 20.0, 0.0),
                  child: Text(
                    "Find your and your's lovely one's zodiac signs and see \nwhat is waiting in future.\n\nTo Check press down button below.",
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.deepOrange,
                    child: Text("Click Here",),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: ()
    {
                  DatePicker.showDatePicker (context,
                      showTitleActions: true,
                      minTime: DateTime(1950, 3, 5),
                      maxTime: DateTime(2019, 12, 31), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {


day=date.day.toString();
month=date.month.toString();
year=date.year.toString();
dob=day+' - '+month+' - '+year;
                     if(date.month==01 && date.day>=20 )setState(() {
                      zodiacSign="Aquarius";

                    });
                    else if(date.month==02 && date.day<=18)setState(() {
                      zodiacSign="Aquarius";
                    });
                    else if(date.month==02 && date.day>=19)setState(() {
                      zodiacSign="Pisces";
                    });
                    else if(date.month==03 && date.day<=20)setState(() {
                      zodiacSign="Pisces";
                    });
                    else if(date.month==03&& date.day>=21)setState(() {
                      zodiacSign="Aries";
                    });
                    else if(date.month==04 && date.day<=19)setState(() {
                      zodiacSign="Aries";
                    });
                    else if(date.month==04&& date.day>=20)setState(() {
                      zodiacSign="Taurus";
                    });
                    else if(date.month==05 && date.day<=20)setState(() {
                      zodiacSign="Taurus";
                    });
                    else if(date.month==05&& date.day>=21)setState(() {
                      zodiacSign="Gemini";
                    });
                    else if(date.month==06 && date.day<=20)setState(() {
                      zodiacSign="Gemini";
                    });
                    else if(date.month==06&& date.day>=21)setState(() {
                      zodiacSign="Cancer";
                    });
                    else if(date.month==07 && date.day<=22)setState(() {
                      zodiacSign="Cancer";
                    });
                    else if(date.month==07&& date.day>=23)setState(() {
                      zodiacSign="Leo";
                    });
                    else if(date.month==08 && date.day<=23)setState(() {
                      zodiacSign="Leo";
                    });
                    else if(date.month==08&& date.day>=24)setState(() {
                      zodiacSign="Virgo";
                    });
                    else if(date.month==09 && date.day<=22)setState(() {
                      zodiacSign="Virgo";
                    });
                    else if(date.month==09&& date.day>=23)setState(() {
                      zodiacSign="Libra";
                    });
                    else if(date.month==10 && date.day<=22)setState(() {
                      zodiacSign="Libra";
                    });

                    else if(date.month==10&& date.day>=23)setState(() {
                      zodiacSign="Scorpio";
                    });
                    else if(date.month==11&& date.day<=21)setState(() {
                      zodiacSign="Scorpio";
                    });
                    else if(date.month==11&& date.day>=22)setState(() {
                      zodiacSign="Sagittarius";
                    });
                    else if(date.month==12&& date.day<=21)setState(() {
                      zodiacSign="Sagittarius";
                    });
                    else if(date.month==12&& date.day>=22)setState(() {
                      zodiacSign="CapriCorn";
                    });
                    else if(date.month==01 && date.day<=19)setState(() {
                      zodiacSign="CapriCorn";
                    });

                        print('$zodiacSign $date');
_onAlertButtonsPressed(context);
Fluttertoast.showToast(
    msg:
    "Your zodiac sign is $zodiacSign",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    // also possible "TOP" and "CENTER"
    backgroundColor: Colors.blueGrey,
    textColor: Colors.white);

                      },
                     // currentTime: DateTime.now(),
                      locale: LocaleType.en);
                },

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.w500),
                      ),
                      SelectableText("",
                        //"$zodiacSign",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                                              child: RaisedButton(
                                color:  Color(0xffffffff),
                                child: Text('Home',
                                  style: TextStyle(
                                    color:  Color(0xff6200ee),
                                  ),),
                                onPressed: () { Navigator.pop(context);},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30.0),)
                            ),
                ),
//                Text(
//                  "App is up to date",
//                  style: TextStyle(
//                      fontWeight: FontWeight.normal,
//                      fontSize: 11.0,
//                      color: Colors.grey),
//                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
void _launchURLRateApp() async {
  const url = 'https://play.google.com/store/apps/details?id=com.myhoroscope&hl=en_IN';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
// Alert with multiple and custom buttons
