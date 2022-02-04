
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

void main() {

  runApp(const MaterialApp(

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
          margin: const EdgeInsets.fromLTRB(0, 60, 0, 5),
          child: const Text("WELCOME BACK,",style: TextStyle(fontSize: 24,color: ColorConstants.Omnes_font))),
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          child: const Text("HANA210",style: TextStyle(fontSize: 24,color: ColorConstants.Omnes_font))),

      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
        child:Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    height: 150,
                    width: 150,
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
                            Text("MY ACCOUNT",style: TextStyle(color: Colors.white,fontSize: 24),textAlign: TextAlign.center,),


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
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                    height: 150,
                    width: 150,
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
                             Text("MY FEED",style: TextStyle(color: Colors.white,fontSize: 24),textAlign: TextAlign.center,),
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
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                    height: 150,
                    width: 150,
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
                            Text("TO THE QUIZZES",style: TextStyle(color: Colors.white,fontSize: 24),textAlign: TextAlign.center,),
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
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                        color: ColorConstants.to_the_shop
                    ),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ShopProduct()));
                        },

                        child: Column(
                          children: [
                            Flexible(
                                child:Container(
                                  alignment: Alignment.topRight,
                                  child: Image.asset("assets/mcq_pattern2.png",
                                      height: 20,width: 20,alignment: Alignment.topRight),
                                )),
                            Text("TO THE SHOP",style: TextStyle(color:ColorConstants.Omnes_font,fontSize: 24),textAlign: TextAlign.center,),
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
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text("YOUR ACTIVITY SUMMARY",style: TextStyle(color: ColorConstants.Omnes_font),),
              ),
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: ColorConstants.gradient
                      ),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: GFProgressBar(
                    percentage: 0.5,
                    lineHeight: 30,
                    alignment: MainAxisAlignment.spaceBetween,
                    child: const Text('10 out of 20', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    backgroundColor: Colors.transparent,
                    progressBarColor: Colors.transparent,
                  )
              ),
              Container(
                child: Text("Quizzes done this week",
                  style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 12),textAlign: TextAlign.center,),
              ),
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: ColorConstants.gradient,
                      ),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: GFProgressBar(
                    percentage: 0.6,
                    lineHeight: 30,
                    alignment: MainAxisAlignment.spaceBetween,
                    child: const Text('12000 XP out of 20000XP', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    backgroundColor: Colors.transparent,
                    progressBarColor: Colors.transparent,
                  )
              ),
              Container(
                child: Text("Next Achievement",
                  style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 12),textAlign: TextAlign.center,),
              ),
              // Container(
              //   margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              //   alignment: Alignment.centerLeft,
              //   height: 30,
              //   decoration: BoxDecoration(
              //       // gradient: LinearGradient(
              //       //     colors: [ColorConstants.quiz_grad1,ColorConstants.quiz_grad2,ColorConstants.quiz_grad3]
              //       // ),
              //       borderRadius: BorderRadius.circular(30)
              //   ),
              //   child: Row(
              //      // mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //
              //       Container(
              //           width: 60,
              //           decoration: BoxDecoration(
              //             color: Colors.red,
              //               borderRadius: BorderRadius.circular(30)
              //           ),
              //           child: TextButton( onPressed: () {  },
              //           child: Text("",style: TextStyle(color: Colors.red,)))),
              //       Container(
              //           width: 60,
              //           decoration: BoxDecoration(
              //           color: Colors.deepOrangeAccent,
              //           borderRadius: BorderRadius.circular(30)
              //       ),
              //
              //           child:  TextButton( onPressed: () {  },
              //             child: Text("",style: TextStyle(color: Colors.red),),)),
              //       Container(
              //           width: 60,
              //           decoration: BoxDecoration(
              //           color: Colors.orange,
              //           // gradient: LinearGradient(
              //           //     colors: [ColorConstants.quiz_grad1,ColorConstants.quiz_grad2,ColorConstants.quiz_grad3]
              //           // ),
              //           borderRadius: BorderRadius.circular(30)
              //       ),
              //           child:  TextButton( onPressed: () {  },
              //             child: Text("",style: TextStyle(color: Colors.red),),)),
              //       Container(
              //         width: 60,
              //           decoration: BoxDecoration(
              //               color: Colors.green,
              //               // gradient: LinearGradient(
              //               //     colors: [ColorConstants.quiz_grad1,ColorConstants.quiz_grad2,ColorConstants.quiz_grad3]
              //               // ),
              //               borderRadius: BorderRadius.circular(30)
              //           ),
              //           child:  TextButton( onPressed: () {  },
              //             child: Text("",style: TextStyle(color: Colors.red),),)),
              //       Container(
              //         width: 60,
              //           decoration: BoxDecoration(
              //               color: Colors.lightBlue,
              //               // gradient: LinearGradient(
              //               //     colors: [ColorConstants.quiz_grad1,ColorConstants.quiz_grad2,ColorConstants.quiz_grad3]
              //               // ),
              //               borderRadius: BorderRadius.circular(30)
              //           ),
              //           child:  TextButton( onPressed: () {  },
              //             child: Text("",style: TextStyle(color: Colors.red,),),)),
              //     ],
              //   ),
              //
              // ),
              Container(
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 20),

                  child: GFProgressBar(
                  //   linearGradient:  LinearGradient(begin: Alignment.centerLeft,
                    //   end: Alignment.centerRight,colors: [ColorConstants.quiz_grad1, ColorConstants.quiz_grad2, ColorConstants.quiz_grad3].toList(growable: true)),
                     percentage: 1.0,
                    lineHeight: 30,
                    alignment: MainAxisAlignment.spaceBetween,
                    // child: const Text('70%', textAlign: TextAlign.center,
                    //   style: TextStyle(fontSize: 18, color: Colors.white),
                    // ),
                    backgroundColor: Colors.transparent,
                    progressBarColor: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [Colors.red,Colors.deepOrangeAccent,Colors.orange,Colors.green,Colors.lightBlue],
                          stops: [
                            0.1,
                            0.3,
                            0.5,
                            0.7,
                            0.9,
                          ],
                        ),
                      ),
                    ),
                  )
              ),
              Container(
                child: Text("Leagues",
                  style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 12),textAlign: TextAlign.center,),
              ),
            ],
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
