import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/duelinvitesent/duelinvite_dialog.dart';
import 'package:flutterheritageolympiad/modal/getcontactlist/GetContactUserlist.dart';
import 'package:flutterheritageolympiad/ui/myaccount/managecontacts/managecontacts.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/homepage/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/StringConstants.dart';



class BlockContactScreen extends StatefulWidget{

  const BlockContactScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<BlockContactScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();


  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var data;
  var blockdata;
  var unblockdata;



  var duelresultr;
  var contactlist;
 var snackBar;
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
    getBlockUserlist(userid.toString());
    // getFeed(userid.toString(), "0", "", "", "");
  }

  getBlockUserlist(String userid) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "get_block_user"),
        body: {'user_id': userid.toString()});
    showLoaderDialog(context);

    print("getBlocklistapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        blockdata = jsonResponse[
        'data'];
        print("data" + blockdata.toString());
        setState(() {
          blockdata = jsonResponse[
          'data'];
        });
        //get all the data from json string superheros
        print("length" + blockdata.length.toString());
        // onsuccess(jsonResponse);
      } else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
        // onsuccess(null);
        log(jsonResponse['message']);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }
  unblockApi(String userid,String blockid) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "unblockuser"),
        body: {
          'user_id': userid.toString(),
          'block_id': blockid.toString(),
        });
    showLoaderDialog(context);

    print("getunBlocklistapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        unblockdata = jsonResponse[
        'data'];
        print("data" + unblockdata.toString());
        setState(() {
          blockdata = jsonResponse[
          'data'];
        });
        //get all the data from json string superheros
        print("length" + unblockdata.length.toString());
        // onsuccess(jsonResponse);
      } else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
        // onsuccess(null);
        log(jsonResponse['message']);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
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
                                  builder: (context) =>  WelcomePage()));
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
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: const Text("BLOCKED USERS", style: TextStyle(
                        fontSize: 24, color: ColorConstants.txt))),

                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                    child: Text(
                        "Unblocked users can invite you to quiz and see your profile",
                        style: TextStyle(fontSize: 15,
                            color: ColorConstants.txt)
                    ),
                  ),
                ),
                blockdata==null?Container(): Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: blockdata.length,
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
                                        if(blockdata[index]['image']!="")
                                          Container(
                                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                            height: 90,
                                            width: 90,
                                            child:
                                            CircleAvatar(
                                              radius: 30.0,
                                              backgroundImage:
                                              NetworkImage("${blockdata[index]['image']}"),
                                              backgroundColor: Colors.transparent,
                                            ),
                                          ),
                                        if(blockdata[index]['image']=="")
                                          Container(
                                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                            height: 90,
                                            width: 90,
                                            child:
                                            CircleAvatar(
                                              radius: 30.0,
                                              backgroundImage:AssetImage("assets/images/placeholder.png"),
                                              backgroundColor: Colors.transparent,
                                            ),
                                          ),
                                        // Image.asset("assets/profile.png",height: 100,width: 100,),
                                        Container(
                                          width: 150,
                                          margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
                                          child: Column(
                                            children: [
                                              Container(alignment: Alignment.centerLeft,
                                                child: Text("${blockdata[index]['name']}",style: TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 16,fontWeight: FontWeight.w600),
                                                  textAlign: TextAlign.center,),
                                              ),
                                              Container(
                                                height: 20,
                                                child: Row(
                                                  children: [
                                                    if(blockdata[index]['age_group']!=null)
                                                      Text("${blockdata[index]['age_group']}",style: TextStyle(
                                                          color: ColorConstants.txt,
                                                          fontSize: 14),
                                                        textAlign: TextAlign.center,),
                                                    VerticalDivider(color: Colors.black),
                                                    // Text("|"),
                                                    Row(
                                                      children: [
                                                        if(blockdata[index]['flag_icon']!=null)
                                                          Container(
                                                              height: 20,width: 20,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle
                                                              ),
                                                              child:
                                                              CircleAvatar(
                                                                radius: 20.0,
                                                                backgroundImage:
                                                                NetworkImage("${blockdata[index]['flag_icon']}"),
                                                                backgroundColor: Colors.transparent,
                                                              )
                                                          ),
                                                        if(blockdata[index]['country']!=null)
                                                          Text("${blockdata[index]['country']}",style: TextStyle(
                                                              color: ColorConstants.txt,
                                                              fontSize: 14),
                                                            textAlign: TextAlign.center,),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if(blockdata[index]['status']!=null)
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "${blockdata[index]['status']}",
                                                    style: TextStyle(
                                                        color: ColorConstants.verdigris),
                                                  ),
                                                ),
                                              Container(
                                                height:35,
                                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                child: ElevatedButton(
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
                                                    AlertDialog errorDialog = AlertDialog(
                                                      backgroundColor: ColorConstants.verdigris,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20.0)),
                                                      contentPadding: EdgeInsets.all(5),
                                                      //this right here
                                                      title: Center(
                                                          child: Text("Do you really want to unblock the user?",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)),
                                                      actions:  [
                                                        TextButton(
                                                          child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                        Text('',style: TextStyle(color: Colors.white),),

                                                        TextButton(
                                                          child: const Text('Unblock',style: TextStyle(color: Colors.white)),
                                                          onPressed: () {
                                                            unblockApi(userid.toString(), blockdata[index]['id']);
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) => errorDialog);

                                                  },
                                                  child: const Text(
                                                    "UNBLOCK",
                                                    style: TextStyle(
                                                        color: Colors.white, fontSize: 14),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              )

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
                                  builder: (context) => ManageContactScreen()));
                        },
                        child: const Text(
                          "GO BACK",
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

