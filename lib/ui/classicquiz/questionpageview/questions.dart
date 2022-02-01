import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ClassicQuestion(),
  ));
}
class ClassicQuestion extends StatefulWidget{
  const ClassicQuestion({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<ClassicQuestion> {
  bool _hasBeenPressed = false;
  @override
  Widget build(BuildContext context) {
    Colors.white;
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: ColorConstants.verd_dark,
        elevation: 0.0,
        actions: [
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 5.0),
          child: GestureDetector(
            onTap: () {
              Scaffold.of(context).openEndDrawer();
            },
            child:  Image.asset("assets/side_menu_3.png",height: 40,width: 40),
          ),
        ),
        ],
      ),
      body:Container(
        decoration:  BoxDecoration(
         color: ColorConstants.verd_dark
        ),
        child: Container(
            margin: EdgeInsets.fromLTRB(20,20,20,0),
            child: ListView(
              children: [
                Container(
                  height: 30,
                    alignment: Alignment.center,
                    margin:EdgeInsets.fromLTRB(70, 10, 70, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorConstants.to_the_shop
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/clock_green.png",width: 20,height: 20,),
                        TweenAnimationBuilder<Duration>(
                            duration: Duration(minutes:20),
                            tween: Tween(begin: Duration(minutes:20), end: Duration.zero),
                            onEnd: () {
                              Navigator.of(context).pop();
                            },
                            builder: (BuildContext context, Duration value, Widget? child) {
                              final minutes = value.inMinutes;
                              final seconds = value.inSeconds % 60;
                              return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text('(${minutes}m${seconds}s)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: ColorConstants.verd_dark,
                                          fontSize:15)));
                            }),
                      ],
                    )),
             Container(
                 margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                 child: Text('Identify this type of coral reef formation',
                   style: TextStyle(color: ColorConstants.to_the_shop,fontSize: 18),)),
                 Container(
                     margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                     child: Image.asset("assets/sample_image.png",
                       height: 250,width: 250,alignment: Alignment.center,)),
                Container(
                  child: RaisedButton(
                    textColor: _hasBeenPressed ? ColorConstants.to_the_shop: ColorConstants.verdigris ,
                    // 2
                    color: _hasBeenPressed ? ColorConstants.verdigris : ColorConstants.to_the_shop,
                    onPressed: ()=> {
                  setState(() {
                  _hasBeenPressed = !_hasBeenPressed;
                  })
                    },
                    child: Text('Atoll', style: TextStyle(fontSize: 18),),
                  ),
                ),
                Container(
                  child: RaisedButton(
                    textColor: _hasBeenPressed ? ColorConstants.to_the_shop: ColorConstants.verdigris ,
                    // 2
                    color: _hasBeenPressed ? ColorConstants.verdigris : ColorConstants.to_the_shop,
                    onPressed: ()=> {
                      setState(() {
                        _hasBeenPressed = !_hasBeenPressed;
                      })
                    },
                    child: Text('Fringing', style: TextStyle(fontSize: 18),),
                  ),
                ),
                Container(

                  child: RaisedButton(
                    textColor: _hasBeenPressed ? ColorConstants.to_the_shop: ColorConstants.verdigris ,
                    // 2
                    color: _hasBeenPressed ? ColorConstants.verdigris : ColorConstants.to_the_shop,
                    onPressed: ()=> {
                      setState(() {
                        _hasBeenPressed = !_hasBeenPressed;
                      })
                    },
                    child: Text('Barrier', style: TextStyle(fontSize: 18),),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.verd_dark,
                  ),
                  child: RaisedButton(
                    textColor: _hasBeenPressed ? ColorConstants.to_the_shop: ColorConstants.verdigris ,
                    // 2
                    color: _hasBeenPressed ? ColorConstants.verdigris : ColorConstants.to_the_shop,
                    onPressed: ()=> {
                      setState(() {
                        _hasBeenPressed = !_hasBeenPressed;
                      })
                    },
                    child: Text('Platform', style: TextStyle(fontSize: 18),),
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: (){
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const QuizPage()));
                          },
                          child: Image.asset("assets/left_arrow.png",height: 40,width: 40),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                    shape:  RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                      contentPadding:
                                      EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      titleTextStyle: TextStyle(
                                          fontSize: 12, color: ColorConstants.Omnes_font),
                                      title:  Image.asset(
                                        "assets/hint_white.png",
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
                      ),
                      Container(

                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: (){
                            // Navigator.pushReplacement(context,
                            //     MaterialPageRoute(builder: (context) => const PhoneNumber()));
                          },
                          child: Image.asset("assets/rightarrow2.png",height: 40,width: 40),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/mcq_pattern_3.png',height: 70,width: 70,alignment: Alignment.bottomCenter,)
              ],
            )
        ),
      ),

    );
  }
}