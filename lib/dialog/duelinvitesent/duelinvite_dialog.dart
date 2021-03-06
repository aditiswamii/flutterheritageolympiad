import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:CultreApp/colors/colors.dart';


class DialogDuelInviteSent extends StatefulWidget{
var id;
var image;
var agegroup;
var name;
var flagicon;
var status;
var request;
  DialogDuelInviteSent({Key? key,required this.name,required this.id,required this.agegroup,
    required this.flagicon,required this.image,required this.request,required this.status}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<DialogDuelInviteSent> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body:GestureDetector(
          onTap: (){
           // Navigator.pop(context);
          },
          child: Container(
              height: 230,
              width: 250,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(20,10,20,10),

              child:Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      margin:EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color:Colors.white
                      ),
                      child: Text('Invite Sent!',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize: 24 ),)
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    height: 80,
                    width: 80,
                    child:widget.image==""? CircleAvatar(
                      radius: 30.0,
                      backgroundImage:AssetImage("assets/images/placeholder.png"),
                      backgroundColor: Colors.transparent,
                    ):
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                      NetworkImage(widget.image),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin:EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color:Colors.white
                      ),
                      child: Text(widget.name,textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize:18 ),)
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin:EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color:Colors.white
                      ),
                      child: Text("You'll be notified when they\nhave accepted your invite.",textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize:13 ),)
                  ),
                ],
              )
          ),
        )
    );
  }
}
