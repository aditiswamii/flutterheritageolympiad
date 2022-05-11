import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/modal/allexprience/GetAllExperience.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
import 'package:flutterheritageolympiad/utils/apppreference.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utils/StringConstants.dart';
import '../welcomeback/welcomeback_page.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  PageController _pageController = PageController();
  // TextEditingController controller = TextEditingController();
  // List<Data> _searchResult = [];
  // List<Data> _userDetails = [];
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var feeddata;
  var data;
  int activePage = 1;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    getFeed(userid.toString(), "0", "", "", "");
  }

  getFeed(String userid, String feed_page_id, String feed_type_id,
      String domain_id, String theme_id) async {
    try {
      http.Response response =
          await http.post(Uri.parse(StringConstants.BASE_URL + "feed"), body: {
        'user_id': userid.toString(),
        'feed_page_id': feed_page_id.toString(),
        'feed_type_id': feed_type_id.toString(),
        'domain_id': domain_id.toString(),
        'theme_id': theme_id.toString()
      });
      if (response.statusCode == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          feeddata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(feeddata.length);
          // for (Map user in responseJson) {
          //   _userDetails.add(Data.fromJson(user));
          // }// just printed length of data
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
        print(jsonDecode(data!)['last_id']);
        //last_id
        print(jsonDecode(data!)['data'][0]['id']);
        print(jsonDecode(data!)['data'][0]['type']);
        print(jsonDecode(data!)['data'][0]['tags']);
        print(jsonDecode(data!)['data'][0]['title']);
        print(jsonDecode(data!)['data'][0]['description']);
        print(jsonDecode(data!)['data'][0]['external_link']);
        print(jsonDecode(data!)['data'][0]['video_link']);
        print(jsonDecode(data!)['data'][0]['placeholder_image']);
        print(jsonDecode(data!)['data'][0]['savepost']);
        print(jsonDecode(data!)['data'][0]['is_saved']);
        print(jsonDecode(data!)['data'][0]['share']);
        print(jsonDecode(data!)['data'][0]['media_type']);
        print(jsonDecode(data!)['data'][0]['media']);
        print(jsonDecode(data!)['data'][0]['media_type']);
        print(jsonDecode(data!)['data'][0]['media_type']);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  onsuccess() {}
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
        MaterialPageRoute(builder: (BuildContext context) => WelcomePage()));
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
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withAlpha(100),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 5.0),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()));
                    },
                    child: Image.asset("assets/images/home_1.png",
                        height: 40, width: 40),
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
                    child: Image.asset("assets/images/side_menu_2.png",
                        height: 40, width: 40),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              child: ListBody(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("WHAT'S NEW",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Nunito"))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(username,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Nunito"))),
                feeddata == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            shrinkWrap: true,
                            itemCount: jsonDecode(data!)['data'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  // if you need this
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: ListBody(
                                  children: [
                                    Container(
                                      height: 300,
                                      child: PageView.builder(
                                          itemCount: jsonDecode(data!)['data']
                                                  [index]['media']
                                              .length,
                                          pageSnapping: true,
                                          controller: _pageController,
                                          onPageChanged: (page) {
                                            setState(() {
                                              activePage = page;
                                            });
                                          },
                                          itemBuilder: (context, pagePosition) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          jsonDecode(data!)[
                                                                          'data']
                                                                      [index]
                                                                  ['media']
                                                              [pagePosition]),
                                                      fit: BoxFit.contain)),
                                              child: Container(
                                                margin: EdgeInsets.all(10),
                                                alignment:
                                                    Alignment.bottomCenter,
                                                height: 40,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: indicators(
                                                        jsonDecode(data!)[
                                                                    'data']
                                                                [index]['media']
                                                            .length,
                                                        activePage)),
                                              ),
                                            );
                                          }),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: ListBody(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Text(
                                                jsonDecode(data!)['data'][index]
                                                    ['title'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontFamily: "Nunito")),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Text(
                                              jsonDecode(data!)['data'][index]
                                                  ['description'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontFamily: "Nunito"),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap:(){

                                                        },
                                                        child: Container(
                                                            child: jsonDecode(data!)[
                                                                                'data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'is_saved'] !=
                                                                    1
                                                                ? Image.asset(
                                                                    "assets/images/folder_2.png",
                                                                    height: 30,
                                                                    width: 30,
                                                                    color: ColorConstants
                                                                        .lightgrey200,
                                                                  )
                                                                : Image.asset(
                                                                    "assets/images/folder.png",
                                                                    height: 30,
                                                                    width: 30,
                                                                    color: Colors
                                                                        .deepOrange,
                                                                  )),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            5, 0, 0, 0),
                                                        child: Text(
                                                            jsonDecode(data!)[
                                                                            'data']
                                                                        [index]
                                                                    ['savepost']
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: jsonDecode(data!)['data'][index][
                                                                            'is_saved'] !=
                                                                        1
                                                                    ? Colors
                                                                        .black54
                                                                    : Colors
                                                                        .deepOrange,
                                                                fontFamily:
                                                                    "Nunito")),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            // Share.share(jsonDecode(data!)['data'][index]['external_link'], subject: 'Share link');
                                                          },
                                                          child: Image.asset(
                                                            "assets/images/calendary.png",
                                                            height: 30,
                                                            width: 30,
                                                          )),
                                                      GestureDetector(
                                                          onTap: () {
                                                            Share.share(
                                                                jsonDecode(data!)[
                                                                            'data']
                                                                        [index][
                                                                    'external_link'],
                                                                subject:
                                                                    'Share link');
                                                          },
                                                          child: Image.asset(
                                                            "assets/images/exporty.png",
                                                            height: 30,
                                                            width: 30,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //  child:Event(
                                          //
                                          //  ),
                                          //)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.white : Colors.grey,
            shape: BoxShape.circle),
      );
    });
  }
// onSearchTextChanged(String text) async {
//   _searchResult.clear();
//   if (text.isEmpty) {
//     setState(() {});
//     return;
//   }
//
//   _userDetails.forEach((userDetail) {
//     if (userDetail.name!.contains(text) || userDetail.description!.contains(text))
//       _searchResult.add(userDetail);
//     print(_searchResult);
//   });
//
//   setState(() {});
// }
}
