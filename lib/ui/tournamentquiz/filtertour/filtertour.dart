import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';

import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/tournamentquiz/tournament_quiz.dart';
import 'package:CultreApp/utils/stringconstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../modal/Domains.dart';

import 'dart:convert' as convert;

class FilterTour extends StatefulWidget {
  FilterTour({Key? key}) : super(key: key);

  @override
  _FilterTourState createState() => _FilterTourState();
}

class _FilterTourState extends State<FilterTour> with ChangeNotifier {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var data;
  var domains_length;
  var domains_rev;
  var domainnamelist = [].toList(growable: true);
  String seldomain = "";
  String domain = "";
  var selectedIndexes = [];
  static const int _len = 11;
  var domainname;
  bool allselect = false;
  List<bool> isChecked = List.generate(_len, (index) => false);
  var ftype = 0;
  var tangible = 1;
  var intangible = 0;
  var natural = 0;

  int qsellall = 0;
  int weekly = 0;
  int monthly = 0;
  int special = 0;
  int hourly = 0;
  String themes = "";
  String contents = "";
  var click = false;
  List<Domain>? databean = [].cast<Domain>().toList(growable: true);
  List<Domain>? clist = [].cast<Domain>().toList(growable: true);
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

  var snackbar;
  var domaindata;
  void getDomains(String themeId) async {
    databean!.clear();
    http.Response response = await http.get(
        Uri.parse("${StringConstants.BASE_URL}feed_domains?theme_id=$themeId"));
    // showLoaderDialog(context);
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 200) {
        seldomain == "";
        databean!.clear();
        //store response as string
        setState(() {
          domaindata = jsonResponse;
          print(domaindata['data'].length); // just printed length of data
        });
        List? jsarray = List.from(domaindata['data']);
        setState(() {
          jsarray;
        });
        if (jsarray.isNotEmpty) {
          var sobj = Domain(0, "Select All", true);

          //clist!.add(sobj);
          setState(() {
            clist!.add(sobj);
          });
          for (int i = 0; i < jsarray.length; i++) {
            var jobj = jsarray[i];
            var sobj = Domain(jobj['id'], jobj['name'], true);

            // clist!.add(sobj);
            setState(() {
              clist!.add(sobj);
            });
          }
          setDomain(clist);
        } else {
          snackbar = const SnackBar(
              content: Text(
            "domain data is not available",
            textAlign: TextAlign.center,
          ));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        snackbar = SnackBar(
            content: Text(
          jsonResponse['message'].toString(),
          textAlign: TextAlign.center,
        ));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } else {
      // Navigator.pop(context);
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }

  int i = 0;
  var seldomainName = "";
  setDomain(List<Domain>? clist) {
    for (i; i < clist!.length; i++) {
      if (seldomain.toString().isNotEmpty) {
        setState(() {
          seldomain = "$seldomain,${clist[i].id}";
          seldomainName = "$seldomainName\n${clist[i].name}";
        });
      } else {
        setState(() {
          seldomain = "$seldomain${clist[i].id}";
          seldomainName = "$seldomainName${clist[i].name}";
        });
      }
    }
    // cleanData();
    // databean!.addAll(clist!);
    if (clist != null) {
      setState(() {
        databean = clist;
      });
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => TournamentPage(
              seldomain: "",
              themes: "",
              contents: "",
            )));
    // Do some stuff.
    return true;
  }

