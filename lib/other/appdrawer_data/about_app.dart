import 'package:device_info/device_info.dart';
import 'package:firebase_auth_demo_flutter/common_widgets/platform_alert_dialog.dart';
import 'package:firebase_auth_demo_flutter/other/appdrawer_data/deviceinfo.dart';
import 'package:firebase_auth_demo_flutter/other/data_app/globals.dart' as prefix0;
import 'package:firebase_auth_demo_flutter/other/ui/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:launch_review/launch_review.dart';

import 'package:firebase_auth_demo_flutter/other/data_app/constants.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUS extends StatelessWidget {

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

    return Scaffold (
      appBar: AppBar(actions: <Widget>[IconButton(icon: Icon(Icons.info),  onPressed: () {
//      deviceInfo(context);
        _onAlertButtonsPressed(context);
    },)],
        elevation: 0.0,
        centerTitle: false,
        title: Text(
          'About App',
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
              image: AssetImage("assets/images/banner.jpg"),
              // height: 200.0,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20.0, 220.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/images/ic_launcher.png"),
                      height: 30.0,
                      width: 30.0,
                    ),
                    Text(
                      " MY",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      " horoscope".toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: Colors.grey.shade600),
                    ),
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
                    prefix0.aboutBMI,
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.deepPurple,
                    child: Text("Read More..."),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      _launchURLRateApp();
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
                        "Send us your feedback on ",
                        style: TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.w500),
                      ),
                      SelectableText(
                        "myhoroscope123@gmail.com",onTap:(){ _launchURL();},
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 5.0),
                  child: Text(
                    "V 3.0" + platformVersion ,
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                Text(
                  "App is up to date",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 11.0,
                      color: Colors.grey),
                ),
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
void _deviceInfo() async{
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  print('Running on ${androidInfo.model}');
  String model = androidInfo.model.toString();
}
Future<void> deviceInfo(BuildContext context) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  print('Running on ${androidInfo.model}');
  String manufacturer = androidInfo.manufacturer.toUpperCase();
  var id = androidInfo.product.toString();
  String model = androidInfo.model.toString();
  final bool didRequestSignOut = await PlatformAlertDialog(

    title: 'App Version - v 3.0',

    content: 'Manufacturer - $manufacturer\n'+'Model - $model',
    cancelActionText: 'Home',

    defaultActionText:'Device-Info',
  ).show(context);
  if (didRequestSignOut == true) {
    Navigator.push(
        context,
        //uncomment for webview
        //MaterialPageRoute(builder: (context) => WebViewContainer('https://i.pinimg.com/originals/9f/4b/e6/9f4be64ff60c5d9d017b2b2776dee6bc.jpg')));
        MaterialPageRoute<void>(builder: (context) => DeviceInfo()));
  }
  else{
    Navigator.pop(context);
  }

}
// Alert with multiple and custom buttons
dynamic _onAlertButtonsPressed (BuildContext context) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  print('Running on ${androidInfo.model}');
  String manufacturer = androidInfo.manufacturer.toUpperCase();
  var id = androidInfo.version.release.toString();

  String model = androidInfo.model.toString();
  Alert(
    context: context,
    type: AlertType.info,
    title: "My Horoscope - v 3.0",
    desc: 'Manufacturer - $manufacturer\n'+'Model - $model\n'+ 'running on Android: $id',
    buttons: [
      DialogButton(
        child: Text(
          "BACK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () =>  Navigator.pop(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          ""
              "Home",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () =>
        Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (context) => MainMenu())),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ],
  ).show();
}
void _launchURL() async {
  const url = 'mailto:myhoroscope123@gmail.com?subject=feedback&body=Any suggestions	';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}