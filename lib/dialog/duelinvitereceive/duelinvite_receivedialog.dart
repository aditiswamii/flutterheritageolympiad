import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/ui/homepage/homeview.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;

import '../../ui/rules/rulepage.dart';
import '../../utils/StringConstants.dart';

class DialogDuelInviteReceive extends StatefulWidget{
  var name;
  var diffi;
  var domainsel;
  var speed;
  var id;
  var image;
  var index;
  var link;
  DialogDuelInviteView? view;
  DialogDuelInviteReceive({Key? key,required this.id,required this.name,required this.image,
    required this.diffi,required this.domainsel,required this.speed,required this.link,required this.index,this.view}) : super(key: key);
  // listener(int type,int index,String quizid) {
  //
  // }
  @override
  _State createState() => _State();
}

abstract class DialogDuelInviteView{
  void setDData(int type,int index,String quizid);

}
class _State extends State<DialogDuelInviteReceive> {

  var diffi;
  var speed;
  var domainsel;
 var username;
 var country;
 var userid;
 var data;
 var snackBar;

  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country =prefs.getString("country");
      userid= prefs.getString("userid");
    });
    diffi=widget.diffi;
    speed=widget.speed;
    domainsel=widget.domainsel;
  }
  acceptdual(String userid,String link,index,type) async {

    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL + "accept_invitation"), body: {
      'user_id': userid.toString(),
      'dual_link':link.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {

      if (jsonResponse['status'] == 200) {
        print(jsonResponse.toString());
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>  RulesPage(quizspeedid:"", quiztypeid:"", quizid: jsonResponse['data'].toString(), type: "2", tourid: 0, sessionid: 0 ,)));

        //  widget.view!.setDData(type,index,widget.id.toString());
       // Navigator.pop(context);
      }
      else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);

      print(response.statusCode);
    }

  }
  rejectdual(String userid,String link,index,type) async {

    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL + "reject_invitation"), body: {
      'user_id': userid.toString(),
      'dual_link':link.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {

      if (jsonResponse['status'] == 200) {
       // widget.view!.setDData(type,index,widget.id.toString());
        Navigator.pop(context);
      }
      else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
        Navigator.pop(context);
      }
    } else {

      print(response.statusCode);
      Navigator.pop(context);
    }

  }
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  void initState() {
    super.initState();

    userdata();

  }
  @override
  void dispose() {
    // Navigator.pop(context);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body:Container(
           height:450,
          // width: 250,
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0,10,0,10),
            padding: EdgeInsets.all(10),
            child:ListView(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin:EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color:Colors.white
                    ),
                    child: Text('Duel Invite Received from',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize:16 ,fontWeight: FontWeight.w600),)
                ),
                Container(
                    alignment: Alignment.center,
                    margin:EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color:Colors.white
                    ),
                    child: Text(widget.name.toString(),textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize: 16 ),)
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                        NetworkImage(widget.image.toString()),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "QUIZ SUMMARY",
                    style: TextStyle(
                        color: ColorConstants.txt, fontSize: 14,fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                   margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      // if you need this
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child:
                    Column(
                      children: [
                        Container(
                           margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            children: [
                              Text(
                                "DIFFICULTY:",
                                style: TextStyle(
                                    color:  ColorConstants.txt,
                                    fontSize: 12,fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "$diffi",
                                style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 12),
                              ),
                            ],
                          ),

                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Row(

                            children: [
                              Text(
                                "SPEED:",
                                style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 12,fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "$speed",
                                style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 12),
                              ),
                            ],
                          ),

                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                           margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "DOMAINS SELECTED:",textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 12,fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "$domainsel",textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: ColorConstants.txt,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
            Container(
               margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ColorConstants.red,
                      onPrimary: Colors.white,
                      elevation: 3,
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      fixedSize: const Size(100, 30),
                      //////// HERE
                    ),
                    onPressed: () {
                      rejectdual(userid.toString(), widget.link, widget.index, 2);

                    },
                    child: const Text(
                      "REJECT",
                      style: TextStyle(
                          color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
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
                      fixedSize: const Size(100, 30),
                      //////// HERE
                    ),
                    onPressed: () {
                      acceptdual(userid.toString(), widget.link, widget.index, 1);

                    },
                    child: const Text(
                      "ACCEPT",
                      style: TextStyle(
                          color: Colors.white, fontSize:14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
              ],
            )
        )
    );
  }
}