  hintdialog(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Text(
        "$text",
        style: const TextStyle(color: ColorConstants.txt, fontSize: 18),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"))
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  calTheme() async {
    themes = "";
    if (tangible == 1) {
      if (themes.contains("1")) {
        setState(() {
          themes.replaceAll("1", "");
        });
      } else {
        setState(() {
          themes += "1";
        });
      }

      if (kDebugMode) {
        print(themes);
      }
      getDomains(themes);
    }
    if (natural == 1) {
      if (themes.isNotEmpty) {
        if (themes.contains("2")) {
          setState(() {
            themes.replaceAll("2", "");
          });
        } else {
          setState(() {
            themes += ",2";
          });
        }
      } else {
        setState(() {
          themes += "2";
        });
      }
      if (kDebugMode) {
        print(themes);
      }
      getDomains(themes);
    }
    if (intangible == 1) {
      if (themes.isNotEmpty) {
        if (themes.contains("3")) {
          setState(() {
            themes.replaceAll("3", "");
          });
        } else {
          setState(() {
            themes += ",3";
          });
        }
      } else {
        setState(() {
          themes += "3";
        });
      }
      if (kDebugMode) {
        print(themes);
      }
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
      endDrawer: const MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withAlpha(100),
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(children: [
            ListBody(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                    child: const Text("FILTERS",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontFamily: "Nunito"))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          themes = "";
                          tangible = 1;
                          intangible = 0;
                          natural = 0;
                          contents = "";
                          qsellall = 0;
                          weekly = 0;
                          monthly = 0;
                          special = 0;
                          hourly = 0;
                          // single=0;
                          // collection=0;
                          // modules=0;
                          // singleb=false;
                          // collectionb=false;
                          // modulesb=false;
                          cleanData();
                          getDomains("1");
                        });
                      },
                      child: const Text("RESET ALL",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontFamily: "Nunito",
                              decoration: TextDecoration.underline)),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("THEMES",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Nunito")),
                        GestureDetector(
                          onTap: () {
                            hintdialog(context, "Themes: Choose a theme.");
                          },
                          child: SizedBox(
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
                    )),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
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
                            child: const Text("Tangible",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: "Nunito")),
                          )
                        ],
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
                              child: const Text("Natural",
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
                                calTheme();
                              },
                              child: intangible == 1
                                  ? Image.asset("assets/images/intengible.png",
                                      height: 90, width: 90)
                                  : Image.asset(
                                      "assets/images/theme_intangi_light.png",
                                      height: 90,
                                      width: 90),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: const Text("Intangible",
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
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "DOMAINS",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          hintdialog(context, "Domains: Choose a domain.");
                        },
                        child: SizedBox(
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
                domainwidget(domaindata),
                Container(
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Quiz Type",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: "Nunito")),
                        GestureDetector(
                          onTap: () {
                            hintdialog(
                                context, "Quiz Type: Choose a quiz type.");
                          },
                          child: SizedBox(
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
                    )),
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
                        GestureDetector(
                          onTap: () {
                            if (qsellall == 0) {
                              setState(() {
                                qsellall = 1;
                                weekly = 1;
                                monthly = 1;
                                special = 1;
                                hourly = 1;
                              });
                            } else {
                              setState(() {
                                qsellall = 0;
                                weekly = 0;
                                monthly = 0;
                                special = 0;
                                hourly = 0;
                              });
                            }
                          },
                          child: SizedBox(
                            height: 35,
                            child: ListTile(
                              visualDensity: const VisualDensity(
                                  vertical: -4, horizontal: -4),
                              title: const Text(
                                "Select All",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              trailing: qsellall == 1
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "assets/images/check_box_with_tick.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    )
                                  : SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "assets/images/check_box.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (hourly == 0) {
                              setState(() {
                                hourly = 1;
                              });
                            } else {
                              setState(() {
                                qsellall = 0;

                                hourly = 0;
                              });
                            }
                          },
                          child: SizedBox(
                            height: 35,
                            child: ListTile(
                              minLeadingWidth: 5,
                              visualDensity: const VisualDensity(
                                  vertical: -4, horizontal: -4),
                              leading: Image.asset("assets/images/hours24.png",
                                  height: 20, width: 20),
                              title: const Text(
                                "Daily",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              trailing: hourly == 1
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "assets/images/check_box_with_tick.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    )
                                  : SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "assets/images/check_box.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (weekly == 0) {
                              setState(() {
                                weekly = 1;
                              });
                            } else {
                              setState(() {
                                qsellall = 0;
                                weekly = 0;
                              });
                            }
                          },
                          child: SizedBox(
                            height: 30,
                            child: ListTile(
                              minLeadingWidth: 5,
                              visualDensity: const VisualDensity(
                                  vertical: -4, horizontal: -4),
                              leading: Image.asset("assets/images/week7.png",
                                  height: 20, width: 20),
                              title: const Text(
                                "Weekly",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              trailing: weekly == 1
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "assets/images/check_box_with_tick.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    )
                                  : SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "assets/images/check_box.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (monthly == 0) {
                              setState(() {
                                monthly = 1;
                              });
                            } else {
                              setState(() {
                                qsellall = 0;

                                monthly = 0;
                              });
                            }
                          },
                          child: SizedBox(
                            height: 30,
                            child: ListTile(
                              minLeadingWidth: 5,
                              visualDensity: const VisualDensity(
                                  vertical: -4, horizontal: -4),
                              leading: Image.asset("assets/images/month30.png",
                                  height: 20, width: 20),
                              title: const Text(
                                "Monthly",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              trailing: monthly == 1
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "assets/images/check_box_with_tick.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    )
                                  : SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "assets/images/check_box.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (special == 0) {
                              setState(() {
                                special = 1;
                              });
                            } else {
                              setState(() {
                                qsellall = 0;
                                special = 0;
                              });
                            }
                          },
                          child: SizedBox(
                            height: 30,
                            child: ListTile(
                              minLeadingWidth: 5,
                              visualDensity: const VisualDensity(
                                  vertical: -4, horizontal: -4),
                              leading: Image.asset(
                                  "assets/images/specials_calendar_1.png",
                                  height: 20,
                                  width: 20),
                              title: const Text(
                                "Specials",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              trailing: special == 1
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "assets/images/check_box_with_tick.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    )
                                  : SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "assets/images/check_box.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                            ),
                          ),
                        )
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
                          log("tang $tangible");
                          log("intang $intangible");
                          log("natu $natural");
                          log("themeid$themes");
                          log("contents$contents");
                          log("domainid${domainnamelist.toString().replaceAll("[", "").replaceAll("]", "")}");
                          log("seldomain$seldomain");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TournamentPage(
                                        seldomain: "",
                                        themes: "",
                                        contents: "",
                                      )));
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
                          // seldomain=domainnamelist.toString().replaceAll("[", "").replaceAll("]", "");

                          seldomain = "";
                          for (int i = 0; i < databean!.length; i++) {
                            if (!databean![i].issel!) {
                              if (databean![i].id != 0) {
                                if (seldomain.isNotEmpty) {
                                  setState(() {
                                    seldomain = "$seldomain,${databean![i].id}";
                                  });
                                } else {
                                  setState(() {
                                    seldomain = "$seldomain${databean![i].id}";
                                  });
                                }
                              }
                            }
                          }
                          if (hourly == 1) {
                            contents += "1";
                          }
                          if (weekly == 1) {
                            if (contents.isNotEmpty) {
                              contents += ",2";
                            } else {
                              contents += "2";
                            }
                          }
                          if (monthly == 1) {
                            if (contents.isNotEmpty) {
                              contents += ",3";
                            } else {
                              contents += "3";
                            }
                          }
                          if (special == 1) {
                            if (contents.isNotEmpty) {
                              contents += ",4";
                            } else {
                              contents += "4";
                            }
                          }
                          setState(() {
                            contents;
                          });
                          if (kDebugMode) {
                            print(seldomain);
                          }
                          log("tang $tangible");
                          log("intang $intangible");
                          log("natu $natural");
                          log("themeid$themes");
                          log("contents$contents");
                          log("domainid${domainnamelist.toString().replaceAll("[", "").replaceAll("]", "")}");
                          log("seldomain$seldomain");
                          //
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TournamentPage(
                                        contents: contents,
                                        seldomain: seldomain,
                                        themes: themes,
                                      )));
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
          ]),
        ),
      ),
    );
  }

  Widget domainwidget(domaindata) {
    // List<bool> isChecked = List<bool>.filled(domaindata.length, false);
    return databean == null
        ? Container()
        : Container(
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
                  ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: databean!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: domainrow(context, index, databean!.length));
                      }),
                ],
              ),
            ),
          );
  }

  Widget domainrow(BuildContext context, int index, int length) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                databean![index].name!,
                style: const TextStyle(fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  accept(index);
                },
                child: databean![index].issel == false
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          "assets/images/check_box_with_tick.png",
                          height: 20,
                          width: 20,
                        ),
                      )
                    : SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          "assets/images/check_box.png",
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
  }

  void accept(int index) {
    Domain? domain;
    if (index == 0) {
      bool? issel = !databean![0].issel!;
      for (int i = 0; i < databean!.length; i++) {
        domain = databean![i];
        domain.issel = issel;
        databean![i] = domain;
      }
      updateData(databean!.toList());
    } else {
      Domain domain = getItem(index);
      domain.issel = !domain.issel!;
      databean![index] = domain;
      updateData(databean!.toList());
    }
  }

  void updateData(List<Domain> list) {
    setState(() {
      databean!.clear();
      databean!.addAll(list);
    });

    notifyListeners(); // To rebuild the Widget
  }

  Domain getItem(int pos) {
    return databean!.elementAt(pos);
  }

  void cleanData() {
    databean!.clear();

    notifyListeners();
  }
}
