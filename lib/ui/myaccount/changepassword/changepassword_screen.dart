import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/dialog/cancelplan/cancelplan_dialog.dart';
import 'package:CultreApp/ui/myaccount/myaccount_page.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/StringConstants.dart';

class ChangepasswordScreen extends StatefulWidget{

  const ChangepasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangepasswordScreenState createState() => _ChangepasswordScreenState();
}


class _ChangepasswordScreenState extends State<ChangepasswordScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController currentpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool _passwordVisible1 = true;
  bool _passwordVisible2 = true;
  bool _passwordVisible3= true;
  bool value = false;
  var data;
  var changedata;
  var snackBar;
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    print("userdata");

  }
  changepass(String userid, String current_password,String new_password) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "change-password"),
        body: {
          'user_id': userid.toString(),
          'current_password': current_password.toString(),
          'new_password': new_password.toString()
        });
    showLoaderDialog(context);

    print("changepassapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        changedata = jsonResponse[
        'data'];
        print("data" + changedata.toString());
        setState(() {
          changedata = jsonResponse[
          'data'];
        });

        //get all the data from json string superheros
        print("length" + changedata.length.toString());


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
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      // endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container( color: Colors.white.withAlpha(100),
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
                                      builder: (context) => HomePage()));
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
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: const Text("CHANGE PASSWORD", style: TextStyle(
                        fontSize: 24, color: ColorConstants.txt))),
                Container(
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextFormField(
                    controller: currentpasswordController,
                    obscureText: _passwordVisible1,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      // hasFloatingPlaceholder: true,
                      filled: true,
                      border: InputBorder.none,
                      // labelText: "Password",
                      hintText: "Current Password*",
                      suffixIcon: IconButton(
                          icon: Icon(
                              _passwordVisible1 ?  Icons.visibility_off:Icons.visibility ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible1 = !_passwordVisible1;
                            });
                          }),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*Password needed";
                      }
                    },
                    // onSaved: (value) {
                    // _setPassword(value);
                    // },
                  ),),
                Container(
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextFormField(
                    controller: newpasswordController,
                    obscureText: _passwordVisible2,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      // hasFloatingPlaceholder: true,
                      filled: true,
                      border: InputBorder.none,
                      // labelText: "Password",
                      hintText: "New Password*",
                      suffixIcon: IconButton(
                          icon: Icon(
                              _passwordVisible2 ?  Icons.visibility_off:Icons.visibility ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible2 = !_passwordVisible2;
                            });
                          }),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*Confirm New Password needed";
                      }
                    },
                    // onSaved: (value) {
                    // _setPassword(value);
                    // },
                  ),),
                Container(
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextFormField(
                    controller: confirmpasswordController,
                    obscureText: _passwordVisible3,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      // hasFloatingPlaceholder: true,
                      filled: true,
                      border: InputBorder.none,
                      // labelText: "Password",
                      hintText: "Password",
                      suffixIcon: IconButton(
                          icon: Icon(
                              _passwordVisible3 ?  Icons.visibility_off:Icons.visibility ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible3 = !_passwordVisible3;
                            });
                          }),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*Password needed";
                      }
                    },
                    // onSaved: (value) {
                    // _setPassword(value);
                    // },
                  ),),


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
                              color:Colors.white, fontSize: 14),
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
                         if(currentpasswordController.text.isNotEmpty){
                           if(newpasswordController.text.isNotEmpty){
                             if(confirmpasswordController.text.isNotEmpty){
                               if(newpasswordController.text==confirmpasswordController.text){

                                 changepass(userid.toString(), currentpasswordController.text.toString(),newpasswordController.text.toString());

                               }else{
                                 const snackBar =
                                 SnackBar(
                                   content: Text(
                                       'Please enter valid password'),
                                 );
                                 ScaffoldMessenger
                                     .of(context)
                                     .showSnackBar(
                                     snackBar);
                               }
                             }else{
                               const snackBar =
                               SnackBar(
                                 content: Text(
                                     'Please enter password'),
                               );
                               ScaffoldMessenger
                                   .of(context)
                                   .showSnackBar(
                                   snackBar);
                             }
                           }else{
                             const snackBar =
                             SnackBar(
                               content: Text(
                                   'Please enter new password'),
                             );
                             ScaffoldMessenger
                                 .of(context)
                                 .showSnackBar(
                                 snackBar);
                           }
                         }else{
                           const snackBar =
                           SnackBar(
                             content: Text(
                                 'Please enter current password'),
                           );
                           ScaffoldMessenger
                               .of(context)
                               .showSnackBar(
                               snackBar);
                         }
                        },
                        child: const Text(
                          "LET'S GO!",
                          style: TextStyle(
                              color: Colors.white, fontSize: 14),
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

