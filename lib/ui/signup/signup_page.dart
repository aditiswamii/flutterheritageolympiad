import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/ui/almostthere/almostthere_page.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';

void main() {

  runApp(const MaterialApp(

    debugShowCheckedModeBanner: false,
    home: SignupPage(),
  ));
}
class SignupPage extends StatefulWidget{

  const SignupPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<SignupPage> {
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
                image: AssetImage("assets/signup_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 100, 20, 10),
              child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: const Text("SIGN UP",style: TextStyle(fontSize: 24,color: ColorConstants.Omnes_font))),
                    Flexible(child:
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        decoration:  InputDecoration(
                          filled: true,
                          hintText: 'Email ID*',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                      ),
                    ),),
                    Flexible(child:
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Username*',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                      ),
                    ),),
                    Flexible(child:
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child:TextFormField(
                        obscureText: true,
                        cursorColor: ColorConstants.Omnes_font,
                        obscuringCharacter: "*",
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          // hasFloatingPlaceholder: true,
                          hintText: 'Password*',
                      ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                      ),),
                    ),
                    Flexible(child:
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child:TextFormField(
                        obscureText: true,
                        cursorColor: ColorConstants.Omnes_font,
                        obscuringCharacter: "*",
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          // hasFloatingPlaceholder: true,
                          hintText: 'Repeat Password*',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                      ),),
                    ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("I agree to the terms and conditions*",style: TextStyle(decoration: TextDecoration.underline,color: ColorConstants.Omnes_font),),
                  Checkbox( value: value,
                    onChanged: (newvalue) {
                      setState(() {
                       value=newvalue!;
                      });
                    },)
                  ]
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
                        fixedSize: const Size(150, 50),
                        //////// HERE
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AlmostTherePage()));
                      },
                      child: const Text(
                        "NEXT",
                        style: TextStyle(color: ColorConstants.Omnes_font, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]
              ),
            ),
        ),
    );
  }
}