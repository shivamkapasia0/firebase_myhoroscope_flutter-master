
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth_demo_flutter/app/sign_in/sign_in_manager.dart';
import 'package:firebase_auth_demo_flutter/common_widgets/platform_exception_alert_dialog.dart';
import 'package:firebase_auth_demo_flutter/constants/keys.dart';
import 'package:firebase_auth_demo_flutter/constants/strings.dart';
import 'package:firebase_auth_demo_flutter/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
class SignInPageBuilder extends StatelessWidget {
  // P<ValueNotifier>
  //   P<SignInManager>(valueNotifier)
  //     SignInPage(value)
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      builder: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) =>
            Provider<SignInManager>(
          builder: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, SignInManager manager, __) => SignInPage._(
              isLoading: isLoading.value,
              manager: manager,
             // title: 'Firebase Auth Demo',
            ),
          ),
        ),
      ),
    );
  }

}


class SignInPage extends StatelessWidget {

  const SignInPage._({Key key, this.isLoading, this.manager, this.title})
      : super(key: key);
  ///For Phone Number Validation





  ///End************
  final SignInManager manager;
  final String title;
  final bool isLoading;

  static const Key googleButtonKey = Key('google');

  static const Key anonymousButtonKey = Key(Keys.anonymous);

  static Key get emailPasswordButtonKey => null;

  Future<void> _showSignInError(
      BuildContext context, PlatformException exception) async {
    await PlatformExceptionAlertDialog(
      title: Strings.signInFailed,
      exception: exception,
    ).show(context);
  }
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        elevation: 50.0,
//        title: Text('                         Sign IN'),
//      ),
      // Hide developer menu while loading in progress.
      // This is so that it's not possible to switch auth service while a request is in progress
     // drawer: isLoading ? null : DeveloperMenu(),
      backgroundColor: Theme.of(context).primaryColor,
      //backgroundColor: Colors.grey[200],
      body: _buildSignIn(context),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'MY Horoscope\nyvyuv',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600,color: Colors.white),
    );
  }


  Widget _buildSignIn(BuildContext context) {

  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
  ]);
  return AnnotatedRegion(
  child: Material(
  type: MaterialType.transparency,
  child: Stack(
  children: <Widget>[
  Container(
  child: Image.asset(
  "assets/images/bg.jpg",
  height: double.infinity,
  width: double.infinity,
  alignment: Alignment.center,
  fit: BoxFit.cover,
  excludeFromSemantics: true,
  scale: 50.0,
  ),
  ),
  Container(
  color: Colors.black54,
  ),
  Container(
  alignment: Alignment.centerLeft,
  padding: EdgeInsets.all(40.0),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
  Text(
  "TELL MY",
  style: TextStyle(
  color: Colors.white,
  fontSize: 34.0,
  fontWeight: FontWeight.w500),
  ),
  TyperAnimatedTextKit(
  duration: Duration(
  seconds: 2,
  ),
  textAlign: TextAlign.start,
  alignment: AlignmentDirectional.bottomCenter,
  isRepeatingAnimation: false,
  textStyle: TextStyle(
  color: Colors.green.shade200,
  fontSize: 40.0,
  fontWeight: FontWeight.w900),
  text: <String>["HOROSCOPE."],
  ),
  ],
  ),
  ),

  Container(
  alignment: Alignment.bottomCenter,
  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 60.0),
  child: MaterialButton(
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(22.0)),
  minWidth: 200.0,
  height: 45,
  elevation: 10.0,
  color: Colors.white,

  child: new Text(' Let\'s get started',
  style: new TextStyle(
  fontSize: 16.0,
  color: Colors.deepPurple,
  fontWeight: FontWeight.w800)),
  onPressed: isLoading ? null : () => _signInWithGoogle(context),
  ),
  ),
  ],
  ),
  ),
  value: SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarDividerColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.light,
  ),
  );
  }
}
