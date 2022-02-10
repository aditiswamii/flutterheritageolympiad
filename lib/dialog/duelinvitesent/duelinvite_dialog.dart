import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';

void main() {
  runApp( MaterialApp(
    theme: ThemeData(fontFamily: "Nunito"),
    debugShowCheckedModeBanner: false,
    home: DialogDuelInviteSent(),
  ));
}
class DialogDuelInviteSent extends StatefulWidget{
  const DialogDuelInviteSent({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<DialogDuelInviteSent> with WidgetsBindingObserver {
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
                    child: Text('Invite Sent!',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 24 ),)
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                    AssetImage("assets/profile.png"),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    margin:EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color:Colors.white
                    ),
                    child: Text('REAGAN2021',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.Omnes_font,fontSize:18 ),)
                ),
                Container(
                    alignment: Alignment.center,
                    margin:EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color:Colors.white
                    ),
                    child: Text("You'll be notified when they\nhave accepted your invite.",textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.Omnes_font,fontSize:13 ),)
                ),
              ],
            )
        )
    );
  }
}
