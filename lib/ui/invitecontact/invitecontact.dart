import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/invitecontact/invitecontactlink/invitecontact_link.dart';
import 'package:flutterheritageolympiad/ui/invitecontact/phonebook/phonebook_screen.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';

void main() {

  runApp(const MaterialApp(

    debugShowCheckedModeBanner: false,
    home: InviteContactScreen(),
  ));
}
class InviteContactScreen extends StatefulWidget{

  const InviteContactScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<InviteContactScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color _colorContainer = Colors.white;
  Color textcolor=ColorConstants.Omnes_font;
  Color _colorContainer1 = Colors.white;
  Color textcolor1=ColorConstants.Omnes_font;
  bool click=false;
  bool click1=false;
  @override
  void initState() {
    click=false;
    click1=false;
  // click;
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
                                        builder: (
                                            context) => const WelcomePage()));
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
                          child: const Text("INVITE CONTACTS", style: TextStyle(
                              fontSize: 24, color: ColorConstants.Omnes_font))),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child:  Text(
                              "You have 50 contacts.You may remove,block\nor report them",
                              style: TextStyle(fontSize: 15,
                                  color: ColorConstants.Omnes_font)
                          ),
                      ),
                         Ink(
                           child: InkWell(
                              child:
                              Container(
                          height: 150,
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Card(
                            color: _colorContainer,
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
                                      Text("IMPORT FROM...",style: TextStyle(color: textcolor,fontSize: 18),textAlign: TextAlign.center,),
                                      Text("your phonebook,email",style: TextStyle(color: textcolor,fontSize: 16),textAlign: TextAlign.center,),
                                      Text("address,or social media",style: TextStyle(color: textcolor,fontSize: 16),textAlign: TextAlign.center,),
                                      Text("accounts",style: TextStyle(color: textcolor,fontSize: 16),textAlign: TextAlign.center,),

                                    ],
                                  ),
                                ),
                              ),
                             onTap: () {
                               setState(() {
                                 if(textcolor1 != Colors.white&&_colorContainer1 != ColorConstants.myfeed) {
                                   click=true;
                                   textcolor = Colors.white;
                                   _colorContainer = ColorConstants.myfeed;
                                 }else{

                                   textcolor = ColorConstants.Omnes_font;
                                   _colorContainer = Colors.white;
                                   textcolor1 = Colors.white;
                                   _colorContainer1 = ColorConstants.myfeed;
                                 }

                               });
                             }
                       ),
                     ),
                      Ink(
                        child: InkWell(
                            child:
                            Container(
                              height: 150,
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Card(
                                color: _colorContainer1,
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
                                    Text("INVITE LINK...",style: TextStyle(color: textcolor1,fontSize: 18),textAlign: TextAlign.center,),
                                    Text("Share a link that will allow",style: TextStyle(color: textcolor1,fontSize: 16),textAlign: TextAlign.center,),
                                    Text("your invites to join directly",style: TextStyle(color: textcolor1,fontSize: 16),textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {

                                if(textcolor != Colors.white&&_colorContainer != ColorConstants.myfeed) {
                                  click1=true;
                                  textcolor1 = Colors.white;
                                  _colorContainer1 = ColorConstants.myfeed;
                                }else{
                                  textcolor1 = ColorConstants.Omnes_font;
                                  _colorContainer1 = Colors.white;
                                  textcolor == Colors.white;
                                  _colorContainer == ColorConstants.myfeed;
                                }
                              });
                            }
                        ),
                      ),

                    // GestureDetector(
                    //     onTap: () {
                    //       click=true;
                    //       setState(() {
                    //         if(click==true) {
                    //           textcolor =Colors.white ;
                    //           _colorContainer = ColorConstants.myfeed;
                    //         }
                    //         click=false;
                    //       });
                    //
                    //     },
                    //     child: Container(
                    //       height: 150,
                    //       margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    //       child: Card(
                    //         color: _colorContainer,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(5),
                    //           // if you need this
                    //           side: BorderSide(
                    //             color: Colors.grey.withOpacity(0.3),
                    //             width: 1,
                    //           ),
                    //         ),
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //                   Text("IMPORT FROM...",style: TextStyle(color: textcolor,fontSize: 18),textAlign: TextAlign.center,),
                    //                   Text("your phonebook,email",style: TextStyle(color: textcolor,fontSize: 16),textAlign: TextAlign.center,),
                    //                   Text("address,or social media",style: TextStyle(color: textcolor,fontSize: 16),textAlign: TextAlign.center,),
                    //                   Text("accounts",style: TextStyle(color: textcolor,fontSize: 16),textAlign: TextAlign.center,),
                    //
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //   ),
                    //   GestureDetector(
                    //     onTap: () {
                    //
                    //       setState(() {
                    //         click1=true;
                    //         if(click1==true) {
                    //           textcolor =Colors.white ;
                    //           _colorContainer = ColorConstants.myfeed;
                    //           // textcolor =
                    //           // textcolor == ColorConstants.Omnes_font ? Colors
                    //           //     .white : ColorConstants.Omnes_font;
                    //           // _colorContainer =
                    //           // _colorContainer == Colors.white ?
                    //           // ColorConstants.myfeed :
                    //           // Colors.white;
                    //         }
                    //         click1=false;
                    //       });
                    //     },
                    //     child: Container(
                    //       height: 150,
                    //       margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    //       decoration: const BoxDecoration(color: Colors.white),
                    //       child: Card(
                    //         color: _colorContainer,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(5),
                    //           // if you need this
                    //           side: BorderSide(
                    //             color: Colors.grey.withOpacity(0.3),
                    //             width: 1,
                    //           ),
                    //         ),child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Text("INVITE LINK...",style: TextStyle(color: textcolor,fontSize: 18),textAlign: TextAlign.center,),
                    //             Text("Share a link that will allow",style: TextStyle(color: textcolor,fontSize: 16),textAlign: TextAlign.center,),
                    //             Text("your invites to join directly",style: TextStyle(color: textcolor,fontSize: 16),textAlign: TextAlign.center,),
                    //           ],
                    //         ),
                    //     ),
                    //           ),
                    //   ),
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
                                if(click==true) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (
                                              context) => const PhonebookScreen()));
                                }else if(click1==true){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (
                                              context) => const ContactInviteLink()));
                                }
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
                    ],
                ),
            ),
        ),
    );
  }
}