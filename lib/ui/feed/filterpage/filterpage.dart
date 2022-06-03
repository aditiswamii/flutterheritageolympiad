import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/feed/feed.dart';
import 'package:flutterheritageolympiad/ui/feed/savedpost/savedpost.dart';

import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
import 'package:flutterheritageolympiad/utils/apppreference.dart';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../modal/domains/GetDomainsResponse.dart';

import 'dart:convert' as convert;

class FilterPage extends StatefulWidget {
  FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  TextEditingController controller = TextEditingController();
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
  var data;
  var domains_length;
  var domains_rev;
  var domainnamelist = [].toList(growable: true);
  var seldomain;
  String domain = "";
  var selectedIndexes = [];
  static int _len = 11;
  var domainname;
  bool allselect = false;
  List<bool> isChecked = List.generate(_len, (index) => false);
  var ftype = 0;
  var tangible = 1;
  var intangible = 0;
  var natural = 0;
  var single = 0;
  var modules = 0;
  var collection = 0;
  var singleb = false;
  var modulesb = false;
  var collectionb = false;
  var themes = "";
  var contents = "";
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    //calTheme();
    getDomains("$tangible");

    // getFeed(userid.toString(), "0", "", "", "");
  }

  void getDomains(String theme_id) async {
    http.Response response = await http.get(
        Uri.parse(StringConstants.BASE_URL + "feed_domains?theme_id=$theme_id"));
   // showLoaderDialog(context);
    if (response.statusCode == 200) {
      domainname="";
      domainnamelist.clear();
      isChecked.every((element) => false);
     // Navigator.pop(context);
      data = response.body; //store response as string
      setState(() {
        domains_length = jsonDecode(data!)['data'];
        domains_rev = domains_length.reversed;
        //get all the data from json string superheros
        print(domains_length.length); // just printed length of data
      });
      var jsondata = getDomainsResponseFromJson(data!).data;
      //var jsondataa=datadomainFromJson(data!).id.toString();
      log(jsondata.toString());
      var venam = jsonDecode(data!)['data'];
      log(venam.toString());
      // log("tang " + tangible.toString());
      // log("intang " + intangible.toString());
      // log("natu " + natural.toString());
      // log("themeid" + theme_id);
      // log("contents" + contents);
      //  log("domainid"+domainnamelist.toString().replaceAll("[", "").replaceAll("]", ""));
      // log("seldomain"+seldomain);
      // var text = domainnamelist.toString().replaceAll("[", "").replaceAll("]", "");
      // log(text);
    } else {
     // Navigator.pop(context);
      print(response.statusCode);
    }
  }

  // showLoaderDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     content: new Row(
  //       children: [
  //         CircularProgressIndicator(),
  //         Container(
  //             margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
  //       ],
  //     ),
  //   );
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  onsuccessfeed() {}
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
        MaterialPageRoute(builder: (BuildContext context) => FeedPage(seldomain: "", themes: "", contents: "",)));
    // Do some stuff.
    return true;
  }

  calTheme() async{
    themes = "";
    if (tangible == 1) {
      if(themes.contains("1")){
        setState(() {
          themes += "";
        });

      }else{
        setState(() {
          themes += "1";
        });
      }

      print(themes);
      getDomains(themes);
    }
    if (natural == 1) {
      if (themes.isNotEmpty) {
        if(themes.contains("2")){
          setState(() {
            themes +="";
          });

        }else{
          setState(() {
            themes += ",2";
          });

        }
        setState(() {
          themes += ",2";
        });

      } else {

        setState(() {

          themes += "2";
        });

      }
      print(themes);
      getDomains(themes);
    }
    if (intangible == 1) {
      if (themes.isNotEmpty) {
        setState(() {
          themes += ",3";
        });

      } else {
        setState(() {
          themes += "3";
        });

      }
      print(themes);
      getDomains(themes);
    }
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
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withAlpha(100),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(children: [
            Container(
              child: ListBody(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                      child: const Text("FILTERS",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontFamily: "Nunito"))),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      themes="";
                      tangible=1;
                      intangible=0;
                      natural=0;
                    });

                  },
                    child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: const Text("RESET ALL",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontFamily: "Nunito",
                                decoration: TextDecoration.underline))),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: const Text("THEMES",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: "Nunito"))),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          //margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {

                                  if (tangible == 1) {
                                    tangible = 0;
                                    setState(() {
                                      tangible = 0;
                                    });
                                  } else {
                                    tangible = 1;
                                    setState(() {
                                      tangible = 1;
                                    });
                                  }
                                  // setState(() {
                                  //   intangible = 0;
                                  //   natural = 0;
                                  //   themes = "1";
                                  // });
                                  // getDomains("$themes");
                                   calTheme();
                                },
                                child: tangible == 1
                                    ? Image.asset("assets/images/tangible.png",
                                        height: 90, width: 90)
                                    : Image.asset(
                                        "assets/images/theme_tangi_light.png",
                                        height: 90,
                                        width: 90),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text("Tangible",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontFamily: "Nunito")),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (natural == 1) {
                                    natural = 0;
                                    setState(() {
                                      natural = 0;
                                    });
                                    // calTheme();
                                  } else {
                                    natural = 1;
                                    setState(() {
                                      natural = 1;
                                    });
                                  }
                                  // setState(() {
                                  //   intangible = 0;
                                  //   tangible = 0;
                                  //   themes = "2";
                                  // });
                                 // getDomains("$themes");
                                   calTheme();
                                  // getDomains(themes);
                                },
                                child: natural == 1
                                    ? Image.asset("assets/images/natural.png",
                                        height: 90, width: 90)
                                    : Image.asset(
                                        "assets/images/theme_natural_light.png",
                                        height: 90,
                                        width: 90),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text("Natural",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontFamily: "Nunito")),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (intangible == 1) {
                                    intangible = 0;
                                    setState(() {
                                      intangible = 0;
                                    });
                                  } else {
                                    intangible = 1;
                                    setState(() {
                                      intangible = 1;
                                    });
                                  }
                                  // setState(() {
                                  //   natural = 0;
                                  //   tangible = 0;
                                  //   themes = "3";
                                  // });
                                  //
                                  // getDomains("$themes");
                                calTheme();
                                },
                                child: intangible == 1
                                    ? Image.asset(
                                        "assets/images/intengible.png",
                                        height: 90,
                                        width: 90)
                                    : Image.asset(
                                        "assets/images/theme_intangi_light.png",
                                        height: 90,
                                        width: 90),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text("Intangible",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontFamily: "Nunito")),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "DOMAINS",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            "assets/images/question.png",
                            height: 20,
                            width: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // decoration:  BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        // if you need this
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: domains_length == null || domains_length!.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    height: 35,
                                    child: CheckboxListTile(
                                        visualDensity:
                                            VisualDensity(vertical: -4),
                                        title: Text(
                                          "Select All",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        onChanged: (checked) {
                                          setState(
                                            () {
                                              isChecked.every((element) => checked!);
                                              allselect = checked!;
                                            },
                                          );
                                         // allselect = checked!;
                                        },
                                        value: allselect),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: domains_length.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Container(
                                            height: 35,
                                            child: CheckboxListTile(
                                                visualDensity:
                                                    VisualDensity(vertical: -4),
                                                title: Text(
                                                  jsonDecode(data!)['data']
                                                      [index]['name'],
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                onChanged: (checked) {
                                                  setState(
                                                    () {
                                                      isChecked[index] =
                                                          checked!;
                                                    },
                                                  );
                                                  if (isChecked[index] ==
                                                      true) {
                                                    domainname = jsonDecode(
                                                            data!)['data']
                                                        [index]['id'];

                                                    setState(() {
                                                      domainname = jsonDecode(
                                                              data!)['data']
                                                          [index]['id'];
                                                    });
                                                    if (!domainnamelist
                                                        .contains(domainname))
                                                      domainnamelist
                                                          .add(domainname);
                                                    //seldomain=domainnamelist.toString().replaceAll("[", "").replaceAll("]", "");
                                                  } else {

                                                    // if(domainnamelist.contains(domainname))
                                                    domainnamelist
                                                        .remove(domainname);

                                                  }
                                                },
                                                value: isChecked[index]),
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                  Container(
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: const Text("Content Type",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: "Nunito"))),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // decoration:  BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        // if you need this
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 35,
                            child: ListTile(
                              minLeadingWidth: 5,
                              visualDensity:
                                  VisualDensity(vertical: -4, horizontal: -4),
                              leading: Image.asset(
                                  "assets/images/single_posts.png",
                                  height: 20,
                                  width: 20),
                              title: Text(
                                "Single Posts",
                                style: TextStyle(fontSize: 14),
                              ),
                              trailing: Checkbox(
                                onChanged: (checked) {
                                  if (single == 1) {
                                    single = 0;
                                    singleb = false;
                                    setState(() {
                                      single = 0;
                                      singleb = false;
                                      if(contents.isNotEmpty){
                                        contents=contents;
                                      }else{
                                        contents="";
                                      }
                                    });
                                  } else {
                                    single = 1;
                                    singleb = true;
                                    setState(() {
                                      single = 1;
                                      singleb = true;
                                      if (contents.isNotEmpty) {
                                        contents = contents + ",1";
                                      } else {
                                        contents = "1";

                                      }

                                    });
                                  }
                                  // setState(() {
                                  //   if (contents.isNotEmpty) {
                                  //     contents = contents + ",1";
                                  //   } else {
                                  //     contents = "1";
                                  //   }
                                  // });
                                },
                                value: singleb,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Container(
                            height: 35,
                            child: ListTile(
                              minLeadingWidth: 5,
                              visualDensity:
                                  VisualDensity(vertical: -4, horizontal: -4),
                              leading: Image.asset("assets/images/modules.png",
                                  height: 20, width: 20),
                              title: Text(
                                "Modules",
                                style: TextStyle(fontSize: 14),
                              ),
                              trailing: Checkbox(
                                onChanged: (checked) {
                                  if (modules == 1) {
                                    modules = 0;

                                    setState(() {
                                      modules = 0;

                                      // if(contents.isNotEmpty){
                                      //   contents=contents;
                                      // }else{
                                      //   contents="";
                                      // }
                                    });
                                  } else {
                                    modules = 1;

                                    setState(() {
                                      modules = 1;
                                      //
                                      // if (contents.isNotEmpty) {
                                      //   contents = contents + ",2";
                                      // } else {
                                      //   contents = "2";
                                      // }

                                    });

                                  }
                                 setState(() {
                                   modulesb = checked!;
                                 });
                                  if(modulesb==true){
                                    if(contents.isNotEmpty){
                                      setState(() {
                                        if(contents.contains("2")){
                                          setState(() {
                                            contents.replaceAll(RegExp(',2'), '');
                                            contents.replaceAll(RegExp('2'), '');
                                          });

                                        }
                                        contents=contents+",2";
                                      });

                                    }else{
                                      setState(() {
                                        contents="2";
                                      });

                                    }
                                  }else{
                                      // if(contents.contains(",2")){
                                      //
                                      //   setState(() {
                                      //     contents='';
                                      //   });
                                      //
                                      // }

                                  }
                                },
                                value: modulesb,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Container(
                            height: 35,
                            child: ListTile(
                              minLeadingWidth: 5,
                              visualDensity:
                                  VisualDensity(vertical: -4, horizontal: -4),
                              leading: Image.asset(
                                  "assets/images/collections.png",
                                  height: 20,
                                  width: 20),
                              title: Text(
                                "Collections",
                                style: TextStyle(fontSize: 14),
                              ),
                              trailing: Checkbox(
                                onChanged: (checked) {
                                  if (collection == 1) {
                                    collection = 0;
                                    collectionb = false;
                                    setState(() {
                                      collection = 0;
                                      collectionb = false;
                                      if(contents.isNotEmpty){
                                        contents=contents;
                                      }else{
                                        contents="";
                                      }
                                    });
                                  } else {
                                    collection = 1;
                                    collectionb = true;
                                    setState(() {
                                      collection = 1;
                                      collectionb = true;
                                      if (contents.isNotEmpty) {
                                        contents = contents + ",3";
                                      } else {
                                        contents = "3";
                                      }
                                    });

                                  }
                                },
                                value: collectionb,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
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

    seldomain=domainnamelist.toString().replaceAll("[", "").replaceAll("]", "");
    log("tang " + tangible.toString());
    log("intang " + intangible.toString());
    log("natu " + natural.toString());
    log("themeid" + themes);
    log("contents" + contents);
    log("domainid"+domainnamelist.toString().replaceAll("[", "").replaceAll("]", ""));
    log("seldomain"+seldomain);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => FeedPage(seldomain: "", themes: "", contents: "",)));
                             },
                          child: const Text(
                            "GO BACK",
                            style: TextStyle(color: Colors.white, fontSize: 14),
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
                            seldomain=domainnamelist.toString().replaceAll("[", "").replaceAll("]", "");
                            log("tang " + tangible.toString());
                            log("intang " + intangible.toString());
                            log("natu " + natural.toString());
                            log("themeid" + themes);
                            log("contents" + contents);
                            log("domainid"+domainnamelist.toString().replaceAll("[", "").replaceAll("]", ""));
                            log("seldomain"+seldomain);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FeedPage(contents: contents, seldomain: seldomain, themes: themes,)));

                          },
                          child: const Text(
                            "LET'S GO",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
