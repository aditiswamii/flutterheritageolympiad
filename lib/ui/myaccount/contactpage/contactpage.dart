import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/badgeresponse/GetBadgeResponse.dart';
import 'package:CultreApp/modal/xpgainchart/GetXPGainChartResponse.dart';

import 'package:CultreApp/ui/myaccount/myaccount_page.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
  GetXpGainChartResponse? getXpGainChartResponse;
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
      xpgainchart(userid.toString(), widget.contactid.toString());
      getbadges(userid.toString(), widget.contactid.toString());
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

          onxpsuccess(xpdata, getXpGainChartResponseFromJson(data!));
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
  onxpsuccess(xpdata,  GetXpGainChartResponse? getXpGainChartR){
    setState(() {
      getXpGainChartResponse = getXpGainChartR;
    });
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
          badgedata =
              jsonResponse; //get all the data from json string superheros
          print(badgedata.length);
          print(badgedata.toString());
          print(badgedata['data'].toString());

          // onbadgesuccess(badgedata);
          onbadgesuccess(badgedata);
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
  onbadgesuccess(badgedata){
    //  xplist=List.from(xpdata['data']['mnth']);
    if (badgedata != null) print("badgedata : " + badgedata['data'].toString());
    print("badgedata : " + badgedata['data'][0]['image'].toString());
    print("badgedata : " + badgedata['data'][0]['title'].toString());
    print("badgedata : " + badgedata['data'][0]['description'].toString());

  }
var badgedetaildata;
  getbadgedetails(String userid,String badgesId) async {

    http.Response response =
    await http.post(
        Uri.parse(StringConstants.BASE_URL + "badges_details"),body: {
      'user_id':userid.toString(),
      'badges_id':badgesId.toString()
    });

    if (response.statusCode == 200) {

      datab = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          badgedetaildata =
              jsonResponse; //get all the data from json string superheros
          print(badgedetaildata.length);
          print(badgedetaildata.toString());
          print(badgedetaildata['data'].toString());

          // onbadgesuccess(badgedata);
          onbadgedetails(badgedetaildata);
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

      print(response.statusCode);
    }

  }
  onbadgedetails(badgedetaildata){
    //  xplist=List.from(xpdata['data']['mnth']);
    if (badgedata != null) print("badgedata : " + badgedetaildata['data'].toString());
    print("badgedata : " + badgedetaildata['data']['image'].toString());
    print("badgedata : " + badgedetaildata['data']['title'].toString());
    print("badgedata : " + badgedetaildata['data']['description'].toString());
if(badgedetaildata!=null){
  AlertDialog alert = AlertDialog(
    insetPadding: EdgeInsets.all(4),
    titlePadding: EdgeInsets.all(4),
    contentPadding:EdgeInsets.all(4),
    shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(
            20.0)),
    content: Container(
      height: 180,
      width: 250,
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(20,10,20,10),
        height: 180,
        width: 250,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              height: 80,
              width: 80,
              child:
              CircleAvatar(
                radius: 30.0,
                backgroundImage:
                NetworkImage(badgedetaildata['data']['image'].toString()),
                backgroundColor: Colors.transparent,
              ),
            ),
            Text(badgedetaildata['data']['title'].toString() ,style: TextStyle(
                fontSize: 18, color: ColorConstants.txt,fontWeight: FontWeight.w600)),
            Text(badgedetaildata['data']['message'].toString(), style: TextStyle(
                fontSize: 18, color: ColorConstants.txt,),textAlign: TextAlign.center,),
          ],
        ),
      ),
    ),
  );
  showDialog(
      context: context,
      builder: (BuildContext context){
        Future.delayed(
          Duration(seconds: 3),
              () {
            Navigator.of(context).pop(true);
          },
        );
        return  alert;
      }
  );
}
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
                                  builder: (context) => HomePage()));
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
                                  ),
                                  GridView.builder(
                                      physics: ClampingScrollPhysics(
                                          parent:
                                          BouncingScrollPhysics()),
                                      itemCount:
                                      badgedata['data'].length,
                                      shrinkWrap: true,
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                      itemBuilder:
                                          (BuildContext context,
                                          int index) {
                                        return GestureDetector(
                                          onTap: (){
                                          getbadgedetails(userid.toString(),badgedata['data'][index]['id'].toString());
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width,
                                              child: Image.network(
                                                "${badgedata['data'][index]['image'].toString()}", height: 50,width: 50,),
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ),
                          xpdata == null
                              ? Container()
                              :   Card(
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
                                  Container(
                                    child: Echarts(
                                      option: '''
                                                  {
                                                    xAxis: {
                                                      type: 'category',
                                                      data: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
                                                    },
                                                    yAxis: {
                                                      type: 'value'
                                                    },
                                                    series: [{
                                                      data: [${getXpGainChartResponse!.data!.mnth![0].xp},
                                                       ${getXpGainChartResponse!.data!.mnth![1].xp},
                                                        ${getXpGainChartResponse!.data!.mnth![2].xp},
                                                         ${getXpGainChartResponse!.data!.mnth![3].xp},
                                                          ${getXpGainChartResponse!.data!.mnth![4].xp},
                                                           ${getXpGainChartResponse!.data!.mnth![5].xp},
                                                            ${getXpGainChartResponse!.data!.mnth![6].xp},
                                                            ${getXpGainChartResponse!.data!.mnth![7].xp},
                                                            ${getXpGainChartResponse!.data!.mnth![8].xp},
                                                            ${getXpGainChartResponse!.data!.mnth![9].xp},
                                                            ${getXpGainChartResponse!.data!.mnth![10].xp},
                                                            ${getXpGainChartResponse!.data!.mnth![11].xp}
                                                            ],
                                                      type: 'bar',
                                                      color: '#FBB03B'
                                                    }]
                                                  }
                                                ''',
                                    ),
                                    width: 300,
                                    height: 250,
                                  ),
                                  Container(
                                    alignment:
                                    Alignment.center,
                                    child: Text(
                                        "2022",
                                        style: TextStyle(
                                            color: ColorConstants
                                                .txt,
                                            fontSize: 16)),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
                                    alignment:
                                    Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                                xpdata['data']['totalxp'].toString(),
                                                style: TextStyle(
                                                    color: ColorConstants
                                                        .txt,
                                                    fontSize: 14)),
                                            Text(
                                                "Total XP",
                                                style: TextStyle(
                                                    color: ColorConstants
                                                        .txt,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                                xpdata['data']['totalquiz'].toString(),
                                                style: TextStyle(
                                                    color: ColorConstants
                                                        .txt,
                                                    fontSize: 14)),
                                            Text(
                                                "Quizzes Done",
                                                style: TextStyle(
                                                    color: ColorConstants
                                                        .txt,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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

