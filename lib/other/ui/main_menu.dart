import 'dart:async';
import 'package:firebase_auth_demo_flutter/RateApp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_demo_flutter/common_widgets/platform_exception_alert_dialog.dart';
import 'package:firebase_auth_demo_flutter/constants/strings.dart';
import 'package:firebase_auth_demo_flutter/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:firebase_auth_demo_flutter/other/appdrawer_data/about_app.dart';
import 'package:firebase_auth_demo_flutter/other/appdrawer_data/setting_page.dart';
import 'package:firebase_auth_demo_flutter/other/data_app/details.dart';
import 'package:firebase_auth_demo_flutter/other/data_app/signs.dart';
import 'package:firebase_auth_demo_flutter/other/appdrawer_data/zodiac_sign.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../lovefinder.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  ///

  bool isChecked = false;
  bool isSwitched = false;
  SwiperController viewController = SwiperController();
  ZodiacSign currentSign = signs[0];
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

  dynamic _onAlertButtonsPressed(BuildContext context) async {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Sign Out",
      desc: 'Sign out of My Horoscope ?',
      buttons: [
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Sign Out",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => _signOut(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  ///
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        // statusBarColor: Colors.white,
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
      //drawerScrimColor: Colors.amber,b
      backgroundColor: Theme.of(context).primaryColor,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context)
              .primaryColor, //This will change the drawer background to blue.
          //other styles
        ),
        child: ClipRect(
          child: Drawer(
            elevation: 20.0,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(
                    user.displayName,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  accountEmail: Text(
                    user.email,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/bgg.jpg'),
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    radius: 100.0,
                    backgroundColor: Theme.of(context).accentColor,
                    foregroundColor: Theme.of(context).accentColor,
                    backgroundImage: NetworkImage(user.photoUrl),
                  ),
                ),
//            Divider(),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.home,
                        color: Theme.of(context).accentColor),
                    title: Text(
                      "Today's Horoscope", textScaleFactor: 1.5,
                      //style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        //uncomment for webview
                        //MaterialPageRoute(builder: (context) => WebViewContainer('https://i.pinimg.com/originals/9f/4b/e6/9f4be64ff60c5d9d017b2b2776dee6bc.jpg')));
                        MaterialPageRoute<void>(
                            builder: (context) => HomePage()));
                  },
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.search,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text(
                      'Zodiac Sign Finder',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        //uncomment for webview
                        //MaterialPageRoute(builder: (context) => WebViewContainer('https://i.pinimg.com/originals/9f/4b/e6/9f4be64ff60c5d9d017b2b2776dee6bc.jpg')));
                        MaterialPageRoute<void>(
                            builder: (context) => LoveScreen()));
                  },
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.heartbeat,
                      color: Theme.of(context).accentColor,
                    ),
                    title: Text(
                      'Love Percentage',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        //uncomment for webview
                        //MaterialPageRoute(builder: (context) => WebViewContainer('https://i.pinimg.com/originals/9c/c0/7f/9cc07fe0205b852eded5a5d4f54c3157.png')));
                        MaterialPageRoute<void>(
                            builder: (context) => SettingPage()));
                  },
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.cog,
                        color: Theme.of(context).accentColor),
                    title: Text(
                      'Settings',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.shareAlt,
                        color: Theme.of(context).accentColor),
                    title: Text(
                      'Share with Friends',
                      textScaleFactor: 1.5,
                    ),
                  ),
                  onTap: () {
                    Share.share(
                        'Download this amazing app now! \nhttps://play.google.com/store/apps/details?id=com.myhoroscope&hl=en_IN');
                  },
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: "v- 3.0",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        // also possible "TOP" and "CENTER"
                        backgroundColor: Colors.blueGrey,
                        textColor: Colors.white);
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (context) => AboutUS()));
                  },
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.info,
                        color: Theme.of(context).accentColor),
                    title: Text(
                      'About App',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (context) => MyReviewPage()));
                  },
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.googlePlay,
                        color: Theme.of(context).accentColor),
                    title: Text(
                      'Rate App',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    _launchURL();
                  },
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.commentDots,
                        color: Theme.of(context).accentColor),
                    title: Text(
                      'Contact Us',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
                Divider(
                  height: 10.0,
                ),
                Divider(
                  height: 190.0,
                  color: Colors.transparent,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text(
                      "   Made with ❤ in india",
                      textScaleFactor: 1.5,
                    ), // ignore: prefer_single_quotes
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      ///NormalDrawerEnd
//for Dark Mode
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _onAlertButtonsPressed(context),
          ),
        ],

        title: Text(
          "My Horoscope", // ignore: prefer_single_quotes
          style: TextStyle(
            backgroundColor: Theme.of(context).primaryColor,
            // color: Colors.black87,
            fontSize: 24,
            fontFamily: 'Augustus',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        //backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 400,
              child: Center(
                child: Swiper(
                  controller: viewController,
                  curve: Curves.decelerate,
                  onIndexChanged: (index) => {
                    setState(
                      () {
                        currentSign = signs[index];
                      },
                    )
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return HoroscopeCard(
                      sign: signs[index],
                    );
                  },
                  itemCount: 12,
                  itemWidth: 300.0,
                  itemHeight: 450.0,
                  layout: SwiperLayout.TINDER,
                ),
              ),
            ),
            Text(
              currentSign.getName,
              style: TextStyle(
                  // color: Colors.black87,
                  fontSize: 28,
                  fontFamily: 'Augustus',
                  fontWeight: FontWeight.w800),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                // ignore: prefer_single_quotes
                currentSign.getSpan ?? "213",
                style: TextStyle(
                  //color: Colors.black87,
                  fontSize: 22,
                  fontFamily: 'Augustus',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 96),
              child: Text(
                "----------------------------------------------------\nSwipe To Know Your Horoscope\n----------------------------------------------------", // ignore: prefer_single_quotes
                //"", currentSign.getSpan ?? "213",
                style: TextStyle(
                  //backgroundColor: Colors.transparent,
                  // color: Colors.black87,
                  // backgroundColor: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontFamily: 'Augustus',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HoroscopeCard extends StatelessWidget {
  final ZodiacSign sign;

  // ignore: sort_constructors_first, prefer_const_constructors_in_immutables
  HoroscopeCard({Key key, this.sign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => DetailPage(
              sign: sign,
            ),
          ),
        );
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Hero(
              tag: sign.name,
              child: Image.asset(sign.cardPath),
            ),
          ],
        ),
      ),
    );
  }
}

//for contact in app drawer
void _launchURL() async {
  const url =
      'mailto:myhoroscope123@gmail.com?subject=feedback&body=Any suggestions	';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//                                 *HAPPY CODING*
// Alert with multiple and custom buttons
void _launchURL1() async {
  const url =
      'https://play.google.com/store/apps/details?id=com.myhoroscope&hl=en_IN';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
