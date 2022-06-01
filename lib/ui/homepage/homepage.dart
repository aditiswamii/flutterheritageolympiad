
import 'dart:convert';
import 'dart:developer';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/contactinvitereceive/contactinvitereceive.dart';
import 'package:flutterheritageolympiad/modal/getuserleagueresponse/GetUserLeagueResponse.dart';

import 'package:flutterheritageolympiad/ui/feed/feed.dart';
import 'package:flutterheritageolympiad/ui/homepage/homeview.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/quizroom/waitroom/waitroom.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
import 'package:flutterheritageolympiad/utils/SharedObjects.dart';
import 'package:flutterheritageolympiad/utils/apppreference.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';


import '../../dialog/duelinvitereceive/duelinvite_receivedialog.dart';
import '../../dialog/duelinvitereceive/duelinvite_receivedialog.dart';
import '../../dialog/quizroominvitereceive/quizroominvite_receivedialog.dart';
import '../../utils/StringConstants.dart';

import '../classicquiz/result/result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../rules/rulepage.dart';
import '../tournamentquiz/tournament_quiz.dart';
import '../tournamentquiz/waitlist/waitlist.dart';

class HomePage extends StatefulWidget{
var link;
  HomePage({Key? key, this.link}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<HomePage> implements DialogDuelInviteView,DialogQuizRoomInviteView{
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
var username;
var email;
var country;
var profilepic;
var userid;
var data;
var userleagdata;
var snackBar;
var myinvdata;
  var   tournament;
  List?  contact ;
  List?  dual;
  List?  accept;
  List?   quizroom;
  List?  quizroom_start;
  var shortlink;
  var linkurl;
GetUserLeagueResponse? userLeagueR;


// broadfun(){
//   FBroadcast.instance().register(Key_Message, (value, callback) {
//     var data = value;
//   });     ///Register The Receiver
//
//   FBroadcast.instance().broadcast(
//     "Key_Message",
//     value: myController.text,
//   ); ///Sending The Broadcast
//
//   //FBroadcast.instance().unregister(this); ///Close The Receiver ondispose
//
//   //FBroadcast.instance().stickyBroadcast(
//   //   Key_Message,
//   //   value: data,
//   // );
// }


 userdata() async {
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
     username = prefs.getString("username");
     country =prefs.getString("country");
     userid= prefs.getString("userid");
   });
   free(userid.toString());
   getuserleague(userid.toString());
   linkurl=widget.link;
   if(linkurl!="" ||linkurl.toString().isNotEmpty) {
     setState(() {
       shortlink = linkurl.toString().substring(18);
     });
     shortlink = linkurl.toString().substring(18);
   //            linkshort = linkurl.substring(22)!!
               log("shortlink: "+ shortlink);
               if(shortlink.toString().contains("invite")) {
                 linkdetails(userid.toString(),shortlink.toString());
               } else if(shortlink.toString().contains("quizroom")){
                   log("shortlink: "+shortlink);
                   quizroomdetail(userid.toString(), shortlink.toString());
               } else {
                  dualdetails(userid.toString(), shortlink.toString());
               }

           } else {
                 myinvitation(userid.toString());
           }
   if(widget.link!=""){

   }


}
  free(String userid) async {

    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL + "free"), body: {
      'user_id': userid.toString(),
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {

      if (jsonResponse['status'] == 200) {




      } else {

      }
    } else {

      print(response.statusCode);
    }

  }
  // showLoaderDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     content: new Row(
  //       children: [
  //         CircularProgressIndicator(),
  //         Container(
  //             margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
  //       ],
  //     ),
  //   );
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
  myinvitation(String userid) async {
    // showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL + "dashboard"), body: {
      'user_id': userid.toString(),
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          myinvdata = jsonResponse; //get all the data from json string superheros
          print(myinvdata.length);
          print(myinvdata.toString());
        });
        onsuccess(myinvdata);
        // var venam = jsonDecode(data!)['data'];
        // print(venam);
        //last_id

      } else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      // Navigator.pop(context);
      print(response.statusCode);
    }

  }
  onsuccess(myinvdata){
  if(myinvdata!=null){
    tournament=myinvdata['data']['tournament'];
    dual=List.from(myinvdata['data']['dual']);
    quizroom=List.from(myinvdata['data']['quizroom']);
    contact=List.from(myinvdata['data']['contact']);
    accept=List.from(myinvdata['data']['accept']);
    quizroom_start=List.from(myinvdata['data']['accept']);
setState(() {
  tournament=myinvdata['data']['tournament'];
  dual=List.from(myinvdata['data']['dual']);
  quizroom=List.from(myinvdata['data']['quizroom']);
  contact=List.from(myinvdata['data']['contact']);
  accept=List.from(myinvdata['data']['accept']);
  quizroom_start=List.from(myinvdata['data']['accept']);

});
if(tournament!=null && tournament['tournament_id']>0){
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>  TourRoomWaitlist(sessionid: tournament['session_id'], tourid: tournament['tournament_id'],)));
}
 else  if(quizroom_start!=null && quizroom_start!.length>0){
     Navigator.pushReplacement(
         context,
         MaterialPageRoute(
             builder: (context) =>  RulesPage(quizspeedid:"", quiztypeid:"", quizid: accept![0]['id'], type: "3", tourid: 0, sessionid: 0 ,)));

   }else if(accept!=null && accept!.length>0){
     Navigator.pushReplacement(
         context,
         MaterialPageRoute(
             builder: (context) =>  RulesPage(quizspeedid:"", quiztypeid:"", quizid: accept![0]['id'], type: "2", tourid: 0, sessionid: 0 ,)));

   }else  if(dual!=null && dual!.length>0){
     AlertDialog errorDialog = AlertDialog(
         insetPadding: EdgeInsets.all(4),
         titlePadding: EdgeInsets.all(4),
         contentPadding:EdgeInsets.all(4),
         shape: RoundedRectangleBorder(
             borderRadius:
             BorderRadius.circular(
                 20.0)), //this right here
         content: Container(
             height:470,
             width: 250,
             alignment: Alignment.center,
             child: DialogDuelInviteReceive(id: dual![0]['dual_id'], image: dual![0]['image'], diffi: dual![0]['difficulty'], index: 0,
               domainsel:  dual![0]['domain'], link: dual![0]['link'], speed: dual![0]['quiz_speed'], name: dual![0]['name'],)));
     showDialog(
         context: context,
         builder: (BuildContext context){
           // Future.delayed(
           //   Duration(seconds: 2),
           //       () {
           //     Navigator.of(context).pop(true);
           //   },
           // );
           return  errorDialog;
         }
     );

   }else if(quizroom!=null && quizroom!.length>0){
      AlertDialog errorDialog = AlertDialog(
          insetPadding: EdgeInsets.all(4),
          titlePadding: EdgeInsets.all(4),
          contentPadding:EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                  20.0)), //this right here
          content: Container(
              height:470,
              width: 250,
              alignment: Alignment.center,
              child: DialogQuizRoomInviteReceive(id: quizroom![0]['quiz_room_id'], image: quizroom![0]['image'], diffi: quizroom![0]['difficulty'], index: 0,
                domainsel:  quizroom![0]['domain'], link: quizroom![0]['link'], speed: quizroom![0]['quiz_speed'], name: quizroom![0]['name'],)));
      showDialog(
          context: context,
          builder: (BuildContext context){
            // Future.delayed(
            //   Duration(seconds: 2),
            //       () {
            //     Navigator.of(context).pop(true);
            //   },
            // );
            return  errorDialog;
          }
      );

    }else if(contact!=null && contact!.length>0){
      AlertDialog errorDialog = AlertDialog(
        insetPadding: EdgeInsets.all(4),
        titlePadding: EdgeInsets.all(4),
        contentPadding: EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
                20.0)),
        //this right here
        content: Container(
            height:250,
            // width: 250,
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0,10,0,10),
            padding: EdgeInsets.all(10),
            child:ListView(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin:const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                        color:Colors.white
                    ),
                    child: const Text('Contact Invitation Received From',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize:18 ,fontWeight: FontWeight.w600),)
                ),
                Container(
                    alignment: Alignment.center,
                    margin:const EdgeInsets.only(bottom: 10),
                    decoration:const  BoxDecoration(
                        color:Colors.white
                    ),
                    child: Text(contact![0]['name'].toString(),textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize: 18 ),)
                ),
                Container(
                  padding:const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 100,
                  width: 100,
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                        NetworkImage(contact![0]['image'].toString()),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                          fixedSize: const Size(100, 40),
                          //////// HERE
                        ),
                        onPressed: () {
                          rejectcontact(userid.toString(), contact![0]['link'].toString(), 0, 2);
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
                          fixedSize: const Size(100, 40),
                          //////// HERE
                        ),
                        onPressed: () {
                          acceptcontact(userid.toString(), contact![0]['link'].toString(), 0, 1);
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
        ),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // Future.delayed(
            //   Duration(seconds: 2),
            //       () {
            //     Navigator.of(context).pop(true);
            //   },
            // );
            return errorDialog;
          }
      );
    }

  }
  }
  var linkdata;
  linkdetails(String userid,String link) async {
   // showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL + "link_details"), body: {
      'user_id': userid.toString(),
      'link':link.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
    //  Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          linkdata = jsonResponse; //get all the data from json string superheros
          print(linkdata.length);
          print(linkdata.toString());
        });
        onlinkdetail(linkdata);
        // var venam = jsonDecode(data!)['data'];
        // print(venam);
        //last_id

      } else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      //Navigator.pop(context);
      print(response.statusCode);
    }

  }

  acceptcontact(String userid,String link,index,type) async {
    //showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL + "accept_link_invitation"), body: {
      'user_id': userid.toString(),
      'link':link.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
     // Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        setData(type,index);
      } else  if (jsonResponse['status'] == 201) {
        setData(type,index);
      }
      else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
     // Navigator.pop(context);
      print(response.statusCode);
    }

  }
  rejectcontact(String userid,String link,index,type) async {
    //showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL + "reject_link_invitation"), body: {
      'user_id': userid.toString(),
      'link':link.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
     // Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        setData(type,index);
      }
      else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
    //  Navigator.pop(context);
      print(response.statusCode);
    }

  }
  setData(int type,int index){
    if(type==1){
      snackBar = SnackBar(
        content: Text(
            "Contact added"),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);

    } else {
      snackBar = SnackBar(
        content: Text(
            "Request rejected"),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
    }
    if(contact!=null && contact!.length>index+1){
      AlertDialog errorDialog = AlertDialog(
        insetPadding: EdgeInsets.all(4),
        titlePadding: EdgeInsets.all(4),
        contentPadding: EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
                20.0)),
        //this right here
        content: Container(
            height:250,
            // width: 250,
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0,10,0,10),
            padding: EdgeInsets.all(10),
            child:ListView(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin:const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                        color:Colors.white
                    ),
                    child: const Text('Contact Invitation Received From',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize:18 ,fontWeight: FontWeight.w600),)
                ),
                Container(
                    alignment: Alignment.center,
                    margin:const EdgeInsets.only(bottom: 10),
                    decoration:const  BoxDecoration(
                        color:Colors.white
                    ),
                    child: Text(contact![index+1]['name'].toString(),textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize: 18 ),)
                ),
                Container(
                  padding:const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 100,
                  width: 100,
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                        NetworkImage(contact![index+1]['image'].toString()),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                          fixedSize: const Size(100, 40),
                          //////// HERE
                        ),
                        onPressed: () {
                           rejectcontact(userid.toString(), contact![index+1]['link'].toString(), index+1, 2);
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
                          fixedSize: const Size(100, 40),
                          //////// HERE
                        ),
                        onPressed: () {
                          acceptcontact(userid.toString(), contact![index+1]['link'].toString(), index+1, 1);
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
        ),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // Future.delayed(
            //   Duration(seconds: 2),
            //       () {
            //     Navigator.of(context).pop(true);
            //   },
            // );
            return errorDialog;
          }
      );
    }

  }
  onlinkdetail(linkdata){

    if(linkdata!=null) {
      log(linkdata['data']['id'].toString());
      log(linkdata['data']['name']);
      log(linkdata['data']['image']);
      log(linkdata['data']['link']);
      log(linkdata['type'].toString());
      AlertDialog errorDialog = AlertDialog(
          insetPadding: EdgeInsets.all(4),
          titlePadding: EdgeInsets.all(4),
          contentPadding: EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                  20.0)),
          //this right here
          content: Container(
                      height:250,
                      // width: 250,
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(0,10,0,10),
                      padding: EdgeInsets.all(10),
                      child:ListView(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin:const EdgeInsets.only(bottom: 10),
                              decoration: const BoxDecoration(
                                  color:Colors.white
                              ),
                              child: const Text('Contact Invitation Received From',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize:18 ,fontWeight: FontWeight.w600),)
                          ),
                          Container(
                              alignment: Alignment.center,
                              margin:const EdgeInsets.only(bottom: 10),
                              decoration:const  BoxDecoration(
                                  color:Colors.white
                              ),
                              child: Text(linkdata['data']['name'].toString(),textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize: 18 ),)
                          ),
                          Container(
                            padding:const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            height: 100,
                            width: 100,
                            child: Center(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage:
                                  NetworkImage(linkdata['data']['image'].toString()),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                                    fixedSize: const Size(100, 40),
                                    //////// HERE
                                  ),
                                  onPressed: () {
                                     rejectcontact(userid.toString(), linkdata['data']['link'].toString(), 0, 2);
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
                                    fixedSize: const Size(100, 40),
                                    //////// HERE
                                  ),
                                  onPressed: () {
                                    acceptcontact(userid.toString(), linkdata['data']['link'].toString(), 0, 1);
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
                  ),
                );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // Future.delayed(
            //   Duration(seconds: 2),
            //       () {
            //     Navigator.of(context).pop(true);
            //   },
            // );
            return errorDialog;
          }
      );
    }else{
      myinvitation(userid.toString());
    }
  }
  var dualinkdata;
  dualdetails(String userid,String link) async {
    //showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL + "dualdetails"), body: {
      'user_id': userid.toString(),
      'dual_link':link.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
     // Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          dualinkdata = jsonResponse; //get all the data from json string superheros
          print(dualinkdata.length);
          print(dualinkdata.toString());
        });
        onduallinkdetail(dualinkdata);
        // var venam = jsonDecode(data!)['data'];
        // print(venam);
        //last_id

      } else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
     // Navigator.pop(context);
      print(response.statusCode);
    }

  }
  onduallinkdetail(dualinkdata){
    log(dualinkdata['data']['dual_id'].toString());
    log(dualinkdata['data']['domain']);
    log(dualinkdata['data']['quiz_speed']);
    log(dualinkdata['data']['difficulty']);
    log(dualinkdata['data']['link']);
    log(dualinkdata['data']['created_date']);
    // log(linkdata['type'].toString());

  }
  var quizroomdata;
  quizroomdetail(String userid,String link) async {
    //showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL + "dualdetails"), body: {
      'user_id': userid.toString(),
      'link':link.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
     // Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          quizroomdata = jsonResponse; //get all the data from json string superheros
          print(quizroomdata.length);
          print(quizroomdata.toString());
        });
        onquizroomlinkdetail(quizroomdata);
        // var venam = jsonDecode(data!)['data'];
        // print(venam);
        //last_id

      } else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
   //   Navigator.pop(context);
      print(response.statusCode);
    }

  }
  onquizroomlinkdetail(quizroomdata){
    log(quizroomdata['data']['dual_id'].toString());
    log(quizroomdata['data']['domain']);
    log(quizroomdata['data']['quiz_speed']);
    log(quizroomdata['data']['difficulty']);
    log(quizroomdata['data']['link']);
    log(quizroomdata['data']['created_date']);
    log(quizroomdata['type']);

  }
  getuserleague(String userid) async {
    //showLoaderDialog(context);
    http.Response response = await http.get(
        Uri.parse(StringConstants.BASE_URL+"userleague?user_id=$userid")
    );


    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
     // Navigator.pop(context);
      data = response.body;

      if (jsonResponse['status'] == 200) {
        setState(() {
          userleagdata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(userleagdata.length);
        });
        getuserleagueresponse(getUserLeagueResponseFromJson(data!));
        // var venam = userleagdata(data!)['data'];
        // print(venam.toString());
      } else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
     // Navigator.pop(context);
      // onsuccess(null);
      print(response.statusCode);
    }

  }
  getuserleagueresponse(GetUserLeagueResponse userLeagueResponse){
   if(userLeagueResponse.data!=null){
     setState(() {
       userLeagueR=userLeagueResponse;
     });
   }

  }

  @override
  void initState() {
   // log("link"+ link == null ? "" : link);
    super.initState();
    userdata();
  }
  Future<Future> _refreshdata(BuildContext context) async {
    return myinvitation(userid.toString());
  }
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      body:Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/debackground.jpg"),
          fit: BoxFit.cover,
    ),
    ),
        //  child:
        // RefreshIndicator(
        // onRefresh: () => _refreshdata(context),
     child:RefreshIndicator(
       color: Colors.transparent,
     onRefresh: () => _refreshdata(context),
      child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView(
      children: [

        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 5.0),
          child: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            child:  Image.asset("assets/images/side_menu_2.png",height: 40,width: 40),
          ),
        ),
        Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
            child: const Text("WELCOME BACK,",style: TextStyle(fontSize: 24,color: ColorConstants.txt,fontFamily: "Nunito"))),
        Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: username==null?Text(""):Text("${username[0].toUpperCase()+username.substring(1)}",style: TextStyle(fontSize: 24,color: ColorConstants.txt,fontFamily: "Nunito"))),

         Container(
           child:GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
               shrinkWrap: true,
               physics: ClampingScrollPhysics(parent: BouncingScrollPhysics()),

               children: [
                 GestureDetector(
                   onTap:(){
                     Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(
                             builder: (context) => MyAccountPage()));
                   },
                   child: Container(
                     height: 150,
                     width: 150,
                     color: ColorConstants.red200,

                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           padding: EdgeInsets.all(10),
                           alignment: Alignment.topRight,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topRight),
                         ),
                         Container(child: Text("MY\nACCOUNT",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,)),
                         Container(
                           padding: EdgeInsets.all(10),
                           alignment: Alignment.topLeft,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topLeft),
                         ),
                       ],
                     ),

                   ),
                 ),
                 GestureDetector(
                   onTap: (){
                     Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(
                             builder: (context) => FeedPage(contents: "", seldomain: "", themes: "",)));
                   },
                   child: Container(
                     height: 150,
                     width: 150,
                     color:ColorConstants.yellow200,

                     child:  Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           padding: EdgeInsets.all(10),
                           alignment: Alignment.topLeft,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topLeft),
                         ),
                         Container(child: Text("MY\nFEED",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,)),
                         Container(
                           padding: EdgeInsets.all(10),
                           alignment: Alignment.topRight,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topRight),
                         ),
                       ],
                     ),

                   ),
                 ),
                 GestureDetector(
                   onTap: () {
                     Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(
                             builder: (context) =>  QuizPage()));
                   },
                   child: Container(
                     height: 150,
                     width: 150,
                     color: ColorConstants.blue200,

                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           padding: EdgeInsets.all(10),
                           alignment: Alignment.topRight,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topRight),
                         ),
                         Container(child: Text("TO THE\nQUIZZES",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,)),
                         Container(
                           padding: EdgeInsets.all(10),
                           alignment: Alignment.topLeft,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topLeft),
                         ),
                       ],
                     ),

                   ),
                 ),
                 GestureDetector(
                   onTap: () {
                     // Navigator.pushReplacement(
                     //     context,
                     //     MaterialPageRoute(
                     //         builder: (context) => ResultPage(quizid: "1339", savedata: null, )));
                     Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(
                             builder: (context) => ShopPage()));
                   },
                   child: Container(
                     height: 150,
                     width: 150,
                     color: Colors.black26,

                     child:  Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           padding: EdgeInsets.all(10),
                           alignment: Alignment.topLeft,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topLeft),
                         ),
                         Container(child: Text("TO THE\nSHOP",style: TextStyle(color: Colors.black54,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,)),
                         Container(
                           padding: EdgeInsets.all(10),
                           alignment: Alignment.topCenter,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topCenter),
                         ),
                       ],
                     ),

                   ),
                 ),
                 ]
           )


         ),




        userLeagueR!=null?  Container(
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
          child: Container( margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child:userLeagueR!.data!.goalsummery==null?Container(child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text("Your Activity Summary",
                      style: TextStyle(color: ColorConstants.txt,fontSize: 12),textAlign: TextAlign.center,),
                  ),


                    Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: GFProgressBar(
                          percentage:0.0,
                          lineHeight: 20,
                          alignment: MainAxisAlignment.spaceBetween,
                          backgroundColor: Colors.black12,
                          progressBarColor: Colors.black12,
                        )
                    ),


                  Container(
                    child: Text("Quizzes Done",
                      style: TextStyle(color: Colors.grey,fontSize: 12),textAlign: TextAlign.center,),
                  ),
                ]
            ),): Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text("Your Activity Summary",
                    style: TextStyle(color: ColorConstants.txt,fontSize: 12),textAlign: TextAlign.center,),
                ),

                if((userLeagueR!.data!.goalsummery!.play!/userLeagueR!.data!.goalsummery!.total!)<1)
                Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: GFProgressBar(
                      percentage:
                      (userLeagueR!.data!.goalsummery!.play!/userLeagueR!.data!.goalsummery!.total!)*(0.3).toDouble(),
                      lineHeight: 20,
                      alignment: MainAxisAlignment.spaceBetween,
                      child: Text('${userLeagueR!.data!.goalsummery!.play!} out of ${userLeagueR!.data!.goalsummery!.total}', textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      backgroundColor: Colors.black12,
                      progressBarColor: ColorConstants.verdigris,
                    )
                ),

                if((userLeagueR!.data!.goalsummery!.play!*100/userLeagueR!.data!.goalsummery!.total!)>=1)
                Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: GFProgressBar(
                      percentage:1.0,
                      lineHeight: 20,
                      alignment: MainAxisAlignment.spaceBetween,
                      child: Text('${userLeagueR!.data!.goalsummery!.play!} out of ${userLeagueR!.data!.goalsummery!.total}', textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      backgroundColor: Colors.black12,
                      progressBarColor: ColorConstants.verdigris,
                    )
                ),

                Container(
                  child: Text("Quizzes Done",
                    style: TextStyle(color: Colors.grey,fontSize: 12),textAlign: TextAlign.center,),
                ),
        ]
      ),
          ),
        ),
      ):Container(),
        ]
        ),
        ),
    ),
    ),
    );
  }

  @override
  void setDData(int type, int index,String quizid) {
    if(type == 1){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>  RulesPage(quizspeedid:"", quiztypeid:"", quizid: quizid, type: "2", tourid: 0, sessionid: 0 ,)));

    }else
      snackBar = SnackBar(
        content: Text(
           "Rejected Successfully"),
      );
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar);
      if(dual!=null && dual!.length>index+1){
      AlertDialog errorDialog = AlertDialog(
          insetPadding: EdgeInsets.all(4),
          titlePadding: EdgeInsets.all(4),
          contentPadding:EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                  20.0)), //this right here
          content: Container(
              height:470,
              width: 250,
              alignment: Alignment.center,
              child: DialogDuelInviteReceive(id: dual![index+1]['dual_id'], image: dual![index+1]['image'], diffi: dual![index+1]['difficulty'], index: index+1,
                domainsel:  dual![index+1]['domain'], link: dual![index+1]['link'], speed: dual![index+1]['quiz_speed'], name: dual![index+1]['name'],)));
      showDialog(
          context: context,
          builder: (BuildContext context){
            // Future.delayed(
            //   Duration(seconds: 2),
            //       () {
            //     Navigator.of(context).pop(true);
            //   },
            // );
            return  errorDialog;
          }
      );

    }
  }

  @override
  void setRData(int type, int index, String quizid) {
    if(type == 1){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>  Waitroom(quizid: quizid,)));

    }else
      snackBar = SnackBar(
        content: Text(
            "Rejected Successfully"),
      );
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar);
    if(quizroom!=null && quizroom!.length>index+1){
      AlertDialog errorDialog = AlertDialog(
          insetPadding: EdgeInsets.all(4),
          titlePadding: EdgeInsets.all(4),
          contentPadding:EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                  20.0)), //this right here
          content: Container(
              height:470,
              width: 250,
              alignment: Alignment.center,
              child: DialogQuizRoomInviteReceive(id: quizroom![index+1]['quiz_room_id'], image: quizroom![index+1]['image'], diffi: quizroom![index+1]['difficulty'], index: index+1,
                domainsel:  quizroom![index+1]['domain'], link: quizroom![index+1]['link'], speed: quizroom![index+1]['quiz_speed'], name: quizroom![index+1]['name'],)));
      showDialog(
          context: context,
          builder: (BuildContext context){
            // Future.delayed(
            //   Duration(seconds: 2),
            //       () {
            //     Navigator.of(context).pop(true);
            //   },
            // );
            return  errorDialog;
          }
      );

    }
  }




}
