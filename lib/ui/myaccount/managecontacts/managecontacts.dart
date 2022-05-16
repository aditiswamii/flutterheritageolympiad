import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/duelinvitesent/duelinvite_dialog.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/StringConstants.dart';

class ManageContactScreen extends StatefulWidget{

  const ManageContactScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<ManageContactScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();


  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var data;
  var roomdata;



  var duelresultr;
  // GetTourRoomlist? getTourRoomlistt;

  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    print("userdata");
    //calTheme();

    //getTourRoom(widget.tourid, widget.sessionid);
    getUserlist(userid.toString());
    // getFeed(userid.toString(), "0", "", "", "");
  }

  getUserlist(String userid) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "get_all_contacts"),
        body: {'user_id': userid.toString()});
    showLoaderDialog(context);

    print("getTourRoomapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        roomdata = jsonResponse[
        'data']; //get all the data from json string superheros
        print("length" + roomdata.length.toString());
       // onsuccess(jsonResponse);
       //  onsuccess(getTourRoomlistFromJson(data));
      } else {
        // onsuccess(null);
        log(jsonResponse['message']);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  // onsuccess(GetTourRoomlist? tourRoomlistn) {
  //   log("log" + tourRoomlistn.toString());
  //   if (tourRoomlistn != null) {
  //     setState(() {
  //       getTourRoomlistt = tourRoomlistn;
  //     });
  //     print("getdueljsonsuccess" + getTourRoomlistt.toString());
  //
  //   }
  // }

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
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => MyAccountPage()));
    // Do some stuff.
    return true;
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomePage()));
                        },
                        child: Image.asset(
                            "assets/images/home_1.png", height: 40, width: 40),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                        child: Image.asset(
                            "assets/images/side_menu_2.png", height: 40,
                            width: 40),
                      ),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                    child: const Text("YOUR CONTACTS", style: TextStyle(
                        fontSize: 24, color: ColorConstants.txt))),

                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                      "You have 50 contacts.You may remove,",
                      style: TextStyle(fontSize: 15,
                          color: ColorConstants.txt)
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                          "block them,and unblock contacts ",
                          style: TextStyle(fontSize: 15,
                              color: ColorConstants.txt)
                      ),
                      Text(
                          "here.",
                          style: TextStyle(fontSize: 15,decoration: TextDecoration.underline,
                              color: ColorConstants.txt)
                      ),
                    ],
                  ),
                ),
     Container(
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: ListView.builder(
    physics: ClampingScrollPhysics(
    parent: BouncingScrollPhysics()),
    shrinkWrap: true,
    itemCount: jsonDecode(data!)['data'].length,
    itemBuilder: (BuildContext context, int index) {
    return Container(
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
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 120,
                                width: 120,
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage:
                                  AssetImage("assets/images/cat1.png"),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              // Image.asset("assets/profile.png",height: 100,width: 100,),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
                                child: Column(
                                  children: [
                                    Text("EUNGEUNG519",style: TextStyle(
                                        color: ColorConstants.txt,
                                        fontSize: 14),
                                      textAlign: TextAlign.center,),
                                    Row(
                                      children: [
                                        Text("GROUP 3",style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontSize: 14),
                                          textAlign: TextAlign.center,),
                                        Divider(height: 10,thickness: 1,color: ColorConstants.txt,),
                                        Text("|"),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/india.png",
                                              width: 10,
                                              height: 10,
                                            ),
                                            Text("INDIA",style: TextStyle(
                                                color: ColorConstants.txt,
                                                fontSize: 14),
                                              textAlign: TextAlign.center,),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "AVAILABLE",
                                      style: TextStyle(
                                          color: ColorConstants.verdigris),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: ColorConstants.yellow200,
                                        onPrimary: Colors.white,
                                        elevation: 3,
                                        alignment: Alignment.center,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30.0)),
                                        fixedSize: const Size(100, 40),
                                        //////// HERE
                                      ),
                                      onPressed: () {
                                        AlertDialog errorDialog = AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20.0)), //this right here
                                            title: Container(
                                                height: 250,
                                                width: 250,
                                                alignment: Alignment.center,
                                                child: DialogDuelInviteSent()));
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                            errorDialog);
                                      },
                                      child: const Text(
                                        "SEND INVITE",
                                        style: TextStyle(
                                            color: ColorConstants.lightgrey200,
                                            fontSize: 14),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );}
                  )
    ),
                Container(
                  alignment: FractionalOffset.bottomCenter,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyAccountPage()));
                        },
                        child: const Text(
                          "GO BACK",
                          style: TextStyle(
                              color: ColorConstants.lightgrey200, fontSize: 14),
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
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (
                          //             context) => const PhonebookScreen()));
                        },
                        child: const Text(
                          "LET'S GO!",
                          style: TextStyle(
                              color: ColorConstants.lightgrey200, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

              ]
          ),
        ),
      ),
    );
  }
}

