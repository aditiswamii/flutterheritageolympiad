import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/myaccount/payment/payment_screen.dart';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DialogDispute extends StatefulWidget{
  var type;
  var quizid;
 DialogDispute({Key? key,required this.type,required this.quizid}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<DialogDispute> {
  TextEditingController descripcontroller= TextEditingController();
  var data;
  var raisedata;
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
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
    Navigator.pop(context);
    return true;
  }
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
  }
  void raisedispute(String user_id,String type,String dispute,String tourid,String seesionid,String quizid) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+"raise_dispute"), body: {
      'user_id': user_id.toString(),
      'type': type.toString(),
      if(widget.type=="4")
        "tournament_id" : tourid.toString(),
        "session_id": seesionid.toString(),
      if(widget.type == "1")
        "quiz_id": quizid.toString(),
      'dispute':dispute.toString()
    });
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        raisedata = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(raisedata.length); // just printed length of data
      });

      var venam = jsonDecode(data!)['data'];
      print(venam);
    } else {
      print(response.statusCode);
    }
  }

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
                      if(descripcontroller.text.isNotEmpty){
                        raisedispute(userid.toString(), widget.type, descripcontroller.text.toString(), "", "",
                            widget.quizid);

                      }else{
                       var snackbar = SnackBar(
                            content: Text(
                             "Please submit your dispute",
                              textAlign: TextAlign.center,));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackbar);
                      }
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
