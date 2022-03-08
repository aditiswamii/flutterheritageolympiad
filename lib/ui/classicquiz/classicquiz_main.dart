import 'dart:convert';
import 'dart:developer';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/modal/domains/Domains.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/classicmode_invite/classicinvitepage.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/classicquiz_presenter.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/classicquiz_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodeinvite/steptwoinvite.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';

import 'cquizrule/classicquizrule.dart';

class ClassicQuizMain extends StatefulWidget {
  const ClassicQuizMain({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ClassicQuizMain> implements ClassicQuizView {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  late ClassicQuizPresenter _presenter;
  String? data;
  var domains_length;
  bool value = false;
  static int _len = 11;
  bool _expanded5 = false;
  bool click1 = false;
  bool click2 = false;
  bool click3 = false;
  bool click4 = false;
  bool click5 = false;
  bool click6 = false;
  bool click7 = false;
  bool click8 = false;
  bool click9 = false;
  bool click10 = false;
  List<bool> isChecked = List.generate(_len, (index) => false);
  String _getTitle() =>
      "Checkbox Demo : Checked = ${isChecked.where((check) => check == true).length}, Unchecked = ${isChecked.where((check) => check == false).length}";
  @override
  void initState() {
    super.initState();
    // _locations ;
    _presenter = ClassicQuizPresenter(this);
    getData();
  }

  void getData() async {
    http.Response response =
        await http.get(Uri.parse("http://3.108.183.42/api/domains"));
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        domains_length = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(domains_length.length); // just printed length of data
      });
      var venam = jsonDecode(data!)['data'][4]['name'];
      print(venam);
    } else {
      print(response.statusCode);
    }
  }

  void createquiz(String userid, quiz_type_id, difficulty_level_id,
      quiz_speed_id, domains) async {
    http.Response response =
        await http.post(Uri.parse("http://3.108.183.42/api/createquiz"), body: {
      'user_id': userid.toString(),
      'quiz_type_id': quiz_type_id.toString(),
      'difficulty_level_id': difficulty_level_id.toString(),
      'quiz_speed_id': quiz_speed_id.toString(),
      'domains': domains.toString()
    });
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        domains_length = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(domains_length.length); // just printed length of data
      });
      var userid = jsonDecode(data!)['data']['user_id'];
      var quiz_type_id = jsonDecode(data!)['data']['quiz_type_id'];
      var difficulty_level_id =
          jsonDecode(data!)['data']['difficulty_level_id'];
      var quiz_speed_id = jsonDecode(data!)['data']['quiz_speed_id'];
      var id = jsonDecode(data!)['data']['id'];
      print(userid);
    } else {
      print(response.statusCode);
    }
  }

  //final String text;
  //   SecondScreen({Key key, @required this.text}) : super(key: key);
//Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => SecondScreen(text: 'Hello',),
//     ));
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
            image: AssetImage("assets/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: <Widget>[
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
                                builder: (context) => const WelcomePage()));
                      },
                      child: Image.asset("assets/home_1.png",
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
                      child: Image.asset("assets/side_menu_2.png",
                          height: 40, width: 40),
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                  child: const Text("CLASSIC QUIZ",
                      style: TextStyle(
                          fontSize: 24, color: ColorConstants.Omnes_font))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text(
                      "Based on our Olympiad,this mode is for you to\nconstantly improve your performance",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.Omnes_font))),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "DOMAINS",
                      style: TextStyle(
                          color: ColorConstants.Omnes_font, fontSize: 15),
                    ),
                    Image.asset(
                      "assets/about.png",
                      height: 20,
                      width: 20,
                    )
                  ],
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              //   decoration: const BoxDecoration(color: Colors.white),
              //   child: Card(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(5),
              //       // if you need this
              //       side: BorderSide(
              //         color: Colors.grey.withOpacity(0.3),
              //         width: 1,
              //       ),
              //     ),
              //     child: domains_length == null || domains_length!.isEmpty
              //         ? const Center(
              //             child: CircularProgressIndicator(),
              //           )
              //         : SingleChildScrollView(
              //             child: ListView.builder(
              //               physics: const BouncingScrollPhysics(),
              //               shrinkWrap: true,
              //               itemCount: domains_length == null
              //                   ? 0
              //                   : domains_length.length,
              //               itemBuilder: (BuildContext context, int index) {
              //                 return Card(
              //                     child: CheckboxListTile(
              //                         title: Text(jsonDecode(data!)['data']
              //                             [index]['name']),
              //                         onChanged: (checked) {
              //                           setState(
              //                             () {
              //                               isChecked[index] = checked!;
              //                             },
              //                           );
              //                         },
              //                         value: isChecked[index])
              //
              //                     //controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              //
              //                     // ListTile(
              //                     //   title: Text(jsonDecode(data!)['data'][index]['name']),
              //                     //   //trailing: ,
              //                     //   //subtitle: Text(jsonDecode(data!)['data'][index]['id'].toString()),
              //                     // ),
              //                     );
              //               },
              //             ),
              //           ),
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: const BoxDecoration(color: Colors.white),
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
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: domains_length == null
                                ? 0
                                : domains_length.length % 4,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Card(
                                      child: CheckboxListTile(
                                          title: Text(jsonDecode(data!)['data']
                                              [index]['name']),
                                          onChanged: (checked) {
                                            setState(
                                              () {
                                                isChecked[index] = checked!;
                                              },
                                            );
                                          },
                                          value: isChecked[index])

                                      //controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox

                                      // ListTile(
                                      //   title: Text(jsonDecode(data!)['data'][index]['name']),
                                      //   //trailing: ,
                                      //   //subtitle: Text(jsonDecode(data!)['data'][index]['id'].toString()),
                                      // ),
                                      ),
                                  //
                                ],
                              );
                            },
                          ),
                        ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: const BoxDecoration(color: Colors.white),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: ExpansionTileCard(
                      // initiallyExpanded: false,

                      onExpansionChanged: (value) {
                        setState(() {
                          _expanded5 = value;
                        });
                      },
                      // animateTrailing: true,
                      // baseColor: ColorConstant.appbar,
                      // expandedColor: _expanded5!=false?ColorConstant.background:ColorConstant.yellow_light,
                      title: _expanded5 != false
                          ? Image.asset(
                              'assets/down_arrow.png',
                              height: 10,
                              width: 10,
                              color: ColorConstants.Omnes_font,
                            )
                          : Image.asset('assets/down_arrow_small.png',
                              height: 10,
                              width: 10,
                              color: ColorConstants.Omnes_font),
                      //key: cardB,
                      trailing: Text(
                        "",
                        style: TextStyle(
                            color: ColorConstants.Omnes_font, fontSize: 18),
                      ),
                      // // subtitle: Text('It has the GFG Logo.'),
                      // title: null,
                      children: <Widget>[
                        Divider(
                          thickness: 1.0,
                          height: 1.0,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          decoration: const BoxDecoration(color: Colors.white),
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
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: domains_length == null
                                    ?  0
                                    : domains_length.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Card(
                                          child: CheckboxListTile(
                                              title: Text(jsonDecode(data!)['data']
                                              [index]['name']),
                                              onChanged: (checked) {
                                                setState(
                                                      () {
                                                    isChecked[index] = checked!;
                                                  },
                                                );
                                              },
                                              value: isChecked[index])

                                        //controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox

                                        // ListTile(
                                        //   title: Text(jsonDecode(data!)['data'][index]['name']),
                                        //   //trailing: ,
                                        //   //subtitle: Text(jsonDecode(data!)['data'][index]['id'].toString()),
                                        // ),
                                      ),
                                      //
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "DIFFICULTY",
                      style: TextStyle(
                          color: ColorConstants.Omnes_font, fontSize: 15),
                    ),
                    Image.asset(
                      "assets/about.png",
                      height: 20,
                      width: 20,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                alignment: Alignment.centerLeft,
                height: 30,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorConstants.quiz_grad1,
                      ColorConstants.quiz_grad2,
                      ColorConstants.quiz_grad3
                    ]),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          click1=true;
                          click2=false;
                          click3=false;
                          click4=false;
                          click5=false;
                        });
                      },
                      child: click1==false?Text(
                        "|",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ):Image.asset("assets/images/trianglewhite.png"),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          click2=true;
                          click1=false;
                          click3=false;
                          click4=false;
                          click5=false;
                        });
                      },
                      child: click2==false?Text(
                        "|",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ):Image.asset("assets/images/trianglewhite.png"),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          click3=true;
                          click2=false;
                          click1=false;
                          click4=false;
                          click5=false;
                        });
                      },
                      child: click3==false?Text(
                        "|",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ):Image.asset("assets/images/trianglewhite.png"),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          click4=true;
                          click2=false;
                          click3=false;
                          click1=false;
                          click5=false;
                        });
                      },
                      child: click4==false?Text(
                        "|",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ):Image.asset("assets/images/trianglewhite.png"),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          click5=true;
                          click2=false;
                          click3=false;
                          click4=false;
                          click1=false;
                        });
                      },
                      child: click5==false?Text(
                        "|",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ):Image.asset("assets/images/trianglewhite.png"),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const AlmostTherePage()));
                      },
                      child: Text(
                        "Hard",
                        style: TextStyle(
                            color: ColorConstants.Omnes_font, fontSize: 20),
                      )),
                  GestureDetector(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const AlmostTherePage()));
                      },
                      child: Text(
                        "Intermediate",
                        style: TextStyle(
                            color: ColorConstants.Omnes_font, fontSize: 20),
                      )),
                  GestureDetector(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const AlmostTherePage()));
                      },
                      child: Text(
                        "Easy",
                        style: TextStyle(
                            color: ColorConstants.Omnes_font, fontSize: 20),
                      )),
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "QUIZ SPEED",
                      style: TextStyle(
                          color: ColorConstants.Omnes_font, fontSize: 15),
                    ),
                    Image.asset(
                      "assets/about.png",
                      height: 20,
                      width: 20,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                alignment: Alignment.centerLeft,
                height: 30,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorConstants.quiz_grad1,
                      ColorConstants.quiz_grad2,
                      ColorConstants.quiz_grad3
                    ]),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          click6=true;
                          click7=false;
                          click8=false;
                          click9=false;
                          click10=false;
                        });
                      },
                      child: click1==false?Text(
                        "|",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ):Image.asset("assets/images/trianglewhite.png"),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          click7=true;
                          click6=false;
                          click8=false;
                          click9=false;
                          click10=false;
                        });
                      },
                      child: click2==false?Text(
                        "|",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ):Image.asset("assets/images/trianglewhite.png"),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          click8=true;
                          click7=false;
                          click6=false;
                          click9=false;
                          click10=false;
                        });
                      },
                      child: click3==false?Text(
                        "|",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ):Image.asset("assets/images/trianglewhite.png"),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          click9=true;
                          click6=false;
                          click7=false;
                          click8=false;
                          click10=false;
                        });
                      },
                      child: click4==false?Text(
                        "|",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ):Image.asset("assets/images/trianglewhite.png"),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          click10=true;
                          click6=false;
                          click7=false;
                          click8=false;
                          click9=false;
                        });
                      },
                      child: click5==false?Text(
                        "|",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ):Image.asset("assets/images/trianglewhite.png"),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const AlmostTherePage()));
                      },
                      child: Text(
                        "Quickfire",
                        style: TextStyle(
                            color: ColorConstants.Omnes_font, fontSize: 20),
                      )),
                  GestureDetector(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const AlmostTherePage()));
                      },
                      child: Text(
                        "Regular",
                        style: TextStyle(
                            color: ColorConstants.Omnes_font, fontSize: 20),
                      )),
                  GestureDetector(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const AlmostTherePage()));
                      },
                      child: Text(
                        "Olympiad",
                        style: TextStyle(
                            color: ColorConstants.Omnes_font, fontSize: 20),
                      )),
                ],
              ),
              Container(
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
                                builder: (context) => const WelcomePage()));
                      },
                      child: const Text(
                        "GO BACK",
                        style: TextStyle(
                            color: ColorConstants.to_the_shop, fontSize: 14),
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ClassicQuizRule()));
                      },
                      child: const Text(
                        "LET'S GO!",
                        style: TextStyle(
                            color: ColorConstants.to_the_shop, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
