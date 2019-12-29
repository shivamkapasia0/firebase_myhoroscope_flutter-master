import 'dart:math';

import 'package:firebase_auth_demo_flutter/RateApp/ArcChooser.dart';
import 'package:firebase_auth_demo_flutter/RateApp/SmilePainter.dart';
import 'package:firebase_auth_demo_flutter/other/appdrawer_data/deviceinfo.dart';
import 'package:firebase_auth_demo_flutter/other/ui/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';


//class ReviewApp extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      theme: new ThemeData(
//        primarySwatch: Colors.red,
//      ),
//      debugShowCheckedModeBanner: false,
//      home: new Scaffold(
//        backgroundColor: Colors.white,
//        body: new MyReviewPage(),
//      ),
//    );
//  }
//}

class MyReviewPage extends StatefulWidget {
  MyReviewPage({Key key}) : super(key: key);

  @override
  _MyReviewPageState createState() => new _MyReviewPageState();
}

class _MyReviewPageState extends State<MyReviewPage>
    with TickerProviderStateMixin {
  final PageController pageControl = new PageController(
    initialPage: 2,
    keepPage: false,
    viewportFraction: 0.2,
  );

  int slideValue = 200;
  int lastAnimPosition = 2;

  AnimationController animation;

  List<ArcItem> arcItems = List<ArcItem>();

  ArcItem badArcItem;
  ArcItem ughArcItem;
  ArcItem okArcItem;
  ArcItem goodArcItem;

  Color startColor;
  Color endColor;

  @override
  void initState() {
    super.initState();

    badArcItem = ArcItem("BAD", [Color(0xFFfe0944), Color(0xFFfeae96)], 0.0);
    ughArcItem = ArcItem("UGH", [Color(0xFFF9D976), Color(0xfff39f86)], 0.0);
    okArcItem = ArcItem("OK", [Color(0xFF21e1fa), Color(0xff3bb8fd)], 0.0);
    goodArcItem = ArcItem("GOOD", [Color(0xFF3ee98a), Color(0xFF41f7c7)], 0.0);

    arcItems.add(badArcItem);
    arcItems.add(ughArcItem);
    arcItems.add(okArcItem);
    arcItems.add(goodArcItem);

    startColor = Color(0xFF21e1fa);
    endColor = Color(0xff3bb8fd);

    animation = new AnimationController(
      value: 0.0,
      lowerBound: 0.0,
      upperBound: 400.0,
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..addListener(() {
      setState(() {
        slideValue = animation.value.toInt();

        double ratio;

        if (slideValue <= 100) {
          ratio = animation.value / 100;
          startColor =
              Color.lerp(badArcItem.colors[0], ughArcItem.colors[0], ratio);
          endColor =
              Color.lerp(badArcItem.colors[1], ughArcItem.colors[1], ratio);
        } else if (slideValue <= 200) {
          ratio = (animation.value - 100) / 100;
          startColor =
              Color.lerp(ughArcItem.colors[0], okArcItem.colors[0], ratio);
          endColor =
              Color.lerp(ughArcItem.colors[1], okArcItem.colors[1], ratio);
        } else if (slideValue <= 300) {
          ratio = (animation.value - 200) / 100;
          startColor =
              Color.lerp(okArcItem.colors[0], goodArcItem.colors[0], ratio);
          endColor =
              Color.lerp(okArcItem.colors[1], goodArcItem.colors[1], ratio);
        } else if (slideValue <= 400) {
          ratio = (animation.value - 300) / 100;
          startColor =
              Color.lerp(goodArcItem.colors[0], badArcItem.colors[0], ratio);
          endColor =
              Color.lerp(goodArcItem.colors[1], badArcItem.colors[1], ratio);
        }
      });
    });

    animation.animateTo(slideValue.toDouble());
  }
  dynamic _onAlertButtonsPressed (BuildContext context) async {

    Alert(
      context: context,
      type: AlertType.success,
      title: "Feedback Submitted",
      desc: 'Please rate App on Play Store.',
      buttons: [
        DialogButton(
          child: Text(
            "Home",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () =>
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => MainMenu())),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Play Store",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {_launchURL1();},
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
  @override
  Widget build(BuildContext context) {
    var textStyle = new TextStyle(
        color: Colors.white, fontSize: 24.00, fontWeight: FontWeight.bold);

    return Container(color: Theme.of(context).primaryColor,
      margin: MediaQuery.of(context).padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "How was your experience with us?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          ),
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width,
                (MediaQuery.of(context).size.width / 2) + 60),
            painter: SmilePainter(slideValue),
          ),
//          Slider(
//            min: 0.0,
//            max: 400.0,
//            value: slideValue.toDouble(),
//            onChanged: (double newValue) {
//              setState(() {
//                slideValue = newValue.round();
//              });
//            },
//          ),

//          new SizedBox(
//            height: 50.0,
//            child: new NotificationListener(
//              onNotification: (ScrollNotification notification){
//                if(!notification.metrics.atEdge){
//                  print('_MyReviewPageState.build ' + MediaQuery.of(context).size.width.toString() + " " + notification.metrics.pixels.toString());
//                }
//
//              },
//              child: PageView.builder(
//                pageSnapping: true,
//                onPageChanged: (int value) {
//                  print('_MyReviewPageState._onPageChanged ' + value.toString());
//                  animation.animateTo(value*100.0);
//                },
//                controller: pageControl,
//                itemCount: arcItems.length,
//                physics: new AlwaysScrollableScrollPhysics(),
//                itemBuilder: (context, index) {
//                  return new Container(
//                      decoration: new BoxDecoration(
//                        gradient: new LinearGradient(
//                            colors: [
//                              arcItems[index].colors[0],
//                              arcItems[index].colors[1]
//                            ]
//                        ),
//                      ),
//                      alignment: Alignment.center,
//                      child: new Text(
//                        arcItems[index].text,
//                        style: textStyle,
//                      ));
//                },
//              ),
//            ),
//          ),
          Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                ArcChooser()
                  ..arcSelectedCallback = (int pos, ArcItem item) {
                    int animPosition = pos - 2;
                    if (animPosition > 3) {
                      animPosition = animPosition - 4;
                    }

                    if (animPosition < 0) {
                      animPosition = 4 + animPosition;
                    }

                    if (lastAnimPosition == 3 && animPosition == 0) {
                      animation.animateTo(4 * 100.0);
                    } else if (lastAnimPosition == 0 && animPosition == 3) {
                      animation.forward(from: 4 * 100.0);
                      animation.animateTo(animPosition * 100.0);
                    } else if (lastAnimPosition == 0 && animPosition == 1) {
                      animation.forward(from: 0.0);
                      animation.animateTo(animPosition * 100.0);
                    } else {
                      animation.animateTo(animPosition * 100.0);
                    }

                    lastAnimPosition = animPosition;
                  },
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    elevation: 8.0,
                    child: Container(
                        width: 150.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          gradient:
                          LinearGradient(colors: [startColor, endColor]),
                        ),
                        alignment: Alignment.center,
                        child: InkWell(onTap: (){  _onAlertButtonsPressed(context);
                        },
                          child: Text(
                            'SUBMIT',
                            style: textStyle,
                          ),
                        )),
                  ),
//              child: RaisedButton(
//                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//                child: Text('SUBMIT'),
//                onPressed: () {
//                  print('cool');
//                },
//              ),
                )
              ]),
        ],
      ),
    );
  }
}
void _launchURL1() async {
  const url = 'https://play.google.com/store/apps/details?id=com.myhoroscope&hl=en_IN';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}