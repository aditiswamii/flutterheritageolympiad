import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/duelinvitesent/duelinvite_dialog.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

void main() {

  runApp(const MaterialApp(

    debugShowCheckedModeBanner: false,
    home: ManageContactScreen(),
  ));
}
class ManageContactScreen extends StatefulWidget{

  const ManageContactScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<ManageContactScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();


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
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_bg.jpg"),
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
                            "assets/home_1.png", height: 40, width: 40),
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
                            "assets/side_menu_2.png", height: 40,
                            width: 40),
                      ),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                    child: const Text("YOUR CONTACTS", style: TextStyle(
                        fontSize: 24, color: ColorConstants.Omnes_font))),

                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                      "You have 50 contacts.You may remove,",
                      style: TextStyle(fontSize: 15,
                          color: ColorConstants.Omnes_font)
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
                              color: ColorConstants.Omnes_font)
                      ),
                      Text(
                          "here.",
                          style: TextStyle(fontSize: 15,decoration: TextDecoration.underline,
                              color: ColorConstants.Omnes_font)
                      ),
                    ],
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
                                  AssetImage("assets/cat1.png"),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              // Image.asset("assets/profile.png",height: 100,width: 100,),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
                                child: Column(
                                  children: [
                                    Text("EUNGEUNG519",style: TextStyle(
                                        color: ColorConstants.Omnes_font,
                                        fontSize: 14),
                                      textAlign: TextAlign.center,),
                                    Row(
                                      children: [
                                        Text("GROUP 3",style: TextStyle(
                                            color: ColorConstants.Omnes_font,
                                            fontSize: 14),
                                          textAlign: TextAlign.center,),
                                        Divider(height: 10,thickness: 1,color: ColorConstants.Omnes_font,),
                                        Text("|"),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/india.png",
                                              width: 10,
                                              height: 10,
                                            ),
                                            Text("INDIA",style: TextStyle(
                                                color: ColorConstants.Omnes_font,
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
                                        primary: ColorConstants.myfeed,
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
                                            color: ColorConstants.to_the_shop,
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
                              color: ColorConstants.to_the_shop, fontSize: 14),
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
                              color: ColorConstants.to_the_shop, fontSize: 14),
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

