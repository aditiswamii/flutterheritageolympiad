import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/ui/myaccount/payment/payment_screen.dart';

void main() {
  runApp( MaterialApp(
    theme: ThemeData(fontFamily: "Nunito"),
    debugShowCheckedModeBanner: false,
    home: DialogCancelPlanSuccess(),
  ));
}
class DialogCancelPlanSuccess extends StatefulWidget{
  const DialogCancelPlanSuccess({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<DialogCancelPlanSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
            decoration: const BoxDecoration(
             color: ColorConstants.verdigris
            ),
            // height:250,
            // width: 250,
            alignment: Alignment.center,
            //margin: EdgeInsets.fromLTRB(0,10,0,10),
            padding: EdgeInsets.all(10),
            child:Text('You have successfully cancelled your plans.',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.lightgrey200,fontSize:18 ),)
        )
    );
  }
}
