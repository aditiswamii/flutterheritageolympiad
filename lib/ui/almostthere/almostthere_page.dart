import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/alldone/alldone.dart';
import 'package:flutterheritageolympiad/ui/signup/signup_page.dart';


void main() {

  runApp(const MaterialApp(

    debugShowCheckedModeBanner: false,
    home: AlmostTherePage(),
  ));
}
class AlmostTherePage extends StatefulWidget{

  const AlmostTherePage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<AlmostTherePage> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/whitebg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: ListView(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                    child: const Text("ALMOST THERE...",style: TextStyle(fontSize: 24,color: ColorConstants.Omnes_font))),
                Flexible(child:
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                      labelText: 'First Name*',
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                  ),
                ),),
                Flexible(child:
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                      labelText: 'Second Name*',
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                  ),
                ),),
                Flexible(child:
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                      labelText: 'Country*',
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                  ),
                ),),
                Flexible(child:
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                      labelText: 'State/Province',
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                  ),
                ),),
                Flexible(child:
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                      labelText: 'City',
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                  ),
                ),),
                Flexible(child:
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: TextField(
                    obscureText: false,
                    keyboardType: TextInputType.datetime,
                    decoration:  InputDecoration(
                      labelText: 'Date of Birth*(DD/MM/YYYY)',
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                  ),
                ),),
                Flexible(child:
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                      labelText: 'Gender',
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                  ),
                ),),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subscribe me to the monthly newsletter?",style: TextStyle(decoration: TextDecoration.underline),),
                        Checkbox( value: this.value,
                          onChanged: (value) {
                            setState(() {
                              this.value=true;
                            });
                          },)
                      ]
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.white,
                            elevation: 3,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            fixedSize: const Size(100, 50),
                            //////// HERE
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()));
                          },
                          child: const Text(
                            "BACK",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.white,
                            elevation: 3,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            fixedSize: const Size(100, 50),
                            //////// HERE
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AllDonePage()));
                          },
                          child: const Text(
                            "NEXT",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      ]
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}