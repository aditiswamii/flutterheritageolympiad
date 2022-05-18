import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/modal/badgeresponse/GetBadgeResponse.dart';
import 'package:flutterheritageolympiad/modal/xpgainchart/GetXPGainChartResponse.dart';

import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:convert' as convert;

import '../../../modal/userprofile/GetContactProfileResponse.dart';
import '../../../modal/userprofile/GetUserProfileResponse.dart';
import '../../../utils/StringConstants.dart';
import '../managecontacts/managecontacts.dart';
class ContactPage extends StatefulWidget{
var contactid;
   ContactPage({Key? key,required this.contactid}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}


class _ContactPageState extends State<ContactPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController numquizcontroller = TextEditingController();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var agegroup;
  var flagicon;
  var prodata;
  var data;
  var datab;
  var xpdata;
  var leaderdata;
  var badgedata;
  var deletedata;
  Contact? userprofileresdata;
  var snackBar;
  List<num>? xplist;
  GetBadgeResponse? badgeResponse;
  final List<String> goallist = <String>['Monthly', 'Weekly','Daily']; //for goal list
  var goalname; // selected goal
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });

    getUserProfile(userid.toString(),widget.contactid);

  }
  getUserProfile(String userid,String contactid) async {

    showLoaderDialog(context);
    http.Response response =
    await http.post(
        Uri.parse(StringConstants.BASE_URL + "user_profile"),body: {
      'user_id':userid.toString(),
      'contact_id':contactid.toString()
    });

    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      //final responseJson = json.decode(response.body);//store response as string
      setState(() {
        prodata = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(prodata.length);
        print(prodata.toString());
        print("profileuserdata"+prodata['contact'].toString());
        onsuccess(prodata['contact']);
      });

      var venam = jsonDecode(data!)['data'];
      print(venam);
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }

  }
  onsuccess(jsonDecode){
    if(jsonDecode!=null){
      setState(() {
        // userprofileresdata=jsonDecode;
        username="${jsonDecode['name'][0].toUpperCase() + jsonDecode['name'].substring(1)}";
        country="${jsonDecode['country']}";
        profilepic=jsonDecode['image'].toString();
        agegroup=jsonDecode['age_group'].toString();
        flagicon=jsonDecode['flag_icon'].toString();
      });
      print("flagicon"+flagicon);
      xpgainchart(userid.toString(), "");
      getbadges(userid.toString(), "");
    }
  }
  deleteApi(String userid,String deleteid) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "deleteuser"),
        body: {
          'user_id': userid.toString(),
          'delete_id':deleteid.toString()
        });
    showLoaderDialog(context);

    print("getUserlistapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        deletedata = jsonResponse[
        'data'];
        print("data" + deletedata.toString());
        //get all the data from json string superheros
        print("length" + deletedata.length.toString());
         ondeletesuccess();

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
ondeletesuccess(){
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => ManageContactScreen()));
}
  xpgainchart(String userid,String contactid) async {
    showLoaderDialog(context);
    http.Response response =
    await http.post(
        Uri.parse(StringConstants.BASE_URL + "xpgainchart"),body: {
      'user_id':userid.toString(),
      'contact_id':contactid.toString()
    });

    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          xpdata = jsonResponse; //get all the data from json string superheros
          print(xpdata.length);
          print(xpdata.toString());
          print("mnth : " + jsonResponse['data']['mnth'].toString());
          print("totalxp" + jsonResponse['data']['totalxp'].toString());
          print("max" + jsonResponse['data']['max'].toString());
          print("totalquiz" + jsonResponse['data']['totalquiz'].toString());

          onxpsuccess(xpdata);
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      }else{
        snackBar =
            SnackBar(
              content: Text(
                  jsonResponse['message']),
            );
        ScaffoldMessenger
            .of(context)
            .showSnackBar(
            snackBar);
      }
    }else {
      Navigator.pop(context);
      print(response.statusCode);
    }

  }
  onxpsuccess(xpdata){
    //  xplist=List.from(xpdata['data']['mnth']);
    print("mnth : "+xpdata['data']['mnth'].toString());
    print("userdata"+ xpdata['data']['totalxp'].toString());
    print("userdata"+ xpdata['data']['max'].toString());
    print("userdata"+ xpdata['data']['totalquiz'].toString());

  }

  getbadges(String userid,String contactid) async {
    showLoaderDialog(context);
    http.Response response =
    await http.post(
        Uri.parse(StringConstants.BASE_URL + "badges"),body: {
      'user_id':userid.toString(),
      'contact_id':contactid.toString()
    });

    if (response.statusCode == 200) {
      Navigator.pop(context);
      datab = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          badgedata = jsonResponse['data']; //get all the data from json string superheros
          print(badgedata.length);
          print(badgedata.toString());


          // onbadgesuccess(badgedata);
          onbadgesuccess(getBadgeResponseFromJson(datab));
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      }else{
        snackBar =
            SnackBar(
              content: Text(
                  jsonResponse['message']),
            );
        ScaffoldMessenger
            .of(context)
            .showSnackBar(
            snackBar);
      }
    }else {
      Navigator.pop(context);
      print(response.statusCode);
    }

  }
  onbadgesuccess(GetBadgeResponse badgeResponseFromJson){
    //  xplist=List.from(xpdata['data']['mnth']);
    if(badgeResponseFromJson!=null)
      print("badgedata : "+badgeResponseFromJson.data.toString());


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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ManageContactScreen()));
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
      //resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(color: Colors.white.withAlpha(100),
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
                                  builder: (context) => WelcomePage()));
                        },
                        child: Card(
                          child: Image.asset(
                              "assets/images/home_1.png", height: 40, width: 40),
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
                        child: Image.asset(
                            "assets/images/side_menu_2.png", height: 40,
                            width: 40),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white70,
                  child: ListBody(
                    children: [
                      xpdata==null?Container(): Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child:  Text(username, style: TextStyle(
                              fontSize: 24, color: Colors.black))),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                            "You can find about your performanc, your goals, and your achievements here.",
                            style: TextStyle(fontSize: 15,
                                color: ColorConstants.txt)
                        ),
                      ),
                      xpdata==null?Container():  ListBody(
                        children: [
                          Card(
                            child: Column(
                              children: [
                                Container( margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.yellow_ques,
                                    ),
                                    child: Column(
                                      children: [
                                       GestureDetector(
                                         onTap: (){
                                           deleteApi(userid.toString(), widget.contactid);
                                         },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                              height: 30,width: 30,
                                              alignment: Alignment.topLeft,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle
                                              ),
                                              child: Image.asset("assets/images/delete.png",height: 30,width: 30,),
                                            ),
                                          ),
                                        ),
                                        Container(alignment: Alignment.center,
                                          child: Container(
                                            height: 100,width: 100,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                color: ColorConstants.yellow_ques,
                                                shape: BoxShape.circle
                                            ),
                                            child: Container(  width: MediaQuery.of(context).size.width,
                                              height: 100,
                                              child: CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  child:ClipOval(child: Image.network(profilepic,height: 100,width: 100,fit: BoxFit.cover,))
                                              ),
                                            ),
                                          ),
                                        ),


                                      ],
                                    )
                                ),
                                Container( width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  child: Text("${username}",style: TextStyle(
                                      color: ColorConstants.txt,
                                      fontSize: 16,fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,),
                                ),
                                username==null?Container():
                                Container(  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Text("${agegroup}",style: TextStyle(
                                          color: ColorConstants.txt,
                                          fontSize: 14),
                                        textAlign: TextAlign.center,),
                                      VerticalDivider(color: Colors.black),
                                      // Text("|"),
                                      Row(
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

                                          Text("${country}",style: TextStyle(
                                              color: ColorConstants.txt,
                                              fontSize: 14),
                                            textAlign: TextAlign.center,),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container( margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: ColorConstants.red,
                                      onPrimary: Colors.white,
                                      elevation: 3,
                                      alignment: Alignment.center,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30.0)),
                                      fixedSize: const Size(140, 40),
                                      //////// HERE
                                    ),
                                    onPressed: () {
                                       deleteApi(userid.toString(), widget.contactid);
                                    },
                                    child: const Text(
                                      "Remove Contact",
                                      style: TextStyle(
                                          color: ColorConstants.lightgrey200, fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Card(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("YOUR BADGES",style: TextStyle(
                                        color: ColorConstants.txt,
                                        fontSize: 16)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("XP GAIN OVER TIME",style: TextStyle(
                                        color: ColorConstants.txt,
                                        fontSize: 16)),
                                  ),
                                  // xplist==null?Container():  Container(
                                  //     child: SfSparkLineChart(data:xplist,color: Colors.black,))
                                  //
                                ],
                              ),
                            ),
                          ),
                          Container( margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Center(
                              child: ElevatedButton(
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
                                          builder: (context) => ManageContactScreen()));
                                },
                                child: const Text(
                                  "GO BACK",
                                  style: TextStyle(
                                      color: ColorConstants.lightgrey200, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )


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

