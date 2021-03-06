import 'dart:convert';
import 'dart:developer';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/getprivacy/GetPrivacyResponse.dart';
import 'package:CultreApp/ui/myaccount/myaccount_page.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../utils/StringConstants.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var data;
  var gnotidata;
  int ischecked = 0;
  String PrivacyId = "";
  List<Data>? getnotidata;
  //List<Data1>? getnotidata1;
  var snackBar;
  var updata;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });

    getprivacy(userid.toString());
  }

  updateprivacy(String userid, String privacyId) async {
    showLoaderDialog(context);
    http.Response response = await http
        .post(Uri.parse("${StringConstants.BASE_URL}privacy"), body: {
      'user_id': userid.toString(),
      'privacy_id': privacyId.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          updata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(updata.length);
        });
        snackBar = SnackBar(
            content: Text(
          jsonResponse['message'].toString(),
          textAlign: TextAlign.center,
        ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        getprivacy(userid.toString());
        var venam = jsonDecode(data!)['data'];
        print(venam);
        //last_id
      } else {
        snackBar = SnackBar(
            content: Text(
          jsonResponse['message'].toString(),
          textAlign: TextAlign.center,
        ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  getprivacy(String userid) async {
    http.Response response =
        await http.get(Uri.parse("${StringConstants.BASE_URL}privacy/$userid"));
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
        onsuccess(getPrivacyResponseFromJson(data).data);
        // var venam = gnotidata(data!)['data'];
        // print(venam.toString());
      } else {
        onsuccess(null);
        snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      // onsuccess(null);
      print(response.statusCode);
    }
  }

  onsuccess(List<Data>? list) {
    setState(() {
      getnotidata = list;
    });
    print(getnotidata.toString());
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

  hintdialog(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Text(
        text,
        style: const TextStyle(color: ColorConstants.txt, fontSize: 18),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"))
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
        builder: (BuildContext context) => const MyAccountPage()));
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
      endDrawer: const MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
            Container(
              color: Colors.white70,
              child: ListBody(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: const Text("PRIVACY",
                          style: TextStyle(fontSize: 24, color: Colors.black))),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text(
                        "Edit who can or cannot see your information.",
                        style:
                            TextStyle(fontSize: 15, color: ColorConstants.txt)),
                  ),
                  gnotidata == null
                      ? Center(
                          child: Container(),
                        )
                      : Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: ListBody(children: [
                            ListView.builder(
                                physics: const ClampingScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                shrinkWrap: true,
                                itemCount: getnotidata!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              getnotidata![index].title!,
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                hintdialog(context,
                                                    "Protect yourself from unwanted interactions without having to block people. Choose who can interact with you.");
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
                                      const Divider(
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: ListView.builder(
                                            physics: const ClampingScrollPhysics(
                                                parent:
                                                    BouncingScrollPhysics()),
                                            shrinkWrap: true,
                                            itemCount: getnotidata![index]
                                                .data1!
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index1) {
                                              return ischeck(
                                                  context,
                                                  index,
                                                  index1,
                                                  getnotidata![index]
                                                      .data1!
                                                      .length);
                                            }),
                                      )
                                    ],
                                  );
                                })
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
                                    builder: (context) =>
                                        const MyAccountPage()));
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
                            PrivacyId = "";
                            for (var i = 0; i < getnotidata!.length; i++) {
                              List<Data1>? daobj = getnotidata![i].data1;
                              for (var j = 0; j < daobj!.length; j++) {
                                if (daobj[j].isChecked == 1) {
                                  if (PrivacyId.isEmpty) {
                                    PrivacyId = "${daobj[j].id}";
                                  } else {
                                    PrivacyId = "$PrivacyId,${daobj[j].id}";
                                  }
                                }
                              }
                            }
                            log(PrivacyId);
                            if (PrivacyId.isNotEmpty) {
                              updateprivacy(userid.toString(), PrivacyId);
                            } else {
                              snackBar = const SnackBar(
                                content: Text("please select privacy setting"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: const Text(
                            "SAVE",
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

  Widget ischeck(BuildContext context, int index, int index1, int length) {
    // ischecked=getnotidata![index].data![index1].isChecked!;
    // if(ischecked==0){
    //   isChecked[index1]=false;
    // }else{
    //   isChecked[index1]=true;
    // }
    // ischecked=0;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getnotidata![index].data1![index1].title!,
                style: const TextStyle(fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  if (getnotidata![index].data1![index1].isChecked == 0) {
                    for (var i = 0;
                        i < getnotidata![index].data1!.length;
                        i++) {
                      var dobj = getnotidata![index].data1![i];
                      dobj.isChecked = 0;
                      getnotidata![index].data1!.toSet();
                    }
                    getnotidata![index].data1![index1].isChecked = 1;
                  } else {
                    getnotidata![index].data1![index1].isChecked = 0;
                  }

                  log("tap${getnotidata![index].data1![index1].isChecked}");
                  // isChecked[index1]=!isChecked[index1];
                  // ischeckfun(ischecked,index,index1);
                  //
                  if (ischecked == 0) {
                    setState(() {
                      ischecked = 1;
                    });
                    log(ischecked.toString());
                  } else {
                    setState(() {
                      ischecked = 0;
                    });
                    log(ischecked.toString());
                  }
                },
                child: getnotidata![index].data1![index1].isChecked == 0
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          "assets/images/rdunselected.png",
                          height: 20,
                          width: 20,
                        ),
                      )
                    : SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          "assets/images/rdselected.png",
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
}
