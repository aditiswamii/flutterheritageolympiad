import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/classicmodelink/classicmodelink.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/classicquiz_main.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/cquizrule/classicquizrule_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/invitecontact/classicmodeplayer.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodelink/duelmodelink.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodemain/duelmode_main.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodeselectplayer/duelmodeplayer.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';

import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ClassicQuizRule(),
  ));
}

class ClassicQuizRule extends StatefulWidget {
  const ClassicQuizRule({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ClassicQuizRule> implements ClassicQuizRuleView{
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
            children:<Widget> [

              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                  child: const Text("CLASSIC QUIZ",
                      style: TextStyle(
                          fontSize: 24, color: ColorConstants.Omnes_font))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: const Text("RULES",
                      style: TextStyle(
                          fontSize: 24, color: ColorConstants.Omnes_font))),

              //Listviewbuilder add
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
                                builder: (context) => ClassicQuizMain()));
                      },
                      child: const Text(
                        "GO BACK",
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
                                builder: (context) => const WelcomePage()));
                      },
                      child: const Text(
                        "START",
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

  @override
  void onSuccess(List jsonResponse) {
    ListView _quizrule(data) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return (data[index].position);
          });
    }
  }



}

