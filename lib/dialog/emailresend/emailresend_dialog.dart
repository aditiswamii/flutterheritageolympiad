import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:CultreApp/colors/colors.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DialogEmailResend(),
  ));
}
class DialogEmailResend extends StatefulWidget{
  const DialogEmailResend({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<DialogEmailResend> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          height:250,
          width: 250,
          alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(20,20,20,20),
            padding: EdgeInsets.all(10),
            child:Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin:EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color:Colors.white
                    ),
                    child: Text('We have resent the\nverification link!',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize: 24 ),)
                ),
                Container(margin:EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    child: TextButton(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('RESEND',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15,color: ColorConstants.txt,decoration: TextDecoration.underline)),
                          TweenAnimationBuilder<Duration>(
                              duration: Duration(seconds:30),
                              tween: Tween(begin: Duration(seconds:30), end: Duration.zero),
                              onEnd: () {
                                Navigator.of(context).pop();
                              },
                              builder: (BuildContext context, Duration value, Widget? child) {
                                final minutes = value.inMinutes;
                                final seconds = value.inSeconds % 60;
                                return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text('(${seconds}S)',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontSize:15)));
                              }),
                        ],
                      ),
                      onPressed: () {  },)),
              ],
            )
        )
    );
  }
}
