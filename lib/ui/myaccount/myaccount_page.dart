
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodemain/duelmode_main.dart';
import 'package:flutterheritageolympiad/ui/myaccount/changepassword/chnagepassword_screen.dart';
import 'package:flutterheritageolympiad/ui/myaccount/invitecontact/invitecontact.dart';
import 'package:flutterheritageolympiad/ui/myaccount/managecontacts/managecontacts.dart';
import 'package:flutterheritageolympiad/ui/myaccount/notification/notification_screen.dart';
import 'package:flutterheritageolympiad/ui/myaccount/payment/payment_screen.dart';
import 'package:flutterheritageolympiad/ui/myaccount/personalinfo/personalinfo.dart';

import 'package:flutterheritageolympiad/ui/myaccount/privacy/privacy_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:share_plus/share_plus.dart';



class MyAccountPage extends StatefulWidget{

  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}


class _AccountPageState extends State<MyAccountPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
    void initState() {
      super.initState();
      BackButtonInterceptor.add(myInterceptor);
    }

    @override
    void dispose() {
      BackButtonInterceptor.remove(myInterceptor);
      super.dispose();
    }

    bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => WelcomePage()));
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
      endDrawerEnableOpenDragGesture: false,
      endDrawer: MySideMenuDrawer(),
      body:Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:Container(
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: SingleChildScrollView(
            child: Column(
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
                              child:  Image.asset("assets/images/home_1.png",height: 40,width: 40,),
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
                          margin: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                          child: const Text("YOUR ACCOUNT",style: TextStyle(fontSize: 24,color: ColorConstants.txt))),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: const Text("Scroll down see all updates,search by\nkeywords,or filter updates by type.",style: TextStyle(fontSize: 15,color: ColorConstants.txt))),
                ListBody(
                  // scrollDirection: Axis.vertical,
                  // shrinkWrap: true,
                    children: [

                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                        child: Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            // if you need this
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child:
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ListTile(
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                              leading: Image.asset("assets/images/notifications.png",height: 30,width: 30,),
                              title: GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const NotificationScreen()));
                                  },

                                  child: Text("NOTIFICATIONS",style: TextStyle(color:ColorConstants.txt),)),
                            )

                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                        child: Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            // if you need this
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child:
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ListTile(
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                leading: Image.asset("assets/images/setting.png",height: 30,width: 30,),
                                title:GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const ManageContactScreen()));
                                  },
                                    child: Text("MANAGE CONTACTS",style: TextStyle(color:ColorConstants.txt),)),
                              )

                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            // if you need this
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child:
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ListTile(
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                leading: Image.asset("assets/images/interval.png",height: 30,width: 30,),
                                title: GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PersonalInfoScreen()));
                                    },
                                    child: Text("PERSONAL INFORMATION",style: TextStyle(color:ColorConstants.txt),)),
                              )

                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            // if you need this
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child:
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ListTile(
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                leading: Image.asset("assets/images/change_password.png",height: 30,width: 30,),
                                title:GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChangepasswordScreen()));
                                    },
                                    child: Text("CHANGE PASSWORD",style: TextStyle(color:ColorConstants.txt),)),
                              )

                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                        child: Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            // if you need this
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child:
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ListTile(
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                leading: Image.asset("assets/images/privacy.png",height: 30,width: 30,),
                                title:GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>  PrivacyPage()));
                                    },
                                    child: Text("PRIVACY",style: TextStyle(color:ColorConstants.txt),)),
                              )

                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                        child: Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            // if you need this
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child:
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ListTile(
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                leading: Image.asset("assets/images/interval.png",height: 30,width: 30,),
                                title: GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => InviteContactScreen()));
                                    },
                                    child: Text("INVITE FRIENDS",style: TextStyle(color:ColorConstants.txt),)),
                              )

                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                        child: Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            // if you need this
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child:
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ListTile(
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                leading: Image.asset("assets/images/payment_setting.png",height: 30,width: 30,),
                                title:GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PaymentScreen()));
                                    },
                                    child: Text("PAYMENTS",style: TextStyle(color:ColorConstants.txt),)),
                              )
                          ),

                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                        child: Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            // if you need this
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child:
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ListTile(
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                leading: Image.asset("assets/images/help.png",height: 30,width: 30,),
                                title: GestureDetector(
                                    onTap: (){

                                    },
                                    child: Text("HELP",style: TextStyle(color:ColorConstants.txt),)),
                              )

                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                        child:Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            // if you need this
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child:
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ListTile(
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                leading: Image.asset("assets/images/about.png",height: 30,width: 30,),
                                title: GestureDetector(
                                    onTap: (){

                                    },
                                    child: Text("ABOUT",style: TextStyle(color:ColorConstants.txt),)),
                              )

                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                        child: Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            // if you need this
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child:
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: ListTile(
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                leading: Image.asset("assets/images/share1.png",height: 30,width: 30,),
                                title: GestureDetector(
                                    onTap: (){
                                      Share.share('Share App', subject: 'share');
                                      //Share.shareFiles(['${directory.path}/image.jpg'], text: 'Great picture');
                                    },
                                    child: Text("SHARE",style: TextStyle(color:ColorConstants.txt),)),
                              )

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
