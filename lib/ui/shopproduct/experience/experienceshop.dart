import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/allexprience/GetAllExperience.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/shopproduct/shopproducts_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utils/StringConstants.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'dart:convert' as convert;

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({Key? key}) : super(key: key);

  @override
  ExperiencePageState createState() => ExperiencePageState();
}

class ExperiencePageState extends State<ExperiencePage> {
  TextEditingController controller = TextEditingController();
  // List<Data> _searchResult = [];
  // List<Data> _userDetails = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var expdata;
  List<Data>? experdata;
  var data;
  var snackBar;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });

    getExperience(userid.toString(), "");
  }

  getExperience(String userid, String searchkey) async {
    if (searchkey == null) {
      http.Response response =
          await http.get(Uri.parse(StringConstants.BASE_URL + "exp"));

      var jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        data = response.body;

        if (jsonResponse['status'] == 200) {
          setState(() {
            expdata = jsonDecode(
                data!)['data']; //get all the data from json string superheros
            if (kDebugMode) {
              print(expdata.length);
            }
          });
          onsuccess(getAllExperienceFromJson(data).data);
          var venam = jsonDecode(data!)['data'];
          if (kDebugMode) {
            print(venam);
          }
        } else {
          onsuccess(null);
          snackBar = SnackBar(
            content: Text(jsonResponse['message']),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        // onsuccess(null);
        if (kDebugMode) {
          print(response.statusCode);
        }
      }
    } else {
      http.Response response = await http
          .get(Uri.parse(StringConstants.BASE_URL + "exp?search=" + searchkey));

      var jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        data = response.body;

        if (jsonResponse['status'] == 200) {
          setState(() {
            expdata = jsonDecode(
                data!)['data']; //get all the data from json string superheros
            if (kDebugMode) {
              print(expdata.length);
            }
          });
          onsuccess(getAllExperienceFromJson(data).data);
          var venam = jsonDecode(data!)['data'];
          if (kDebugMode) {
            print(venam);
          }
        } else {
          onsuccess(null);
          snackBar = SnackBar(
            content: Text(jsonResponse['message']),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        // onsuccess(null);
        if (kDebugMode) {
          print(response.statusCode);
        }
      }
    }
  }

  onsuccess(List<Data>? list) {
    setState(() {
      experdata = list;
    });
    if (kDebugMode) {
      print(experdata.toString());
    }
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
        context, MaterialPageRoute(builder: (context) => ShopPage()));
    // Do some stuff.
    return true;
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
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
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: const MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withAlpha(100),
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Stack(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                            child: Image.asset(
                              "assets/images/home_1.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 5.0),
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
              ),
            ),
            Container(
              alignment: const Alignment(0, 100),
              // height: MediaQuery.of(context).size.height-120,
              margin: const EdgeInsets.fromLTRB(20, 90, 20, 10),
              child: ListView(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("EXPLORE",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Nunito"))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: const Text("EXPERIENCES",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Nunito"))),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text(
                      "Scroll down see all updates, search by keywords, or filter update by type.",
                      style:
                          TextStyle(fontSize: 14, color: ColorConstants.txt)),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.search),
                    title: TextFormField(
                      controller: controller,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: onSearchTextChanged,
                      decoration: const InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                    ),
                    trailing: controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              controller.clear();
                              onSearchTextChanged('');
                            },
                          )
                        : const Text(""),
                  ),
                ),
                experdata == null
                    ? Center(
                        child: Container(),
                      )
                    : Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: ListView.builder(
                            physics: const ClampingScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            shrinkWrap: true,
                            reverse: true,
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
                                      color: ColorConstants.lightgrey200,
                                      child: Image.network(
                                        experdata![index].images![0].toString(),
                                        fit: BoxFit.fill,
                                      ),
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
                                                experdata![index]
                                                    .name
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontFamily: "Nunito")),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Text(
                                                experdata![index]
                                                    .description
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontFamily: "Nunito")),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    experdata![index]
                                                        .price
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontFamily: "Nunito")),
                                                GestureDetector(
                                                    onTap: () {
                                                      Share.share(
                                                          experdata![index]
                                                              .link
                                                              .toString(),
                                                          subject:
                                                              'Share link');
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: const Text(
                                                            "REGISTER",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    "Nunito")))),
                                              ],
                                            ),
                                          ),
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

  onSearchTextChanged(String text) {
    if (text.isNotEmpty) {
      // showLoaderDialog(context);
      getExperience(userid.toString(), text);
    } else {
      // showLoaderDialog(context);
      getExperience(userid.toString(), "");
    }
    if (kDebugMode) {
      print(text);
    }
    log(text);

    setState(() {});
  }
}
