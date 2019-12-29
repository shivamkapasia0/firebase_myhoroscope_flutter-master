
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'signs.dart';


class DetailPage extends StatefulWidget {
  final ZodiacSign sign;

  // ignore: prefer_const_constructors_in_immutables, sort_constructors_first
  DetailPage({Key key, this.sign}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  AnimationController _controller;
  // ignore: prefer_single_quotes
  final List<String> timeSpans = ["Today", "Week", "Month", "Year"];
  // ignore: prefer_single_quotes
  String selectedSpan = "Today";

  Future<List<String>> getData() async {
    final List<String> info = ["", ""];// ignore: prefer_single_quotes
    final connectivityResult = await Connectivity().checkConnectivity();// ignore: prefer_single_quotes
    if (connectivityResult == ConnectivityResult.none) {
      // ignore: prefer_single_quotes
      info[0] = "Please Check your Internet Connection and Try Again.";
      return info;
    }
    final url = Uri.parse(
        "http://horoscope-api.herokuapp.com/horoscope/${selectedSpan.toLowerCase()}/${widget.sign.name}");// ignore: prefer_single_quotes
    final http.Response response = await http.get(
      url,
      headers: {
        "Accept": "application/json",// ignore: prefer_single_quotes
      },
    );
    final Map<String, dynamic> data = json.decode(response.body);
    switch (selectedSpan) {
      case "Today":// ignore: prefer_single_quotes
        info[0] = data["date"];// ignore: prefer_single_quotes
        break;
      case "Week":// ignore: prefer_single_quotes
        info[0] = data["week"];// ignore: prefer_single_quotes
        break;
      case "Month":// ignore: prefer_single_quotes
        info[0] = data["month"];// ignore: prefer_single_quotes
        break;
      case "Year":// ignore: prefer_single_quotes
        info[0] = data["year"];// ignore: prefer_single_quotes
        break;
      default:
    }
    info[1] = data["horoscope"];// ignore: prefer_single_quotes
    return info;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF151846),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: widget.sign.name,
              child: GestureDetector(
                onPanDown: (details) {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: widget.sign.signColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          MediaQuery.of(context).size.width / 2),
                      bottomRight: Radius.circular(
                          MediaQuery.of(context).size.width / 2),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      widget.sign.logoPath,
                      width: 200,
                      height: 200,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: FutureBuilder<List<String>>(
                future: getData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 75.0),
                        child: CircularProgressIndicator(
                          backgroundColor: widget.sign.signColor,
                        ),
                      ),
                    );
                  }
                  return Text(
                    snapshot.data[0],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: FutureBuilder<List<String>>(
                      future: getData(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }
                        return Text(
                          snapshot.data[1],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(timeSpans.length, (int index) {
          final Widget child = Container(
            height: 80.0,
            width: 60.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  0.0,
                  1.0,
                  curve: Curves.easeOutCubic,
                ),
              ),
              child: FloatingActionButton(
                heroTag: null,
                shape: StadiumBorder(),
                backgroundColor: widget.sign.getColor,
                child: Text(
                  timeSpans[index],
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {
                    selectedSpan = timeSpans[index];
                  });
                  if (_controller.isDismissed) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                },
              ),
            ),
          );
          return child;
        }).toList()
          ..add(
            FloatingActionButton(
              heroTag: null,
              backgroundColor: widget.sign.getColor,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return Opacity(
                    opacity: 1 - _controller.value,
                    child: Text(
                      selectedSpan,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            ),
          ),
      ),
    );
  }
}
