import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';


class DialogDuelWon extends StatefulWidget{
  const DialogDuelWon({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<DialogDuelWon> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          // height:250,
          // width: 250,
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(20,10,20,10),
            padding: EdgeInsets.all(10),
            child:Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin:EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color:Colors.white
                    ),
                    child: Text('You won the duel!',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize: 24 ),)
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                    AssetImage("assets/images/cat1.png"),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    margin:EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color:Colors.white
                    ),
                    child: Text('Congratulations!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorConstants.txt,fontSize:18 ),)
                ),
                Container(
                    alignment: Alignment.center,
                    margin:EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color:Colors.white
                    ),
                    child: Text("Keep it up!",textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize:13 ),)
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.white,
                      elevation: 3,
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      fixedSize: const Size(190, 50),
                      //////// HERE
                    ),
                    onPressed: () {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const AlmostTherePage()));
                    },
                    child: Image.asset("assets/images/share.png",height: 30,width: 30,)
                  ),
                ),
              ],
            )
        )
    );
  }
}
