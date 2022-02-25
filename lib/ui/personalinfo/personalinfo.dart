import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/invitecontact/invitecontactlink/invitecontact_link.dart';
import 'package:flutterheritageolympiad/ui/invitecontact/phonebook/phonebook_screen.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PersonalInfoScreen(),
  ));
}

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  _PersonalinfoState createState() => _PersonalinfoState();
}

class _PersonalinfoState extends State<PersonalInfoScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color textcolor = ColorConstants.Omnes_font;
  Color textcolor1 = ColorConstants.Omnes_font;
  var selected = '';
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController  lastnamecontroller= TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController countrycontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();

  @override
  void initState() {
    // click;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool click = false;
    bool click1 = false;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      key: _scaffoldKey,
     // resizeToAvoidBottomInset: false,
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
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
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
                      margin: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                      child: const Text("PERSONAL INFORMATION",
                          style: TextStyle(
                              fontSize: 24, color: ColorConstants.Omnes_font))),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: TextFormField(
                      controller: firstnamecontroller,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        // labelText: 'Username or Email ID',
                        hintText: 'firstname',
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: TextFormField(
                      controller: lastnamecontroller,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        // labelText: 'Username or Email ID',
                        hintText: 'lastname',
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: TextFormField(
                      controller: phonecontroller,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        // labelText: 'Username or Email ID',
                        hintText: 'mobile no',
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: TextFormField(
                      controller: countrycontroller,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        // labelText: 'Username or Email ID',
                        hintText: 'country',
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: TextFormField(
                      controller: statecontroller,
                      obscureText: false,

                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        // labelText: 'Username or Email ID',
                        hintText: 'state',
                        border: InputBorder.none,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: TextFormField(
                      controller: citycontroller,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        // labelText: 'Username or Email ID',
                        hintText: 'city',
                        border: InputBorder.none,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: TextFormField(
                      controller: datecontroller,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        // labelText: 'Username or Email ID',
                        hintText: 'DOB',
                        border: InputBorder.none,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: TextFormField(
                      controller: gendercontroller,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        // labelText: 'Username or Email ID',
                        hintText: 'Gender',
                        border: InputBorder.none,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants.verdigris,
                          onPrimary: Colors.white,
                          elevation: 3,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          fixedSize: const Size(120, 30),
                          //////// HERE
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomePage()));
                        },
                        child: const Text(
                          "UPDATE",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ]),

          ),
        ),
      ),
    );
  }
}
