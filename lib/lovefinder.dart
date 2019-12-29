import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoveScreen extends StatefulWidget {
  @override
  _LoveScreen createState() => _LoveScreen();
}

class _LoveScreen extends State<LoveScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _yourName = new TextEditingController();
  TextEditingController _partnerName = new TextEditingController();
  String firstName, secondName;
  String percentage = '';

  void _erase() {
    setState(() {
      percentage = '';
      _yourName.clear();
      _partnerName.clear();
    });
  }

  void _calculate() {
    setState(() {
      if (_yourName.text.isNotEmpty && _yourName.text.isNotEmpty) {
        firstName = _yourName.text;
        secondName = _partnerName.text;

        int sum1 = sumCalc(firstName);
        int sum2 = sumCalc(secondName);

        int totalSum = sum1 + sum2;
        totalSum = totalSum % 10;
        totalSum = totalSum * 10;

        percentage = totalSum.toString() + '%';
      }
    });
  }

  int sumCalc(String s) {
    int sum = 0;
    for (int i = 0; i < s.length; i++) {
      sum = sum + s.codeUnitAt(i);
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: scaffoldKey,

        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF6060), Color(0xFFC829C8)],
          )),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/images/logo.png'),
                    TextField(
                      controller: _yourName,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[a-z A-Z]"))
                      ],
                      decoration: InputDecoration(
                          // fillColor: Colors.white,
                          filled: true,
                          hintText: 'Enter your full Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _partnerName,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[a-z A-Z]"))
                      ],
                      decoration: InputDecoration(
                          // fillColor: Colors.white,
                          filled: true,
                          hintText: 'Enter your partner Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Colors.deepOrange,
                          child: Text("Calculate"),
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _calculate();
                          },
                        ),
//                        RaisedButton(
//                          padding: EdgeInsets.all(10),
//                          //onPressed: _calculate,
//                          onPressed: () {
//                            FocusScope.of(context).unfocus();
//                            _calculate();
//                          },
//                          // color: Colors.white,
//                          child: Text(
//                            'Calculate',
//                            style: TextStyle(
//                              fontFamily: 'Montserrat',
//                              fontSize: 20.0,
//                            ),
//                          ),
//                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Colors.deepPurple,
                          child: Text("Clear"),
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            _erase();
                          },
                        ),
//                        RaisedButton(
//                          onPressed: _erase,
//                          // color: Colors.white,
//                          padding: EdgeInsets.all(10),
//                          child: Text(
//                            'Clear',
//                            style: TextStyle(
//                              fontSize: 20.0,
//                              fontFamily: 'Montserrat',
//                            ),
//                          ),
//                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '$percentage',
                            style: TextStyle(
                                fontSize: 50.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 30,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ));
  }
}
