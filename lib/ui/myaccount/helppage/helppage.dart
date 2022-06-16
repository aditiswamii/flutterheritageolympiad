import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/userprofile/GetUserProfileResponse.dart';
import 'package:CultreApp/ui/duelmode/duelmodemain/duelmode_main.dart';
import 'package:CultreApp/ui/myaccount/aboutuspage/aboutuspage.dart';
import 'package:CultreApp/ui/myaccount/changepassword/changepassword_screen.dart';
import 'package:CultreApp/ui/myaccount/invitecontact/invitecontact.dart';
import 'package:CultreApp/ui/myaccount/managecontacts/managecontacts.dart';
import 'package:CultreApp/ui/myaccount/myaccount_page.dart';
import 'package:CultreApp/ui/myaccount/notification/notification_screen.dart';
import 'package:CultreApp/ui/myaccount/payment/payment_screen.dart';
import 'package:CultreApp/ui/myaccount/personalinfo/personalinfo.dart';

import 'package:CultreApp/ui/myaccount/privacy/privacy_page.dart';
import 'package:CultreApp/ui/myaccount/yourpage/yourpage.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../../../utils/StringConstants.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<HelpPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descpcontroller = TextEditingController();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;

  var data;
  var helpdata;
  var snackBar;

  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString("userid");
    });
    print("$userid");
    //calTheme();
  }

  helpandsupport(String userid, String title, String description) async {
    showLoaderDialog(context);
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL + "add_help"), body: {
      'user_id': userid.toString(),
      'title': title.toString(),
      'description': description.toString()
    });

    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          helpdata =
              jsonResponse; //get all the data from json string superheros
          print(helpdata.length);
          print(helpdata.toString());


        });

        successdialog(context, "Thanks for your feedback");
      } else {
        snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }
  successdialog(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      backgroundColor: ColorConstants.verdigris,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Container(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          )),

    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(
          Duration(seconds: 2),
              () {
            Navigator.of(context).pop(true);
          },
        );
        return alert;
      },
    );
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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: false,
      endDrawer: MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withAlpha(200),
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
                            borderRadius: BorderRadius.circular(20)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  HomePage()));
                          },
                          child: Image.asset(
                            "assets/images/home_1.png",
                            height: 40,
                            width: 40,
                          ),
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
                      child: Image.asset("assets/images/side_menu_2.png",
                          height: 40, width: 40),
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: const Text("HELP & SUPPORT",
                      style:
                          TextStyle(fontSize: 24, color: ColorConstants.txt))),
              ListBody(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    // height: 60,

                    //color: Colors.white,
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   border: Border.all(color: Colors.black),
                    // ),
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),

                    child: TextFormField(
                      controller: titlecontroller,
                      obscureText: false,
                      maxLength: 100,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          hintText: 'Title (max 100 characters)',
                          hintStyle: TextStyle(color: Colors.grey)),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    // height: 60,

                    //color: Colors.white,
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   border: Border.all(color: Colors.black),
                    // ),
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),

                    child: TextFormField(

                      controller: descpcontroller,
                      obscureText: false,
                      maxLength: 500,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          hintText: 'Description (max 500 characters)',
                          hintStyle: TextStyle(color: Colors.grey)),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants.verdigris,
                          onPrimary: Colors.white,
                          elevation: 3,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          fixedSize: const Size(120, 30),
                          //////// HERE
                        ),
                        onPressed: () {
                          if (titlecontroller.text.isNotEmpty) {
                            if (descpcontroller.text.isNotEmpty) {
                              helpandsupport(
                                  userid.toString(),
                                  titlecontroller.text.toString(),
                                  descpcontroller.text.toString());
                            } else {
                              snackBar = SnackBar(
                                content: Text("Please enter description"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            snackBar = SnackBar(
                              content: Text("Please enter title"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const WelcomePage()));
                        },
                        child: const Text(
                          "SUBMIT",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 120,
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: ColorConstants.txt,
                          ),
                        ),
                        Text(
                          "OR",
                          style: TextStyle(color: ColorConstants.txt),
                        ),
                        Container(
                          width: 120,
                          child: Divider(
                            thickness: 1,
                            color: ColorConstants.txt,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Center(
                        child: Image.asset("assets/images/tho_logo.png",
                            width: 200)),
                  ),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email_sharp,
                        color: ColorConstants.txt,
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text("info@cultre.in",
                              style: TextStyle(
                                  fontSize: 14, color: ColorConstants.txt)))
                    ],
                  )),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        color: ColorConstants.txt,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Text("+91 9717174651",
                            style: TextStyle(
                                fontSize: 14, color: ColorConstants.txt)),
                      )
                    ],
                  )),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: ColorConstants.txt,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Text("646 Nikunjam Towers Kannammoola",
                            style: TextStyle(
                                fontSize: 14, color: ColorConstants.txt)),
                      )
                    ],
                  )),
                  Container(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Text("Thiruvananthapuram",
                            style: TextStyle(
                                fontSize: 14, color: ColorConstants.txt)),
                      )),
                  Container(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Text("Kerala - 695033",
                            style: TextStyle(
                                fontSize: 14, color: ColorConstants.txt)),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
