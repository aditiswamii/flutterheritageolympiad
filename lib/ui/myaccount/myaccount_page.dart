import 'dart:convert';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/userprofile/GetUserProfileResponse.dart';
import 'package:CultreApp/ui/myaccount/aboutuspage/aboutuspage.dart';
import 'package:CultreApp/ui/myaccount/changepassword/changepassword_screen.dart';
import 'package:CultreApp/ui/myaccount/helppage/helppage.dart';
import 'package:CultreApp/ui/myaccount/invitecontact/invitecontact.dart';
import 'package:CultreApp/ui/myaccount/managecontacts/managecontacts.dart';
import 'package:CultreApp/ui/myaccount/notification/notification_screen.dart';
import 'package:CultreApp/ui/myaccount/personalinfo/personalinfo.dart';
import 'package:CultreApp/ui/myaccount/privacy/privacy_page.dart';
import 'package:CultreApp/ui/myaccount/yourpage/yourpage.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/StringConstants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<MyAccountPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
    if (prefs.getString("flag") != null) {
      setState(() {
        username = prefs.getString("name");
        agegroup = prefs.getString("group");
        flagicon = prefs.getString("flag");
        country = prefs.getString("country");
      });
    }
    getUserProfile(userid.toString());
    print("$userid");
    //calTheme();
  }

  getUserProfile(String userid) async {
    // showLoaderDialog(context);
    http.Response response = await http.post(
        Uri.parse("${StringConstants.BASE_URL}user_profile"),
        body: {'user_id': userid.toString()});
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        prodata = jsonDecode(data!)['data'];
        setState(() {
          prodata = jsonDecode(
              data!)['data']; //get all the data from json string superheros

          onsuccess(prodata['user']);
        });
        print(prodata.length);
        print(prodata.toString());
        print("userdata${prodata['user']}");
        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        snackbar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } else {
      // Navigator.pop(context);
      print(response.statusCode);
    }
  }

  onsuccess(prodataa) {
    if (prodataa != null) {
      // userprofileresdata=jsonDecode;
      username =
          "${prodataa['name'][0].toUpperCase() + prodataa['name'].substring(1)}";
      country = "${prodataa['country']}";
      profilepic = prodataa['image'].toString();
      agegroup = prodataa['age_group'].toString();
      flagicon = prodataa['flag_icon'].toString();
      setState(() {
        // userprofileresdata=jsonDecode;
        username;
        country;
        profilepic;
        agegroup;
        flagicon;
      });
      print(username + country + profilepic + agegroup + flagicon);
      print("flagicon" + flagicon);
      preference();
    }
  }

  preference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", username);
    prefs.setString("group", agegroup);
    prefs.setString("flag", flagicon);
    prefs.setString("country", country);
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: false,
      endDrawer: const MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  color: Colors.white,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            alignment: Alignment.centerLeft,
                             padding: const EdgeInsets.all(2),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)
                            ),

                            child: SvgPicture.asset("assets/images/homeicon.svg",
                              alignment: Alignment.center
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 5.0),
                          child: SvgPicture.asset("assets/images/sidemenuicon.svg",
                              alignment: Alignment.center,height: 40,width: 40,
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: const Alignment(0, 100),
                // height: MediaQuery.of(context).size.height-120,
                margin: const EdgeInsets.fromLTRB(0, 90, 0, 10),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: const Text("Your Account",
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Nunito',
                                fontStyle: FontStyle.normal,
                                color: ColorConstants.txt))),
                    username == null
                        ? Container(width: 200)
                        : Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "$username",
                              style: const TextStyle(
                                  color: ColorConstants.txt,
                                  fontFamily: 'Nunito',
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            ),
                          ),
                    agegroup == null && country == null && flagicon == null
                        ? Container(
                            width: 10,
                          )
                        : Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              width: 300,
                              alignment: Alignment.centerLeft,
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "$agegroup",
                                    style: const TextStyle(
                                        color: ColorConstants.txt,
                                        fontFamily: 'Nunito',
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14),
                                    textAlign: TextAlign.left,
                                  ),
                                  Container(
                                      width: 10,
                                      alignment: Alignment.centerLeft,
                                      child:
                                          const VerticalDivider(color: Colors.black)),
                                  // Text("|"),
                                  SizedBox(
                                    width: 150,
                                    child: Row(
                                      children: [
                                        Container(
                                            height: 20,
                                            width: 20,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: CircleAvatar(
                                              radius: 20.0,
                                              backgroundImage:
                                                  NetworkImage("$flagicon"),
                                              backgroundColor:
                                                  Colors.transparent,
                                            )),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Text(
                                              "$country",
                                              style: const TextStyle(
                                                  color: ColorConstants.txt,
                                                  fontSize: 14,
                                                  fontFamily: 'Nunito',
                                                  fontStyle: FontStyle.normal),
                                              textAlign: TextAlign.left,
                                            ),
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
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  leading: Image.asset(
                                    "assets/images/your_page1.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  title: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const YourPage()));
                                      },
                                      child: const Text(
                                        "YOUR PAGE",
                                        style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontFamily: 'Nunito',
                                            fontStyle: FontStyle.normal),
                                      )),
                                )),
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
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  leading: SvgPicture.asset("assets/images/notifiyicon.svg",
                                    alignment: Alignment.center,height: 25,width: 25,color:Colors.grey,
                                  ),
                                  title: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const NotificationScreen()));
                                      },
                                      child: const Text(
                                        "NOTIFICATIONS",
                                        style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontFamily: 'Nunito',
                                            fontStyle: FontStyle.normal),
                                      )),
                                )),
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
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  leading: SvgPicture.asset("assets/images/settingicon.svg",
                                    alignment: Alignment.center,height: 25,width: 25,color:Colors.grey,
                                  ),
                                  title: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ManageContactScreen()));
                                      },
                                      child: const Text(
                                        "MANAGE CONTACTS",
                                        style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontFamily: 'Nunito',
                                            fontStyle: FontStyle.normal),
                                      )),
                                )),
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
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  leading:SvgPicture.asset("assets/images/personalimg.svg",
                                    alignment: Alignment.center,height: 25,width: 25,color:Colors.grey,
                                  ),
                                  title: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PersonalInfoScreen()));
                                      },
                                      child: const Text(
                                        "PERSONAL INFORMATION",
                                        style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontFamily: 'Nunito',
                                            fontStyle: FontStyle.normal),
                                      )),
                                )),
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
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  leading: Image.asset(
                                    "assets/images/change_password.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  title: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ChangepasswordScreen()));
                                      },
                                      child: const Text(
                                        "CHANGE PASSWORD",
                                        style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontFamily: 'Nunito',
                                            fontStyle: FontStyle.normal),
                                      )),
                                )),
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
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  leading: SvgPicture.asset("assets/images/privacyicon.svg",
                                    alignment: Alignment.center,height: 25,width: 25,color:Colors.grey,
                                  ),
                                  title: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PrivacyPage()));
                                      },
                                      child: const Text(
                                        "PRIVACY",
                                        style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontFamily: 'Nunito',
                                            fontStyle: FontStyle.normal),
                                      )),
                                )),
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
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  leading: SvgPicture.asset("assets/images/invitefriend.svg",
                                    alignment: Alignment.center,height: 25,width: 25,color:Colors.grey,
                                  ),
                                  title: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const InviteContactScreen()));
                                      },
                                      child: const Text(
                                        "INVITE FRIENDS",
                                        style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontFamily: 'Nunito',
                                            fontStyle: FontStyle.normal),
                                      )),
                                )),
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
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  leading: Image.asset(
                                    "assets/images/payment_setting.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  title: GestureDetector(
                                      onTap: () {
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>  BarChartDemo()));
                                      },
                                      child: const Text(
                                        "PAYMENTS",
                                        style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontFamily: 'Nunito',
                                            fontStyle: FontStyle.normal),
                                      )),
                                )),
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
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  leading:  SvgPicture.asset("assets/images/helpicon.svg",
                                    alignment: Alignment.center,height: 25,width: 25,color:Colors.grey,
                                  ),
                                  title: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HelpPage()));
                                      },
                                      child: const Text(
                                        "HELP",
                                        style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontFamily: 'Nunito',
                                            fontStyle: FontStyle.normal),
                                      )),
                                )),
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
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  leading: Image.asset(
                                    "assets/images/about.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  title: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AboutUsPage(
                                                      title: 'ABOUT US',
                                                      url:
                                                          'https://www.cultre.in/our-team',
                                                    )));
                                      },
                                      child: const Text(
                                        "ABOUT",
                                        style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontFamily: 'Nunito',
                                            fontStyle: FontStyle.normal),
                                      )),
                                )),
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
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListTile(
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  leading: Image.asset(
                                    "assets/images/share1.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  title: GestureDetector(
                                      onTap: () {
                                        Share.share(
                                            'https://cultre.app/cul.tre/2',
                                            subject: 'share');
                                        //Share.shareFiles(['${directory.path}/image.jpg'], text: 'Great picture');
                                      },
                                      child: const Text(
                                        "SHARE",
                                        style: TextStyle(
                                            color: ColorConstants.txt,
                                            fontFamily: 'Nunito',
                                            fontStyle: FontStyle.normal),
                                      )),
                                )),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Nunito',
                                  fontStyle: FontStyle.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
