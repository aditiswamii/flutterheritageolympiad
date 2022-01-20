
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/rightdrawer/right_drawer.dart';
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySidemenuDrawer(),
      body:Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/whitebg.png"),
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
            Navigator.push(context,
                 MaterialPageRoute(builder: (context) => const MySidemenuDrawer()));
          },
          child:  Image.asset("assets/side_menu_2.png",height: 40,width: 40),
        ),
      ),
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
          child: const Text("WELCOME BACK,",style: TextStyle(fontSize: 24,color: ColorConstants.Omnes_font))),
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                    padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                    height: 150,
                    width: 150,
                  decoration: const BoxDecoration(
                  color: ColorConstants.myaccount
                    ),
                    child: Text("MY ACCOUNT",style: TextStyle(color: Colors.white,fontSize: 24),textAlign: TextAlign.center,),
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
                     child: Text("MY FEED",style: TextStyle(color: Colors.white,fontSize: 24),textAlign: TextAlign.center,),
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
                    child: Text("TO THE QUIZZES",style: TextStyle(color: Colors.white,fontSize: 24),textAlign: TextAlign.center,),
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
                    child: Text("TO THE SHOP",style: TextStyle(color:ColorConstants.Omnes_font,fontSize: 24),textAlign: TextAlign.center,),
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
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: GFProgressBar(
                    percentage: 0.5,
                    lineHeight: 30,
                    alignment: MainAxisAlignment.spaceBetween,
                    child: const Text('10 out of 20', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    backgroundColor: Colors.black12,
                    progressBarColor: Colors.blue,
                  )
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: GFProgressBar(
                    percentage: 0.6,
                    lineHeight: 30,
                    alignment: MainAxisAlignment.spaceBetween,
                    child: const Text('12000 XP out of 20000XP', textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    backgroundColor: Colors.black12,
                    progressBarColor: Colors.blue,
                  )
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 20),

                  child: GFProgressBar(
                  //   linearGradient:  LinearGradient(begin: Alignment.centerLeft,
                    //   end: Alignment.centerRight,colors: [ColorConstants.quiz_grad1, ColorConstants.quiz_grad2, ColorConstants.quiz_grad3].toList(growable: true)),
                     percentage: 0.9,
                    lineHeight: 30,
                    alignment: MainAxisAlignment.spaceBetween,
                    // child: const Text('70%', textAlign: TextAlign.center,
                    //   style: TextStyle(fontSize: 18, color: Colors.white),
                    // ),
                    backgroundColor: Colors.black12,
                    progressBarColor: ColorConstants.quiz_grad1,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorConstants.quiz_grad1,
                            ColorConstants.quiz_grad2,
                            ColorConstants.quiz_grad3
                          ],
                          stops: [
                            0.0,
                            0.5,
                            0.9,
                          ],
                        ),
                      ),
                    ),
                  )
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
