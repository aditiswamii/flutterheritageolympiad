
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
import 'package:flutterheritageolympiad/utils/apppreference.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

  runApp( MaterialApp(
    theme: ThemeData(fontFamily: "Nunito"),
    debugShowCheckedModeBanner: false,
    home: WelcomePage(),
  ));
}
class WelcomePage extends StatefulWidget{

  const WelcomePage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<WelcomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
//var username = SharedObjects.prefs.getString("username");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      body:Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/login_bg.jpg"),
          fit: BoxFit.cover,
    ),
    ),
    child:Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: ListView(
    children: [

      Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 5.0),
        child: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState!.openEndDrawer();
          },
          child:  Image.asset("assets/side_menu_2.png",height: 40,width: 40),
        ),
      ),
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
          child: const Text("WELCOME BACK,",style: TextStyle(fontSize: 24,color: ColorConstants.Omnes_font,fontFamily: "Nunito"))),
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          child: const Text("HANA210",style: TextStyle(fontSize: 24,color: ColorConstants.Omnes_font,fontFamily: "Nunito"))),

      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(10, 0, 10, 30),
        child:Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    height: 150,
                  //  width: 150,
                  decoration: const BoxDecoration(
                  color: ColorConstants.myaccount
                    ),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyAccountPage()));
                        },
                        child: Column(

                          children: [
                            Flexible(
                                child:Container(
                                  alignment: Alignment.topRight,
                                  child: Image.asset("assets/mcq_pattern2.png",
                                  height: 20,width: 20,alignment: Alignment.topRight),
                                )),
                            Text("MY ACCOUNT",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,),


                            Flexible(child:Container(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset("assets/mcq_pattern2.png",
                                height: 20,width: 20,),
                            )),
                         
                          ],
                        )),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                    height: 150,
                    //width: 150,
                     decoration: const BoxDecoration(
                     color: ColorConstants.myfeed
                       ),
                     child: GestureDetector(
                         onTap: () {
                           // Navigator.pushReplacement(
                           //     context,
                           //     MaterialPageRoute(
                           //         builder: (context) =>  ReadContacts()));
                         },
                         child: Column(
                           children: [
                             Flexible(
                                 child:Container(
                                   alignment: Alignment.topRight,
                                   child: Image.asset("assets/mcq_pattern2.png",
                                       height: 20,width: 20,alignment: Alignment.topRight),
                                 )),
                             Text("MY FEED",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,),
                             Flexible(child:Container(
                               alignment: Alignment.bottomCenter,
                               child: Image.asset("assets/mcq_pattern2.png",
                                 height: 20,width: 20,),
                             )),
                           ],
                         )),
                      ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 5, 0),
                    padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                    height: 150,
                   // width: 150,
                    decoration: const BoxDecoration(
                        color: ColorConstants.to_the_quizzes
                    ),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const QuizPage()));
                        },
                        child: Column(
                          children: [
                            Flexible(
                                child:Container(
                                  alignment: Alignment.topLeft,
                                  child: Image.asset("assets/mcq_pattern2.png",
                                      height: 20,width: 20,alignment: Alignment.topRight),
                                )),
                            Text("TO THE QUIZZES",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,),
                            Flexible(child:Container(
                              alignment: Alignment.bottomRight,
                              child: Image.asset("assets/mcq_pattern2.png",
                                height: 20,width: 20,),
                            )),
                          ],
                        )),
                  ),
                ),
               Flexible(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                    height: 150,
                   // width: 150,
                    decoration: const BoxDecoration(
                        color: ColorConstants.to_the_shop
                    ),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ShopPage()));
                        },

                        child: Column(
                          children: [
                            Flexible(
                                child:Container(
                                  alignment: Alignment.topRight,
                                  child: Image.asset("assets/mcq_pattern2.png",
                                      height: 20,width: 20,alignment: Alignment.topRight),
                                )),
                            Text("TO THE SHOP",style: TextStyle(color:ColorConstants.Omnes_font,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,),
                            Flexible(child:Container(
                              alignment: Alignment.bottomLeft,
                              child: Image.asset("assets/mcq_pattern2.png",
                                height: 20,width: 20,),
                            )),
                          ],
                        )),
                  ),
                )
              ],
            ),
          ],
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
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text("Your Activity Summary",
                  style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 12),textAlign: TextAlign.center,),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  RotatedBox(
                  quarterTurns: 3,
                  child: new Container(
                      width: 20,
                      height: 50,
                      decoration: BoxDecoration(
                        color: ColorConstants.red,
                      borderRadius: new BorderRadius.only(
                        topLeft: new Radius.circular(10),
                        topRight: new Radius.circular(10),
                ),
              ),
                  )
              ),
                    RotatedBox(
                        quarterTurns: 3,
                        child: new Container(
                          width: 20,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: new BorderRadius.only(
                              topLeft: new Radius.circular(2),
                              topRight: new Radius.circular(2),
                            ),
                          ),
                        )
                    ),
                    RotatedBox(
                        quarterTurns: 3,
                        child: new Container(
                          width: 20,
                          height: 50,
                          decoration: BoxDecoration(
                            color: ColorConstants.myfeed,
                            borderRadius: new BorderRadius.only(
                              topLeft: new Radius.circular(2),
                              topRight: new Radius.circular(2),
                            ),
                          ),
                        )
                    ),
                    RotatedBox(
                        quarterTurns: 3,
                        child: new Container(
                          width: 20,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: new BorderRadius.only(
                              topLeft: new Radius.circular(2),
                              topRight: new Radius.circular(2),
                            ),
                          ),
                        )
                    ),
                    RotatedBox(
                        quarterTurns: 3,
                        child: new Container(
                          width: 20,
                          height: 50,
                          decoration: BoxDecoration(
                            color: ColorConstants.verdigris,
                            borderRadius: new BorderRadius.only(
                              bottomLeft: new Radius.circular(10),
                              bottomRight: new Radius.circular(10),
                            ),
                          ),
                        )
                    ),
            ],
          ),
      ),
              Container(
                child: Text("Leagues",
                  style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 12),textAlign: TextAlign.center,),
              ),
      ]
    ),
      ),
    ),
    ),
      ]
      ),
      ),
    ),
    );
  }
}
