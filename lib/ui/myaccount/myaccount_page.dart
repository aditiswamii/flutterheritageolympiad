
import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/userprofile/GetUserProfileResponse.dart';
import 'package:CultreApp/ui/duelmode/duelmodemain/duelmode_main.dart';
import 'package:CultreApp/ui/myaccount/aboutuspage/aboutuspage.dart';
import 'package:CultreApp/ui/myaccount/changepassword/changepassword_screen.dart';
import 'package:CultreApp/ui/myaccount/helppage/helppage.dart';
import 'package:CultreApp/ui/myaccount/invitecontact/invitecontact.dart';
import 'package:CultreApp/ui/myaccount/managecontacts/managecontacts.dart';
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

import '../../utils/StringConstants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MyAccountPage extends StatefulWidget{

  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}


class _AccountPageState extends State<MyAccountPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var agegroup;
  var flagicon;
  var prodata;
  var data;
 var snackbar;
  User? userprofileresdata;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString("userid");
    });
    if(prefs.getString("flag")!=null){
      setState(() {
        username= prefs.getString("name");
            agegroup= prefs.getString("group");
            flagicon= prefs.getString("flag");
            country= prefs.getString("country");
      });
    }
    getUserProfile(userid.toString());
    print("$userid");
    //calTheme();
  }
  getUserProfile(String userid) async {

   // showLoaderDialog(context);
    http.Response response =
    await http.post(
        Uri.parse(StringConstants.BASE_URL + "user_profile"),body: {
          'user_id':userid.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        prodata = jsonDecode(
            data!)['data'];
        setState(() {
          prodata = jsonDecode(
              data!)['data']; //get all the data from json string superheros

          onsuccess(prodata['user']);
        });
        print(prodata.length);
        print(prodata.toString());
        print("userdata" + prodata['user'].toString());
        var venam = jsonDecode(data!)['data'];
        print(venam);
      }else{
        snackbar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }else {
     // Navigator.pop(context);
      print(response.statusCode);
    }

  }
  onsuccess(prodataa){
    if(prodataa!=null){
      // userprofileresdata=jsonDecode;
      username="${prodataa['name'][0].toUpperCase() + prodataa['name'].substring(1)}";
      country="${prodataa['country']}";
      profilepic=prodataa['image'].toString();
      agegroup=prodataa['age_group'].toString();
      flagicon=prodataa['flag_icon'].toString();
      setState(() {
        // userprofileresdata=jsonDecode;
        username;
        country;
        profilepic;
        agegroup;
        flagicon;
      });
      print(username +
          country
         + profilepic
         + agegroup
         + flagicon);
print("flagicon"+flagicon);
    preference();
    }
  }
  preference() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", username);
    prefs.setString("group", agegroup);
    prefs.setString("flag", flagicon);
    prefs.setString("country", country);
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
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
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
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: const Text("YOUR ACCOUNT",style: TextStyle(fontSize: 22,fontFamily: 'Nunito',fontStyle: FontStyle.normal,color: ColorConstants.txt))),
                       username==null?Container( width: 200):
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
                child: Text("${username}",style: TextStyle(
                    color: ColorConstants.txt,fontFamily: 'Nunito',fontStyle: FontStyle.normal,
                    fontSize: 16,fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,),
              ),

              agegroup==null && country==null && flagicon==null ?
              Container(  width: 10,):
              Container( margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: MediaQuery.of(context).size.width,
                child: Container(
                  width: 300,
                  alignment: Alignment.centerLeft,
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                        Container(
                          width: 80,
                          child: Text("${agegroup}",style: TextStyle(
                              color: ColorConstants.txt,fontFamily: 'Nunito',fontStyle: FontStyle.normal,
                              fontSize: 14),
                            textAlign: TextAlign.left,),
                        ),
                      Container(width: 10,alignment: Alignment.centerLeft,
                          child: VerticalDivider(color: Colors.black)),
                      // Text("|"),
                      Container(
                        width: 90,
                        child: Row(
                          children: [

                              Container(
                                  height: 20,width: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle
                                  ),
                                  child:
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage:
                                    NetworkImage("${flagicon}"),
                                    backgroundColor: Colors.transparent,
                                  )
                              ),

                              Expanded(
                                child: Container(margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text("${country}",style: TextStyle(
                                      color: ColorConstants.txt,
                                      fontSize: 14,fontFamily: 'Nunito',fontStyle: FontStyle.normal),
                                    textAlign: TextAlign.left,),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
                              leading: Image.asset("assets/images/your_page1.png",height: 25,width: 25,),
                              title: GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>  YourPage()));
                                  },

                                  child: Text("YOUR PAGE",style: TextStyle(color:ColorConstants.txt,fontFamily: 'Nunito',fontStyle: FontStyle.normal),)),
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
                            leading: Image.asset("assets/images/notifications.png",height: 25,width: 25,),
                            title: GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const NotificationScreen()));
                                },

                                child: Text("NOTIFICATIONS",style: TextStyle(color:ColorConstants.txt,fontFamily: 'Nunito',fontStyle: FontStyle.normal),)),
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
                              leading: Image.asset("assets/images/setting.png",height: 25,width: 25,),
                              title:GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const ManageContactScreen()));
                                },
                                  child: Text("MANAGE CONTACTS",style: TextStyle(color:ColorConstants.txt,fontFamily: 'Nunito',fontStyle: FontStyle.normal),)),
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
                              leading: Image.asset("assets/images/interval.png",height: 25,width: 25,),
                              title: GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PersonalInfoScreen()));
                                  },
                                  child: Text("PERSONAL INFORMATION",style: TextStyle(color:ColorConstants.txt,fontFamily: 'Nunito',fontStyle: FontStyle.normal),)),
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
                              leading: Image.asset("assets/images/change_password.png",height: 25,width: 25,),
                              title:GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChangepasswordScreen()));
                                  },
                                  child: Text("CHANGE PASSWORD",style: TextStyle(color:ColorConstants.txt,fontFamily: 'Nunito',fontStyle: FontStyle.normal),)),
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
                              leading: Image.asset("assets/images/privacy.png",height: 25,width: 25,),
                              title:GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>  PrivacyPage()));
                                  },
                                  child: Text("PRIVACY",style: TextStyle(color:ColorConstants.txt,fontFamily: 'Nunito',fontStyle: FontStyle.normal),)),
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
                              leading: Image.asset("assets/images/interval.png",height: 25,width: 25,),
                              title: GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => InviteContactScreen()));
                                  },
                                  child: Text("INVITE FRIENDS",style: TextStyle(color:ColorConstants.txt,fontFamily: 'Nunito',fontStyle: FontStyle.normal),)),
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
                              leading: Image.asset("assets/images/payment_setting.png",height: 25,width: 25,),
                              title:GestureDetector(
                                  onTap: (){
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>  BarChartDemo()));
                                     },
                                  child: Text("PAYMENTS",style: TextStyle(color:ColorConstants.txt,fontFamily: 'Nunito',fontStyle: FontStyle.normal),)),
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
                              leading: Image.asset("assets/images/help.png",height: 25,width: 25,),
                              title: GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>  HelpPage()));
                                  },
                                  child: Text("HELP",style: TextStyle(color:ColorConstants.txt,fontFamily: 'Nunito',fontStyle: FontStyle.normal),)),
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
                              leading: Image.asset("assets/images/about.png",height: 25,width: 25,),
                              title: GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>  AboutUsPage(title: 'ABOUT US', url: 'https://www.cultre.in/our-team',)));
                                  },
                                  child: Text("ABOUT",style: TextStyle(color:ColorConstants.txt,fontFamily: 'Nunito',fontStyle: FontStyle.normal),)),
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
                              leading: Image.asset("assets/images/share1.png",height: 25,width: 25,),
                              title: GestureDetector(
                                  onTap: (){
                                    Share.share('https://cultre.app/cul.tre/2', subject: 'share');
                                    //Share.shareFiles(['${directory.path}/image.jpg'], text: 'Great picture');
                                  },
                                  child: Text("SHARE",style: TextStyle(color:ColorConstants.txt,fontFamily: 'Nunito',fontStyle: FontStyle.normal),)),
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
                                    builder: (context) => HomePage()));
                          },
                          child: const Text(
                            "GO BACK",
                            style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'Nunito',fontStyle: FontStyle.normal,),
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
    );
  }
}
