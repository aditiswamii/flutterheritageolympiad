import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/duelinvitesent/duelinvite_dialog.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodemain/duelmode_main.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmoderesult/duelmode_result.dart';
import 'package:flutterheritageolympiad/recycleview/recyckeview.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ClassicModeSelectPlayer(),
  ));
}

class ClassicModeSelectPlayer extends StatefulWidget {
  const ClassicModeSelectPlayer({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ClassicModeSelectPlayer> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool value = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 5.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WelcomePage()));
                      },
                      child: Image.asset("assets/home_1.png",
                          height: 40, width: 40),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 5.0),
                    child: GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: Image.asset("assets/side_menu_2.png",
                          height: 40, width: 40),
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                  child: const Text("DUEL MODE",
                      style: TextStyle(
                          fontSize: 24, color: ColorConstants.Omnes_font))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text(
                      "You may choose another player in your\ncontact list to duel with.",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font))),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "HIDE BUSY PLAYERS",
                      style: TextStyle(
                          color: ColorConstants.Omnes_font, fontSize: 15),
                    ),
                    Checkbox(
                      value: this.value,
                      onChanged: (value) {
                        setState(() {
                          this.value = true;
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: const Divider(
                  color: ColorConstants.Omnes_font,
                  height: 2,
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: const BoxDecoration(color: Colors.white),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              height: 120,
                              width: 120,
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    AssetImage("assets/cat1.png"),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            // Image.asset("assets/profile.png",height: 100,width: 100,),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
                              child: Column(
                                children: [
                                  Text("EUNGEUNG519"),
                                  Row(
                                    children: [
                                      Text("GROUP 3"),
                                      Text("|"),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/india.png",
                                            width: 10,
                                            height: 10,
                                          ),
                                          Text("INDIA"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "AVAILABLE",
                                    style: TextStyle(
                                        color: ColorConstants.verdigris),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: ColorConstants.myfeed,
                                      onPrimary: Colors.white,
                                      elevation: 3,
                                      alignment: Alignment.center,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      fixedSize: const Size(100, 40),
                                      //////// HERE
                                    ),
                                    onPressed: () {
                                      AlertDialog errorDialog = AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0)), //this right here
                                          title: Container(
                                              height: 250,
                                              width: 250,
                                              alignment: Alignment.center,
                                              child: DialogDuelInviteSent()));
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                          errorDialog);
                                    },
                                    child: const Text(
                                      "SEND INVITE",
                                      style: TextStyle(
                                          color: ColorConstants.to_the_shop,
                                          fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: const BoxDecoration(color: Colors.white),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              height: 120,
                              width: 120,
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    AssetImage("assets/cat1.png"),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            // Image.asset("assets/profile.png",height: 100,width: 100,),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
                              child: Column(
                                children: [
                                  Text("EUNGEUNG519"),
                                  Row(
                                    children: [
                                      Text("GROUP 3"),
                                      Text("|"),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/india.png",
                                            width: 10,
                                            height: 10,
                                          ),
                                          Text("INDIA"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "AVAILABLE",
                                    style: TextStyle(
                                        color: ColorConstants.verdigris),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: ColorConstants.myfeed,
                                      onPrimary: Colors.white,
                                      elevation: 3,
                                      alignment: Alignment.center,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      fixedSize: const Size(100, 40),
                                      //////// HERE
                                    ),
                                    onPressed: () {
                                      AlertDialog errorDialog = AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0)), //this right here
                                          title: Container(
                                              height: 250,
                                              width: 250,
                                              alignment: Alignment.center,
                                              child: DialogDuelInviteSent()));
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                          errorDialog);
                                    },
                                    child: const Text(
                                      "SEND INVITE",
                                      style: TextStyle(
                                          color: ColorConstants.to_the_shop,
                                          fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: const BoxDecoration(color: Colors.white),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              height: 120,
                              width: 120,
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    AssetImage("assets/cat1.png"),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            // Image.asset("assets/profile.png",height: 100,width: 100,),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
                              child: Column(
                                children: [
                                  Text("EUNGEUNG519"),
                                  Row(
                                    children: [
                                      Text("GROUP 3"),
                                      Text("|"),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/india.png",
                                            width: 10,
                                            height: 10,
                                          ),
                                          Text("INDIA"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "BUSY",
                                    style:
                                        TextStyle(color: ColorConstants.myfeed),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: ColorConstants.myfeed,
                                      onPrimary: Colors.white,
                                      elevation: 3,
                                      alignment: Alignment.center,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      fixedSize: const Size(100, 40),
                                      //////// HERE
                                    ),
                                    onPressed: () {
                                      AlertDialog errorDialog = AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20.0)), //this right here
                                          title: Container(
                                              height: 250,
                                              width: 250,
                                              alignment: Alignment.center,
                                              child: DialogDuelInviteSent()));
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              errorDialog);
                                    },
                                    child: const Text(
                                      "SEND INVITE",
                                      style: TextStyle(
                                          color: ColorConstants.to_the_shop,
                                          fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 120, 0, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstants.red,
                        onPrimary: Colors.white,
                        elevation: 3,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        fixedSize: const Size(100, 40),
                        //////// HERE
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuizPage()));
                      },
                      child: const Text(
                        "EDIT QUIZ",
                        style: TextStyle(
                            color: ColorConstants.to_the_shop, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstants.verdigris,
                        onPrimary: Colors.white,
                        elevation: 3,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        fixedSize: const Size(100, 40),
                        //////// HERE
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DuelModeResult()));
                      },
                      child: const Text(
                        "LET'S GO!",
                        style: TextStyle(
                            color: ColorConstants.to_the_shop, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
