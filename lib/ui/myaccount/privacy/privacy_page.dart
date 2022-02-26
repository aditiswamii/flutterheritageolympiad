import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';

void main() {

  runApp(const MaterialApp(

    debugShowCheckedModeBanner: false,
    home: PrivacyPage(),
  ));
}
class PrivacyPage extends StatefulWidget{

  const PrivacyPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<PrivacyPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
bool check=false;
  bool check1=false;
  bool check2=false;
  bool check3=false;
  bool check4=false;
  bool check5=false;
  bool check6=false;
  bool check7=false;
  bool check8=false;
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
         // color: Colors.white.withOpacity(0.6),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
          ),
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
                        "assets/home_1.png", height: 40, width: 40,),
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
                          "assets/side_menu_2.png", height: 40, width: 40),
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                  child: const Text("PRIVACY", style: TextStyle(
                      fontSize: 24, color: ColorConstants.Omnes_font))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text(
                      "Edit who can and cannot see your\ninformation.",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font))),
              ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  tileColor: Colors.white,
                title:  Text(
                      "MY PROFILE IS VISIBLE TO...",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font)),
                  trailing: Image.asset("assets/help1.png",height: 20,width: 20,)

              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: const Divider(
                  color: ColorConstants.Omnes_font,
                  height: 2,
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
              ),
              ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                tileColor: Colors.transparent,
                  title:  Text(
                      "Anyone",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font)),
                  trailing:Checkbox( value: check,
                    onChanged: (newvalue) {
                      setState(() {
                        check=newvalue!;
                      });
                    },)
              ),
              ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  tileColor: Colors.transparent,
                  title:  Text(
                      "Only users I have added",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font)),
                  trailing: Checkbox( value: check1,
                    onChanged: (newvalue1) {
                      setState(() {
                        check1=newvalue1!;
                      });
                    },)
              ),
              ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  tileColor: Colors.transparent,
                  title:  Text(
                      "Only me",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font)),
                  trailing: Checkbox( value: check2,
                    onChanged: (newvalue2) {
                      setState(() {
                        check2=newvalue2!;
                      });
                    },)
              ),
              ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  tileColor: Colors.white,
                  title:  Text(
                      "I CAN BE ADDED BY...",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font)),
                  trailing: Image.asset("assets/help1.png",height: 20,width: 20,)

              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: const Divider(
                  color: ColorConstants.Omnes_font,
                  height: 2,
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
              ),
              ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  tileColor: Colors.transparent,
                  title:  Text(
                      "Everyone",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font)),
                  trailing:Checkbox( value: check3,
                    onChanged: (newvalue3) {
                      setState(() {
                        check3=newvalue3!;
                      });
                    },)
              ),
              ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  tileColor: Colors.transparent,
                  title:  Text(
                      "Contacts of my contacts",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font)),
                  trailing: Checkbox( value: check4,
                    onChanged: (newvalue4) {
                      setState(() {
                        check4=newvalue4!;
                      });
                    },)
              ),
              ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  tileColor: Colors.transparent,
                  title:  Text(
                      "Only those I have added",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font)),
                  trailing: Checkbox( value: check5,
                    onChanged: (newvalue5) {
                      setState(() {
                        check5=newvalue5!;
                      });
                    },)
              ),
              ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  tileColor: Colors.white,
                  title:  Text(
                      "I CAN BE INVITED BY...",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font)),
                  trailing: Image.asset("assets/help1.png",height: 20,width: 20,)

              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: const Divider(
                  color: ColorConstants.Omnes_font,
                  height: 2,
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
              ),
              ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  tileColor: Colors.transparent,
                  title:  Text(
                      "Everyone",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font)),
                  trailing:Checkbox( value: check6,
                    onChanged: (newvalue6) {
                      setState(() {
                        check6=newvalue6!;
                      });
                    },)
              ),
              ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  tileColor: Colors.transparent,
                  title:  Text(
                      "Only those I have added",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font)),
                  trailing: Checkbox( value: check7,
                    onChanged: (newvalue7) {
                      setState(() {
                        check7=newvalue7!;
                      });
                    },)
              ),
              ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  tileColor: Colors.transparent,
                  title:  Text(
                      "Invite link only",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font)),
                  trailing: Checkbox(
                    activeColor: Colors.grey,
                    checkColor: Colors.grey,
                    value: check8,
                    onChanged: (newvalue8) {
                      setState(() {
                        check8=newvalue8!;
                      });
                    },)
              ),
          Container(
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
                    fixedSize: const Size(100, 30),
                    //////// HERE
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomePage()));
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
                    fixedSize: const Size(100, 30),
                    //////// HERE
                  ),
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const WelcomePage()));
                  },
                  child: const Text(
                    "SAVE",
                    style: TextStyle(
                        color: ColorConstants.to_the_shop, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

            ],
          ),
        ),
      ),
    );
  }
}