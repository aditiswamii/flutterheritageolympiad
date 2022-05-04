import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/myaccount/payment/payment_screen.dart';


class DialogDispute extends StatefulWidget{
  const DialogDispute({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<DialogDispute> {
  TextEditingController descripcontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,

              ),
              // height:250,
              // width: 250,
              alignment: Alignment.center,
              //margin: EdgeInsets.fromLTRB(0,10,0,10),

              child:Column(
                children: [
                  Text('Raise a dispute',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize:18 ),),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.black54)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.black54)),
                          border: InputBorder.none,
                        ),
                        controller: descripcontroller //this is your text
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ColorConstants.verdigris,
                      onPrimary: Colors.white,
                      elevation: 3,
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      fixedSize: const Size(100, 40),
                      //////// HERE
                    ),
                    onPressed: () {

                    },
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(
                          color: ColorConstants.lightgrey200, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
}
