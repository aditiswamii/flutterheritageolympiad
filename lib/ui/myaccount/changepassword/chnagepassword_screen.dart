import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/cancelplan/cancelplan_dialog.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';


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
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  bool _passwordVisible3= false;
  bool value = false;
  @override
  void initState() {

    super.initState();
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
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                    child: const Text("CHANGE PASSWORD", style: TextStyle(
                        fontSize: 24, color: ColorConstants.txt))),
                Flexible(child:
                Container(
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextFormField(
                    controller: currentpasswordController,
                    obscureText: !_passwordVisible1,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      // hasFloatingPlaceholder: true,
                      filled: true,
                      border: InputBorder.none,
                      // labelText: "Password",
                      hintText: "Current Password*",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _passwordVisible1 = true;
                          });
                        },
                        onPanCancel: () {
                          setState(() {
                            _passwordVisible1 = false;
                          });
                        },
                        child: Icon(
                            _passwordVisible1 ? Icons.visibility : Icons
                                .visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*Password needed";
                      }
                    },
                    // onSaved: (value) {
                    // _setPassword(value);
                    // },
                  ),),),
                Flexible(child:
                Container(
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextFormField(
                    controller: newpasswordController,
                    obscureText: !_passwordVisible2,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      // hasFloatingPlaceholder: true,
                      filled: true,
                      border: InputBorder.none,
                      // labelText: "Password",
                      hintText: "New Password*",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _passwordVisible2 = true;
                          });
                        },
                        onPanCancel: () {
                          setState(() {
                            _passwordVisible2 = false;
                          });
                        },
                        child: Icon(
                            _passwordVisible2 ? Icons.visibility : Icons
                                .visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*Confirm New Password needed";
                      }
                    },
                    // onSaved: (value) {
                    // _setPassword(value);
                    // },
                  ),),),
                Flexible(child:
                Container(
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextFormField(
                    controller: confirmpasswordController,
                    obscureText: _passwordVisible3?false:true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      // hasFloatingPlaceholder: true,
                      filled: true,
                      border: InputBorder.none,
                      // labelText: "Password",
                      hintText: "Password",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _passwordVisible3= true;
                          });
                        },

                        child: Icon(
                            _passwordVisible3 ? Icons.visibility : Icons
                                .visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "*Password needed";
                      }
                    },
                    // onSaved: (value) {
                    // _setPassword(value);
                    // },
                  ),),),


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
                          Navigator.of(context).pop();
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => MyAccountPage()));
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
                          // AlertDialog errorDialog = AlertDialog(
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius:
                          //         BorderRadius.circular(
                          //             20.0)), //this right here
                          //     title: Container(
                          //         height: 250,
                          //         width: 250,
                          //         alignment: Alignment.center,
                          //         child: DialogCancelPlan()));
                          // showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) =>
                          //     errorDialog);
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

