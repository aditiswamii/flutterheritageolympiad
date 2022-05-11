import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodegained/duelmode_gained.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DuelModeResultXP(),
  ));
}

class DuelModeResultXP extends StatefulWidget {
  const DuelModeResultXP({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

const TWO_PI = 3.14 * 2;

class _State extends State<DuelModeResultXP> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool value = false;
  late double progressValue;
  final size = 200.0;
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
            image: AssetImage("assets/images/whitebg.png"),
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
                      child: Image.asset("assets/images/home_1.png",
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
                      child: Image.asset("assets/images/side_menu_2.png",
                          height: 40, width: 40),
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                  child: const Text("Carousel to XP",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.txt))),
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text(
                    "YOU\nGAINED....",
                    style: TextStyle(
                        fontSize: 24, color: ColorConstants.txt),
                    textAlign: TextAlign.center,
                  )),
              Center(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: size,
                  height: size,
                  child: Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return SweepGradient(
                              startAngle: 0.0,
                              endAngle: TWO_PI,
                              stops: [0.5, 0.5],
                              // 0.0 , 0.5 , 0.5 , 1.0
                              center: Alignment.center,
                              colors: ColorConstants.gradient_progress)
                              .createShader(rect);
                        },
                        child: Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: size - 40,
                          height: size - 40,
                          decoration:
                          BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Container(
                            //margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                            //alignment: Alignment.bottomCenter,
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "14 XP",textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "You can do better!",textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  decoration: BoxDecoration(
                      color: Colors.white),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      // if you need this
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Text("YOU SCORED...",style: TextStyle(color: ColorConstants.txt),),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: GFProgressBar(
                              leading: Container(
                                // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 30,
                                width: 30,
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage:
                                  AssetImage("assets/images/cat1.png"),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              percentage: 0.5,
                              lineHeight: 30,
                              alignment: MainAxisAlignment.spaceBetween,
                              child: const Text('REAGAN2021', textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              backgroundColor: Colors.black12,
                              progressBarColor: ColorConstants.yellow200,
                            )
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: GFProgressBar(
                              leading: Container(
                                // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 30,
                                width: 30,
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage:
                                  AssetImage("assets/images/cat2.png"),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              percentage: 0.6,
                              lineHeight: 30,
                              alignment: MainAxisAlignment.spaceBetween,
                              child: const Text('HANA210', textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              backgroundColor: Colors.black12,
                              progressBarColor: ColorConstants.red,
                            )
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
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
                                builder: (context) => const WelcomePage()));
                      },
                      child: const Text(
                        "GO BACK",
                        style: TextStyle(
                            color: ColorConstants.lightgrey200, fontSize: 14),
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
                                builder: (context) => const DuelModeGained()));
                      },
                      child: const Text(
                        "LET'S GO!",
                        style: TextStyle(
                            color: ColorConstants.lightgrey200, fontSize: 14),
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
