
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
import 'package:flutterheritageolympiad/utils/SharedObjects.dart';
import 'package:flutterheritageolympiad/utils/apppreference.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/SignUpModal.dart';


class WelcomePage extends StatefulWidget{

  const WelcomePage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<WelcomePage> implements SharedObjects{
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
var username;
var email;
var country;
var profilepic;
var userid;

 userdata() async {
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
     username = prefs.getString("username");
     country =prefs.getString("country");
     userid= prefs.getString("userid");
   });
}
  @override
  void initState() {
    super.initState();
    userdata();
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
        image: AssetImage("assets/images/debackground.jpg"),
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
          child: const Text("WELCOME BACK,",style: TextStyle(fontSize: 24,color: ColorConstants.txt,fontFamily: "Nunito"))),
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          child: Text(username.toString(),style: TextStyle(fontSize: 24,color: ColorConstants.txt,fontFamily: "Nunito"))),
        Container(
          //height: 300,
            width: MediaQuery.of(context).size.width,
            //alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
           GestureDetector(
             onTap:(){
               Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(
                       builder: (context) => MyAccountPage()));
        },
               child: Container(
                 height: 150,
          width: 150,
            color: ColorConstants.red200,

                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       padding: EdgeInsets.all(10),
                       alignment: Alignment.topRight,
                       child: Image.asset("assets/mcq_pattern2.png",
                           height: 20,width: 20,alignment: Alignment.topRight),
                     ),
                     Container(child: Text("MY ACCOUNT",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,)),
                     Container(
                       padding: EdgeInsets.all(10),
                       alignment: Alignment.topLeft,
                       child: Image.asset("assets/mcq_pattern2.png",
                           height: 20,width: 20,alignment: Alignment.topLeft),
                     ),
                   ],
                 ),

               ),
             ),
             GestureDetector(
               onTap: (){

               },
               child: Container(
                 height: 150,
                   width: 150,
                   color:ColorConstants.yellow200,

                 child:  Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       padding: EdgeInsets.all(10),
                       alignment: Alignment.topLeft,
                       child: Image.asset("assets/mcq_pattern2.png",
                           height: 20,width: 20,alignment: Alignment.topLeft),
                     ),
                     Container(child: Text("MY FEED",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,)),
                     Container(
                       padding: EdgeInsets.all(10),
                       alignment: Alignment.topRight,
                       child: Image.asset("assets/mcq_pattern2.png",
                           height: 20,width: 20,alignment: Alignment.topRight),
                     ),
                   ],
                 ),

               ),
             ),
           ],
          ),
        ),
      Container(
        //height: 300,
        width: MediaQuery.of(context).size.width,
        //alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  QuizPage()));
              },
              child: Container(
                height: 150,
                width: 150,
                color: ColorConstants.blue200,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topRight,
                      child: Image.asset("assets/mcq_pattern2.png",
                          height: 20,width: 20,alignment: Alignment.topRight),
                    ),
                    Container(child: Text("TO THE QUIZZES",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,)),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Image.asset("assets/mcq_pattern2.png",
                          height: 20,width: 20,alignment: Alignment.topLeft),
                    ),
                  ],
                ),

              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShopPage()));
              },
              child: Container(
                height: 150,
                width: 150,
                color: Colors.black26,

                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Image.asset("assets/mcq_pattern2.png",
                          height: 20,width: 20,alignment: Alignment.topLeft),
                    ),
                    Container(child: Text("TO THE SHOP",style: TextStyle(color: Colors.black54,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,)),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topCenter,
                      child: Image.asset("assets/mcq_pattern2.png",
                          height: 20,width: 20,alignment: Alignment.topCenter),
                    ),
                  ],
                ),

              ),
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
                  style: TextStyle(color: ColorConstants.txt,fontSize: 12),textAlign: TextAlign.center,),
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
                            color: ColorConstants.yellow200,
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
                  style: TextStyle(color: Colors.grey,fontSize: 12),textAlign: TextAlign.center,),
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

  @override
  preferences(Data? data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    username= prefs.getString('name');
    //username = data!.username.toString();
  }


}
