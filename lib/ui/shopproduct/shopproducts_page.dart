
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/product/product.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
import 'package:flutterheritageolympiad/utils/apppreference.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../welcomeback/welcomeback_page.dart';
import 'experience/experienceshop.dart';


class ShopPage extends StatefulWidget{

ShopPage({Key? key}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<ShopPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool clickproduct = false;
  bool clickexprerience = false;
  bool clickgift = false;
  bool clickplans = false;
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
      BackButtonInterceptor.add(myInterceptor);
      userdata();
    }

    @override
    void dispose() {
      BackButtonInterceptor.remove(myInterceptor);
      super.dispose();
    }

    bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => WelcomePage()));
      // Do some stuff.
      return true;
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
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: ListView(
              children: [

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
                        child: Image.asset(
                            "assets/images/home_1.png", height: 40, width: 40),
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
                        child: Image.asset(
                            "assets/images/side_menu_2.png", height: 40,
                            width: 40),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: ListBody(
                    children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: const Text("STAY UNIQUE,",style: TextStyle(fontSize: 24,color: ColorConstants.txt,fontFamily: "Nunito"))),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child:  Text(username.toString(),style: TextStyle(fontSize: 18,color: ColorConstants.txt,fontFamily: "Nunito"))),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                        "You deserve to treat yourself. Find the most unique product and experience here.",
                        style: TextStyle(fontSize: 14,
                            color: ColorConstants.txt)
                    ),
                  ),
        ]
      ),
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
                  child:Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  clickproduct=true;
                                  clickexprerience=false;
                                  clickgift=false;
                                  clickplans=false;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                height: 150,
                               // width: 150,
                                decoration:  BoxDecoration(
                                    color: clickproduct!=true?ColorConstants.yellow200:ColorConstants.yellow200.withAlpha(150)
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("PRODUCTS",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "Nunito"),textAlign: TextAlign.center,),
                                      Text("Digital products included",style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: "Nunito"),textAlign: TextAlign.center,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  clickproduct=false;
                                  clickexprerience=true;
                                  clickgift=false;
                                  clickplans=false;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                               // padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                                height: 150,
                              //  width: 150,
                                decoration:  BoxDecoration(
                                    color: clickexprerience!=true?ColorConstants.lightgrey200:ColorConstants.lightgrey200.withAlpha(150)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("EXPERIENCE",style: TextStyle(color:ColorConstants.txt,fontSize: 18,fontFamily: "Nunito"),textAlign: TextAlign.center,),
                                    Text("Curated Events Listing",style: TextStyle(color: ColorConstants.txt,fontSize: 12,fontFamily: "Nunito"),textAlign: TextAlign.center,),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  clickproduct=false;
                                  clickexprerience=false;
                                  clickgift=true;
                                  clickplans=false;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                 margin: EdgeInsets.fromLTRB(0, 10, 5, 0),
                               // // padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                                 height: 150,
                               //   width: 100,
                                decoration:  BoxDecoration(
                                    color: clickgift!=true?ColorConstants.red200:ColorConstants.red200.withAlpha(150)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("GIFT CARDS",
                                      style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "Nunito"),
                                      textAlign: TextAlign.center,),
                                    Text("From 1000 INR Onwards",style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: "Nunito"),textAlign: TextAlign.center,),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  clickproduct=false;
                                  clickexprerience=false;
                                  clickgift=false;
                                  clickplans=true;
                                });
                              },

                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                padding: EdgeInsets.all(5),
                                height: 150,
                               //  width: 100,
                                decoration:  BoxDecoration(
                                    color: clickplans!=true?ColorConstants.blue200:
                                    ColorConstants.blue200.withAlpha(150)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("PLANS",
                                      style: TextStyle(color:Colors.white,
                                          fontSize: 18,fontFamily: "Nunito"),textAlign: TextAlign.center,),
                                    Text("Purchase Restore or Upgrade",
                                      style: TextStyle(color:Colors.white,
                                          fontSize: 12,fontFamily: "Nunito"),textAlign: TextAlign.center,),

                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.white,
                        elevation: 3,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        fixedSize: const Size(120, 30),
                        //////// HERE
                      ),
                      onPressed: () {
                        if(clickproduct==true){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductList()));
                        }else if(clickexprerience==true){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  ExperiencePage()));
                        }
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const ExperiencePage()));
                      },
                      child: const Text(
                        "NEXT",
                        style: TextStyle(color: ColorConstants.txt, fontSize: 16),
                        textAlign: TextAlign.center,
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
