import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodeinvite/steptwoinvite.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DuelModeMain(),
  ));
}

class DuelModeMain extends StatefulWidget {
  const DuelModeMain({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<DuelModeMain> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool value = false;
  List<String> _locations = ['Built Spaces',
    'Visual and Material',
    'Cultural Practices and Rituals',
    'Histories',
  'People',
  'Institutions',
  'Natural Environments']; // Option 2
   String? _selectedLocation; // Option 2


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
            image: AssetImage("assets/whitebg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children:<Widget> [
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
                  child: const Text("DUEL MODE",
                      style: TextStyle(
                          fontSize: 24, color: ColorConstants.Omnes_font))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text(
                      "Choose the domain,the difficulty and the\nspeed of the quiz",
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
              Flexible(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                    child:
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Select all",
                                style: TextStyle(
                                    color: ColorConstants.Omnes_font,
                                    fontSize: 15),
                              ),
                              Checkbox(
                                value: this.value,
                                onChanged: (value) {
                                  setState(() {
                                    this.value = true;
                                  });
                                },
                              )
                            ],
                          ),

                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Knowledge Traditions",
                                style: TextStyle(
                                    color: ColorConstants.Omnes_font,
                                    fontSize: 15),
                              ),
                              Checkbox(
                                value: this.value,
                                onChanged: (value) {
                                  setState(() {
                                    this.value = true;
                                  });
                                },
                              )
                            ],
                          ),

                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Literature and Languages",
                                style: TextStyle(
                                    color: ColorConstants.Omnes_font,
                                    fontSize: 15),
                              ),
                              Checkbox(
                                value: this.value,
                                onChanged: (value) {
                                  setState(() {
                                    this.value = true;
                                  });
                                },
                              )
                            ],
                          ),

                        ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: DropdownButton(
                      icon: Image.asset("assets/down_arrow.png",height: 20,width: 20,),
                     // hint: Text(''), // Not necessary for Option 1
                      value: _selectedLocation,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLocation = newValue as String?;
                        });
                      },
                      items: _locations.map((location) {
                        return DropdownMenuItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              new Text(location,
                                style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 15),),
                              Checkbox(
                                value: this.value,
                                onChanged: (value) {
                                  setState(() {
                                    this.value = true;
                                  });
                                },
                              )
                            ],
                          ),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),

                        // Container(
                        //   margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        //   child: Image.asset("assets/down_arrow.png",height: 20,width: 20,),
                        //
                        // ),
                      ],
                    ),
                  ),
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
                  gradient: LinearGradient(
                    colors: [ColorConstants.quiz_grad1,ColorConstants.quiz_grad2,ColorConstants.quiz_grad3]
                  ),
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("|",style: TextStyle(color: Colors.white,fontSize: 24),),
                    Text("|",style: TextStyle(color: Colors.white,fontSize: 24),),
                    Text("|",style: TextStyle(color: Colors.white,fontSize: 24),),
                    Text("|",style: TextStyle(color: Colors.white,fontSize: 24),),
                    Text("|",style: TextStyle(color: Colors.white,fontSize: 24),),
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
                      child: Text("Hard",style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 20),)),
                  GestureDetector(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const AlmostTherePage()));
                      },
                      child: Text("Intermediate",style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 20),)),
                  GestureDetector(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const AlmostTherePage()));
                      },
                      child: Text("Easy",style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 20),)),
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
                    gradient: LinearGradient(
                        colors: [ColorConstants.quiz_grad1,ColorConstants.quiz_grad2,ColorConstants.quiz_grad3]
                    ),
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("|",style: TextStyle(color: Colors.white,fontSize: 24),),
                    Text("|",style: TextStyle(color: Colors.white,fontSize: 24),),
                    Text("|",style: TextStyle(color: Colors.white,fontSize: 24),),
                    Text("|",style: TextStyle(color: Colors.white,fontSize: 24),),
                    Text("|",style: TextStyle(color: Colors.white,fontSize: 24),),
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
                      child: Text("Quickfire",style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 20),)),
                  GestureDetector(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const AlmostTherePage()));
                      },
                      child: Text("Regular",style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 20),)),
                  GestureDetector(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const AlmostTherePage()));
                      },
                      child: Text("Olympiad",style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 20),)),
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
                                builder: (context) => const DuelModeInvite()));
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

