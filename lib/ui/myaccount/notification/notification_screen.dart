import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/modal/getnotificationresponse/GetNotificationResponse.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../utils/StringConstants.dart';
class NotificationScreen extends StatefulWidget{

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}


class _NotificationScreenState extends State<NotificationScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var data;
  var gnotidata;
  var updata;
  var notifyid="";
  int ischecked=0;
  List<Data>? getnotidata;
  var snackBar;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });

    getnotification(userid.toString());
  }
  updatenotify(String userid, String notifications_id) async {
    showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL + "notification"), body: {
      'user_id': userid.toString(),
      'notifications_id': notifications_id.toString()
    });

    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      //final responseJson = json.decode(response.body);//store response as string
      setState(() {
        updata = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(updata.length);
      });
      var venam = jsonDecode(data!)['data'];
      print(venam);
      //last_id

    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }

  }
  getnotification(String userid) async {

    http.Response response = await http.get(
        Uri.parse(StringConstants.BASE_URL+"notification/"+userid)
    );
    showLoaderDialog(context);
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      data = response.body;
      Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        setState(() {
          gnotidata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(gnotidata.length);
        });
        onsuccess(getNotificationResponseFromJson(data).data);
        var venam = gnotidata(data!)['data'];
        print(venam.toString());
      } else {
        onsuccess(null);
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      // onsuccess(null);
      print(response.statusCode);
    }

  }
  onsuccess(List<Data>? list){

    setState(() {
      getnotidata=list ;
    });
    print(getnotidata.toString());
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
      barrierDismissible: false,
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
        MaterialPageRoute(builder: (BuildContext context) => MyAccountPage()));
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
                  color: Colors.white70,
                  child: ListBody(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                          child: const Text("NOTIFICATIONS", style: TextStyle(
                              fontSize: 24, color: Colors.black))),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                            "You have 50 contacts.You may remove,\nblock or report them",
                            style: TextStyle(fontSize: 15,
                                color: ColorConstants.txt)
                        ),
                      ),
                      gnotidata==null? Center(
                        child: Container(

                        ),
                      )
                          :  Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child:ListBody(
                                  children: [
                                    Container(
                                            child: ListView.builder(
                                                physics: ClampingScrollPhysics(
                                                    parent:
                                                    BouncingScrollPhysics()),
                                                shrinkWrap: true,
                                                itemCount:getnotidata!.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                    int index) {
                                                  return
                                                    Column(
                                                      children: [
                                                        Container(
                                                         alignment: Alignment.centerLeft,
                                                          child:  Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                    getnotidata![index].title!,
                                                                    style:
                                                                    TextStyle(fontSize: 18),
                                                                  ),
                                                             GestureDetector(
                                                               onTap: (){

                                                               },
                                                                child: Container(
                                                                  width: 20,
                                                                  height: 20,
                                                                  child: Image.asset(
                                                                    "assets/images/question.png",
                                                                    height: 20,
                                                                    width: 20,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),

                                                        ),
                                                        Divider(
                                                          color: Colors.grey,
                                                        ),
                                                        Container(
                                                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                          child: ListView.builder(
                                                              physics: ClampingScrollPhysics(
                                                                  parent:
                                                                  BouncingScrollPhysics()),
                                                              shrinkWrap: true,
                                                              itemCount:getnotidata![index].data!.length,
                                                              itemBuilder:
                                                                  (BuildContext context,
                                                                  int index1) {
                                                                return
                                                                  Column(
                                                                    children: [
                                                                      Container(
                                                                        alignment: Alignment.centerLeft,
                                                                        child:  Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              getnotidata![index].data![index1].title!,
                                                                              style:
                                                                              TextStyle(fontSize: 18),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: (){
                                                                              //  ischecked= getnotidata![index].data![index1].isChecked!;
                                                                                //  if((getnotidata![index].data![index1].isChecked!)==0){
                                                                                //
                                                                                //    setState(() {
                                                                                //      ischecked=1;
                                                                                //   });
                                                                                //
                                                                                // }else{
                                                                                //   setState(() {
                                                                                //     ischecked=0;
                                                                                //   });
                                                                                //
                                                                                // }
                                                                              },
                                                                              child: getnotidata![index].data![index1].isChecked== 0?Container(
                                                                                width: 20,
                                                                                height: 20,
                                                                                child: Image.asset(
                                                                                  "assets/images/check_box.png",
                                                                                  height: 20,
                                                                                  width: 20,
                                                                                ),
                                                                              ):Container(
                                                                                width: 20,
                                                                                height: 20,
                                                                                child: Image.asset(
                                                                                  "assets/images/check_box_with_tick.png",
                                                                                  height: 20,
                                                                                  width: 20,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),

                                                                      ),
                                                                    ],
                                                                  );

                                                              }),
                                                        )
                                                      ],
                                                    );

                            }),
                                    )
                          ]),

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
                                    color: ColorConstants.lightgrey200, fontSize: 14),
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
                                updatenotify(userid.toString(), notifyid);
                              },
                              child: const Text(
                                "LET'S GO!",
                                style: TextStyle(
                                    color: ColorConstants.lightgrey200, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
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

