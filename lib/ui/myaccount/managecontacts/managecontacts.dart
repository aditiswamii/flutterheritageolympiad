import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/duelinvitesent/duelinvite_dialog.dart';
import 'package:flutterheritageolympiad/modal/getcontactlist/GetContactUserlist.dart';
import 'package:flutterheritageolympiad/ui/myaccount/contactpage/contactpage.dart';
import 'package:flutterheritageolympiad/ui/myaccount/managecontacts/blockcontact/blockcontact.dart';
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
  var contactdata;
  var blockdata;
  var deletedata;



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
    getUserlist(userid.toString());
    // getFeed(userid.toString(), "0", "", "", "");
  }

  getUserlist(String userid) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "get_all_contacts"),
        body: {'user_id': userid.toString()});
    showLoaderDialog(context);

    print("getUserlistapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        contactdata = jsonResponse[
        'data'];
        print("data" + contactdata.toString());
        setState(() {
          contactdata = jsonResponse[
          'data'];
        });
        //get all the data from json string superheros
        print("length" + contactdata.length.toString());
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

  BlockApi(String userid,String blockid) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "blockuser"),
        body: {
          'user_id': userid.toString(),
          'block_id': blockid.toString(),
        });
    showLoaderDialog(context);

    print("getBlockApiapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        blockdata = jsonResponse[
        'data'];
        print("data" + blockdata.toString());
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
  DeleteApi(String userid,String deleteid) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "deleteuser"),
        body: {
          'user_id': userid.toString(),
          'delete_id':deleteid.toString()
        });
    showLoaderDialog(context);

    print("getUserlistapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        deletedata = jsonResponse[
        'data'];
        print("data" + deletedata.toString());
        //get all the data from json string superheros
        print("length" + deletedata.length.toString());
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
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: ListView(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      alignment: Alignment.centerLeft,

                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const WelcomePage()));
                            },
                            child:  Image.asset("assets/images/home_1.png",height: 40,width: 40,),
                          ),
                        ),
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
                        child:  Image.asset("assets/images/side_menu_2.png",height: 40,width: 40),
                      ),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: const Text("YOUR CONTACTS", style: TextStyle(
                        fontSize: 24, color: ColorConstants.txt))),

                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "You have",
                          style: TextStyle(fontSize: 15,
                              color: ColorConstants.txt)
                      ),
                      Container( margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: contactdata==null?Text(
                            "0",
                            style: TextStyle(fontSize: 15,
                                color: ColorConstants.txt)
                        ):Text(
                            contactdata.length.toString(),
                            style: TextStyle(fontSize: 15,
                                color: ColorConstants.txt)
                        ),
                      ),
                      Container( margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                            "contacts. You may remove,",
                            style: TextStyle(fontSize: 15,
                                color: ColorConstants.txt)
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                          "block them, and unblock contacts ",
                          style: TextStyle(fontSize: 15,
                              color: ColorConstants.txt)
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (BuildContext context) => BlockContactScreen()));
                        },
                        child: Text(
                            "here.",
                            style: TextStyle(fontSize: 15,decoration: TextDecoration.underline,
                                color: ColorConstants.txt)
                        ),
                      ),
                    ],
                  ),
                ),
                contactdata==null?Container(): Container(
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: ListView.builder(
    physics: ClampingScrollPhysics(
    parent: BouncingScrollPhysics()),
    shrinkWrap: true,
    itemCount: contactdata.length,
    itemBuilder: (BuildContext context, int index) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => ContactPage(contactid: contactdata[index]['id'].toString(),)));
      },
      child: Container(
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
                                if(contactdata[index]['image']!="")
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  height: 90,
                                  width: 90,
                                  child:
                                  CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage:
                                   NetworkImage("${contactdata[index]['image']}"),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                if(contactdata[index]['image']=="")
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
                                        child: Text("${contactdata[index]['name']}",style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontSize: 16,fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,),
                                      ),
                                      Container(
                                        height: 20,
                                        child: Row(
                                          children: [
                                            if(contactdata[index]['age_group']!=null)
                                            Text("${contactdata[index]['age_group']}",style: TextStyle(
                                                color: ColorConstants.txt,
                                                fontSize: 14),
                                              textAlign: TextAlign.center,),
                                            VerticalDivider(color: Colors.black),
                                            // Text("|"),
                                            Row(
                                              children: [
                                                if(contactdata[index]['flag_icon']!=null)
                                                Container(
                                                  height: 20,width: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle
                                                  ),
                                                  child:
                                                  CircleAvatar(
                                                    radius: 20.0,
                                                    backgroundImage:
                                                    NetworkImage("${contactdata[index]['flag_icon']}"),
                                                    backgroundColor: Colors.transparent,
                                                  )
                                                ),
                                                if(contactdata[index]['country']!=null)
                                                Text("${contactdata[index]['country']}",style: TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 14),
                                                  textAlign: TextAlign.center,),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      if(contactdata[index]['status']!=null)
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${contactdata[index]['status']}",
                                          style: TextStyle(
                                              color: ColorConstants.verdigris),
                                        ),
                                      ),
                                      Container(
                                          height:35,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap:(){

                                          },
                                              child: Container(margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(30),
                                                    // if you need this

                                                  ),
                                                  elevation: 3,
                                                  child: Image.asset("assets/images/warning.png",height: 30,width: 30,),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30),
                                                  // if you need this

                                                ),
                                                elevation: 3,
                                                child: Image.asset("assets/images/delete.png",height: 30,width: 30,),
                                              ),
                                            ),
                                          ],
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

