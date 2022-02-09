import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/emailresend/emailresend_dialog.dart';
import 'package:flutterheritageolympiad/ui/alldone/alldone_presenter.dart';
import 'package:flutterheritageolympiad/ui/alldone/alldone_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/login/login_page.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AllDonePage(),
  ));
}

class AllDonePage extends StatefulWidget {
  const AllDonePage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AllDonePage> implements AllDoneView {
  late AllDonePresenter _presenter;
  bool value = false;



  @override
  void initState() {
    super.initState();

    _presenter = AllDonePresenter(this);
    //autoLogIn();
  }
  Future<Null> Preference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var email=prefs.getString('username');
    var issocial=prefs.get('is_social');
    _presenter = AllDonePresenter(this);
    _presenter.verifyemail(email.toString(), "", issocial.toString());
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                  child: const Text("ALL DONE!",
                      style: TextStyle(
                          fontSize: 24, color: ColorConstants.Omnes_font))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: const Text(
                      "To start using the app,please verify your email address",
                      style: TextStyle(
                          fontSize: 18, color: ColorConstants.Omnes_font))),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.white,
                    elevation: 3,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    fixedSize: const Size(100, 50),
                    //////// HERE
                  ),
                  onPressed: () {
                    Preference();
                  },
                  child: const Text(
                    "NEXT",
                    style: TextStyle(
                        color: ColorConstants.Omnes_font, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const Divider(
                  color: ColorConstants.Omnes_font,
                  height: 2,
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: const Text(
                      "Haven't gotten an email?We can send it again!",
                      style: TextStyle(
                          fontSize: 18, color: ColorConstants.Omnes_font))),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 20, 10),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.white,
                        elevation: 3,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        fixedSize: const Size(100, 50),
                        //////// HERE
                      ),
                      onPressed: () {
                        AlertDialog errorDialog = AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0)), //this right here
                            title: Container(
                                height: 250,
                                width: 250,
                                alignment: Alignment.center,
                                child: DialogEmailResend()));
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => errorDialog);
                      },
                      child: const Text(
                        "RESEND",
                        style: TextStyle(
                            color: ColorConstants.Omnes_font, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  titleTextStyle: TextStyle(
                                      fontSize: 12, color: ColorConstants.Omnes_font),
                                  title:  Image.asset(
                                    "assets/hint.png",
                                    height: 50,
                                    width: 100,
                                    alignment: Alignment.center,
                                  ),
                                  content: Text(
                                    'Check your spam!',
                                    style: TextStyle(color: ColorConstants.Omnes_font),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              });
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) => const VjournoMain()));
                        },
                        child: Image.asset(
                          "assets/hint.png",
                          height: 50,
                          width: 100,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onsuccess() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginPage()));
  }
}
