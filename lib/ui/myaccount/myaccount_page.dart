
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodemain/duelmode_main.dart';
import 'package:flutterheritageolympiad/ui/invitecontact/invitecontact.dart';
import 'package:flutterheritageolympiad/ui/phonebook/phonebook_screen.dart';
import 'package:flutterheritageolympiad/ui/privacy/privacy_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:share_plus/share_plus.dart';


void main() {

  runApp(const MaterialApp(

    debugShowCheckedModeBanner: false,
    home: MyAccountPage(),
  ));
}
class MyAccountPage extends StatefulWidget{

  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<MyAccountPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
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
            image: AssetImage("assets/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:Container(
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
                        child:  Image.asset("assets/home_1.png",height: 40,width: 40,),
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
                        child:  Image.asset("assets/side_menu_2.png",height: 40,width: 40),
                      ),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                    child: const Text("YOUR ACCOUNT",style: TextStyle(fontSize: 24,color: ColorConstants.Omnes_font))),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("Scroll down see all updates,search by\nkeywords,or filter updates by type.",style: TextStyle(fontSize: 15,color: ColorConstants.Omnes_font))),
                Flexible(
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
                      child:
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListTile(
                          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          leading: Image.asset("assets/setting.png",height: 30,width: 30,),
                          title: GestureDetector(
                              onTap: (){

                              },

                              child: Text("NOTIFICATIONS",style: TextStyle(color:ColorConstants.Omnes_font),)),
                        )

                      ),
                    ),
                  ),
                ),
                Flexible(
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
                      child:
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            leading: Image.asset("assets/setting.png",height: 30,width: 30,),
                            title:GestureDetector(
                              onTap: (){

                              },
                                child: Text("MANAGE CONTACTS",style: TextStyle(color:ColorConstants.Omnes_font),)),
                          )

                      ),
                    ),
                  ),
                ),
                Flexible(
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
                      child:
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            leading: Image.asset("assets/interval.png",height: 30,width: 30,),
                            title: GestureDetector(
                                onTap: (){

                                },
                                child: Text("PERSONAL INFORMATION",style: TextStyle(color:ColorConstants.Omnes_font),)),
                          )

                      ),
                    ),
                  ),
                ),
                Flexible(
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
                      child:
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            leading: Image.asset("assets/change_password.png",height: 30,width: 30,),
                            title:GestureDetector(
                                onTap: (){

                                },
                                child: Text("CHANGE PASSWORD",style: TextStyle(color:ColorConstants.Omnes_font),)),
                          )

                      ),
                    ),
                  ),
                ),
                Flexible(
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
                      child:
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            leading: Image.asset("assets/privacy.png",height: 30,width: 30,),
                            title:GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const PrivacyPage()));
                                },
                                child: Text("PRIVACY",style: TextStyle(color:ColorConstants.Omnes_font),)),
                          )

                      ),
                    ),
                  ),
                ),
                Flexible(
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
                      child:
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            leading: Image.asset("assets/interval.png",height: 30,width: 30,),
                            title: GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => InviteContactScreen()));
                                },
                                child: Text("INVITE FRIENDS",style: TextStyle(color:ColorConstants.Omnes_font),)),
                          )

                      ),
                    ),
                  ),
                ),
                Flexible(
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
                      child:
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            leading: Image.asset("assets/payment_setting.png",height: 30,width: 30,),
                            title:GestureDetector(
                                onTap: (){

                                },
                                child: Text("PAYMENTS",style: TextStyle(color:ColorConstants.Omnes_font),)),
                          )

                      ),
                    ),
                  ),
                ),
                Flexible(
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
                      child:
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            leading: Image.asset("assets/help.png",height: 30,width: 30,),
                            title: GestureDetector(
                                onTap: (){

                                },
                                child: Text("HELP",style: TextStyle(color:ColorConstants.Omnes_font),)),
                          )

                      ),
                    ),
                  ),
                ),
                Flexible(
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
                      child:
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            leading: Image.asset("assets/about.png",height: 30,width: 30,),
                            title: GestureDetector(
                                onTap: (){

                                },
                                child: Text("ABOUT",style: TextStyle(color:ColorConstants.Omnes_font),)),
                          )

                      ),
                    ),
                  ),
                ),
                Flexible(
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
                      child:
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            leading: Image.asset("assets/share1.png",height: 30,width: 30,),
                            title: GestureDetector(
                                onTap: (){
                                  Share.share('Share App', subject: 'share');
                                  //Share.shareFiles(['${directory.path}/image.jpg'], text: 'Great picture');
                                },
                                child: Text("SHARE",style: TextStyle(color:ColorConstants.Omnes_font),)),
                          )

                      ),
                    ),
                  ),
                ),

                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        elevation: 3,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        fixedSize: const Size(120, 30),
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
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
