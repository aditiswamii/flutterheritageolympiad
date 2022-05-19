import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/myaccount/invitecontact/invitecontactlink/invitecontact_link.dart';
import 'package:flutterheritageolympiad/ui/myaccount/invitecontact/phonebook/contactlist.dart';

import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';


class InviteContactScreen extends StatefulWidget{

  const InviteContactScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<InviteContactScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color _colorContainer = Colors.white;
  Color textcolor=ColorConstants.txt;
  Color _colorContainer1 = Colors.white;
  Color textcolor1=ColorConstants.txt;
 var selected='';
 // int click=0;

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
        MaterialPageRoute(builder: (BuildContext context) => MyAccountPage()));
    // Do some stuff.
    return true;
  }



  @override
  Widget build(BuildContext context) {
    bool click=false;
    bool click1=false;
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
                          child: const Text("INVITE CONTACTS", style: TextStyle(
                              fontSize: 24, color: ColorConstants.txt))),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child:  Text(
                              "You have 50 contacts.You may remove,block\nor report them",
                              style: TextStyle(fontSize: 15,
                                  color: ColorConstants.txt)
                          ),
                      ),

                    GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 'first';
                          });

                        },
                        child: Container(
                          height: 150,
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Card(
                            color: selected == 'first' ? ColorConstants.yellow200 : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              // if you need this
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("IMPORT FROM...",style: TextStyle(color:selected == 'first'?Colors.white: textcolor,fontSize: 18),textAlign: TextAlign.center,),
                                      Text("your phonebook,email",style: TextStyle(color: selected == 'first'?Colors.white: textcolor,fontSize: 16),textAlign: TextAlign.center,),
                                      Text("address,or social media",style: TextStyle(color: selected == 'first'?Colors.white: textcolor,fontSize: 16),textAlign: TextAlign.center,),
                                      Text("accounts",style: TextStyle(color: selected == 'first'?Colors.white: textcolor,fontSize: 16),textAlign: TextAlign.center,),

                                    ],
                                  ),
                                ),
                              ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = 'second';
                          });
                        },
                        child: Container(
                          height: 150,
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Card(
                            color: selected == 'second' ? ColorConstants.yellow200 : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              // if you need this
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.3),
                                width: 1,
                              ),
                            ),child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("INVITE LINK...",style: TextStyle(color: selected == 'second'?Colors.white: textcolor,fontSize: 18),textAlign: TextAlign.center,),
                                Text("Share a link that will allow",style: TextStyle(color: selected == 'second'?Colors.white: textcolor,fontSize: 16),textAlign: TextAlign.center,),
                                Text("your invites to join directly",style: TextStyle(color: selected == 'second'?Colors.white: textcolor,fontSize: 16),textAlign: TextAlign.center,),
                              ],
                            ),
                        ),
                              ),
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
                                    color: Colors.white, fontSize: 14),
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
                                if(selected!='') {
                                  if (selected == 'first') {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (
                                                context) =>  PhonebookPage()));
                                  } else if (selected == 'second') {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (
                                                context) => ContactInviteLink()));
                                  }
                                }else{
                                  const snackBar = SnackBar(
                                    content: Text('Error'),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                    ],
                ),
            ),
        ),
    );
  }
}