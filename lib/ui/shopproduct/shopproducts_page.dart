import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/shopproduct/product/product.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:CultreApp/ui/homepage/homepage.dart';
import 'experience/experienceshop.dart';

class ShopPage extends StatefulWidget {
  ShopPage({Key? key}) : super(key: key);

  @override
  ShopState createState() => ShopState();
}

class ShopState extends State<ShopPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool clickproduct = false;
  bool clickexprerience = false;
  bool clickgift = false;
  bool clickplans = false;
  var username;
  var email;
  var country;
  var profilepic;
  var userid;

  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
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
          margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
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
              color: Colors.white,
              child: ListBody(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("STAY UNIQUE,",
                        style: TextStyle(
                            fontSize: 24,
                            color: ColorConstants.txt,
                            fontFamily: "Nunito"))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: username == null
                        ? const Text("")
                        : Text(
                            "${username[0].toUpperCase() + username.substring(1)}",
                            style: const TextStyle(
                                fontSize: 24,
                                color: ColorConstants.txt,
                                fontFamily: "Nunito"))),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: const Text(
                      "You deserve to treat yourself. Find the most unique product and experience here.",
                      style:
                          TextStyle(fontSize: 14, color: ColorConstants.txt)),
                ),
              ]),
            ),
            Container(
                child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        clickproduct = true;
                        clickexprerience = false;
                        clickgift = false;
                        clickplans = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      height: 150,
                      // width: 150,
                      decoration: BoxDecoration(
                          color: clickproduct != true
                              ? ColorConstants.yellow200
                              : ColorConstants.yellow200.withAlpha(150)),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "PRODUCTS",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Nunito"),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Digital products included",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: "Nunito"),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        clickproduct = false;
                        clickexprerience = true;
                        clickgift = false;
                        clickplans = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      // padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                      height: 150,
                      //  width: 150,
                      decoration: BoxDecoration(
                          color: clickexprerience != true
                              ? ColorConstants.lightgrey200
                              : ColorConstants.lightgrey200.withAlpha(150)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "EXPERIENCE",
                            style: TextStyle(
                                color: ColorConstants.txt,
                                fontSize: 18,
                                fontFamily: "Nunito"),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Curated Events Listing",
                            style: TextStyle(
                                color: ColorConstants.txt,
                                fontSize: 12,
                                fontFamily: "Nunito"),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        clickproduct = false;
                        clickexprerience = false;
                        clickgift = true;
                        clickplans = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                      // // padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                      height: 150,
                      //   width: 100,
                      decoration: BoxDecoration(
                          color: clickgift != true
                              ? ColorConstants.red200
                              : ColorConstants.red200.withAlpha(150)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "GIFT CARDS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "Nunito"),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "From 1000 INR Onwards",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: "Nunito"),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        clickproduct = false;
                        clickexprerience = false;
                        clickgift = false;
                        clickplans = true;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                      padding: const EdgeInsets.all(5),
                      height: 150,
                      //  width: 100,
                      decoration: BoxDecoration(
                          color: clickplans != true
                              ? ColorConstants.blue200
                              : ColorConstants.blue200.withAlpha(150)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "PLANS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "Nunito"),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Purchase Restore or Upgrade",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: "Nunito"),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                ])),
            Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.white,
                    elevation: 3,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    fixedSize: const Size(120, 30),
                    //////// HERE
                  ),
                  onPressed: () {
                    if (clickproduct == true) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductList()));
                    } else if (clickexprerience == true) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExperiencePage()));
                    } else if (clickgift == true || clickplans == true) {
                      AlertDialog alert = AlertDialog(
                        alignment: Alignment.center,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(const Radius.circular(32.0))),
                        contentPadding: const EdgeInsets.only(top: 10.0),
                        title: const Text(
                          "COMING SOON",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                const Text("",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700))),
                              ],
                            ),
                          ),
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                  },
                  child: const Text(
                    "NEXT",
                    style: TextStyle(color: ColorConstants.txt, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
