import 'dart:convert';
import 'dart:math';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/questionpageview/mcq.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/classicmodelink/classicmodelink.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/classicquiz_main.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/cquizrule/classicquizrule_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/invitecontact/classicmodeplayer.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodelink/duelmodelink.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodemain/duelmode_main.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodeselectplayer/duelmodeplayer.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';

import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

import '../questionpageview/questions.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ClassicQuizRule(),
  ));
}

class ClassicQuizRule extends StatefulWidget {
  const ClassicQuizRule({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ClassicQuizRule> implements ClassicQuizRuleView{
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool value = false;
  String? data;
  var domains_length;
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    getData('1','2');
  }
  void getData(String quiz_type_id, quiz_speed_id) async {
    http.Response response =
    await http.post(Uri.parse("http://3.108.183.42/api/quiz_rules"),
        body: {
          'quiz_type_id': quiz_type_id.toString(),
          'quiz_speed_id': quiz_speed_id.toString()
        });
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        domains_length = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(domains_length.length); // just printed length of data
      });
      var venam = jsonDecode(data!)['data'];
      print(venam);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>ClassicQuizMain()));
    print(BackButtonInterceptor.describe()); // Do some stuff.
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
            image: AssetImage("assets/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children:<Widget> [

              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                  child: const Text("CLASSIC QUIZ",
                      style: TextStyle(
                          fontSize: 24, color: ColorConstants.Omnes_font))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: const Text("RULES",
                      style: TextStyle(
                          fontSize: 24, color: ColorConstants.Omnes_font))),

              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: const BoxDecoration(color: Colors.white),
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
                        : domains_length.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container( margin:  EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Expanded(child: Text("${index+1})""${jsonDecode(data!)['data'][index]}")));
                    },
                  ),
                ),
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
                                builder: (context) => ClassicQuizMain()));
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
                                builder: (context) =>  Mcq()));
                      },
                      child: const Text(
                        "START",
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

  @override
  void onSuccess(List jsonResponse) {
    ListView _quizrule(data) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return (data[index].position);
          });
    }
  }



}

//Container( margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                     child: ExpansionTileCard(
//                       // initiallyExpanded: false,
//
//                       onExpansionChanged: (value){
//                         setState(() {
//                           _expanded5=value;
//                         });
//                       },
//                       animateTrailing: true,
//                       baseColor: ColorConstant.appbar,
//                        expandedColor: _expanded5!=false?ColorConstant.background:ColorConstant.yellow_light,
//                       trailing:
//                       _expanded5!=false?Image.asset('assets/images/minus.png',height: 40,width: 40,color: ColorConstant.appbar,)
//                           :Image.asset('assets/images/plus.png',height: 40,width: 40,color: ColorConstant.yellow_light,),
//                       //key: cardB,
//                       title:  Text("Gymnasium",style: TextStyle(color:_expanded5!=false?ColorConstant.appbar:ColorConstant.yellow_light,fontSize: 18 ),),
//                       // subtitle: Text('It has the GFG Logo.'),
//                       children: <Widget>[
//                         Divider(
//                           thickness: 1.0,
//                           height: 1.0,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color:ColorConstant.background,
//                           ),
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16.0,
//                                 vertical: 8.0,
//                               ),
//                               child: ListBody(
//                                 children: [
//                                   Text("-> CVAS,Bikaner",style: TextStyle(color:ColorConstant.appbar,fontSize: 18 ),),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//
//                     ),
//                   ),