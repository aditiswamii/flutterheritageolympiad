import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';


void main() {

  runApp(const MaterialApp(

    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}
class LoginPage extends StatefulWidget{

  const LoginPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<LoginPage> {
  bool _passwordVisible=false;
  bool value = false;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
     body:Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/whitebg.png"),
    fit: BoxFit.cover,
    ),
    ),
    child: Container(
    margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
     child:Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
              child: const Text("LOG IN",style: TextStyle(fontSize: 24,color: ColorConstants.Omnes_font))),
          Flexible(child:
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: TextField(
              obscureText: false,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Username or Email ID',
                hintText: 'Username or Email ID',
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter
              ],
            ),
          ),),
          Flexible(child:
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child:TextFormField(
              obscureText: !_passwordVisible,
               obscuringCharacter: "*",
               decoration: InputDecoration(
                // hasFloatingPlaceholder: true,
             filled: true,
                fillColor: Colors.white.withOpacity(0.5),
               labelText: "Password",
                suffixIcon: GestureDetector(
                onTap: () {
                 setState(() {
                _passwordVisible = true;
                 });
                 },
                   onPanCancel: () {
                  setState(() {
                   _passwordVisible = false;
                   });
                   },
                 child: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off),
                     ),
                     ),
              validator: (value) {
                   if (value!.isEmpty) {
                  return "*Password needed";
                      }
                         },
    // onSaved: (value) {
    // _setPassword(value);
    // },
    ),),),

          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
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
                    fixedSize: const Size(150, 50),
                    //////// HERE
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text(
                    "LET'S GO",
                    style: TextStyle(color: ColorConstants.Omnes_font, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text("Remember Me"),
                Checkbox( value: this.value,
                  onChanged: (value) {
                    setState(() {
                      this.value=true;
                    });
                  },)
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text("I don't have an account",style: TextStyle(decoration: TextDecoration.underline,color: ColorConstants.Omnes_font),)),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: const Divider(
              color: ColorConstants.Omnes_font,
              height: 2,
              indent: 10,
              endIndent: 10,
              thickness: 2,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: BoxDecoration(
                color: Colors.white),
             child: Card(
               shape: RoundedRectangleBorder(
                      // if you need this
                 side: BorderSide(
                color: Colors.grey.withOpacity(0.3),
                   width: 1,
                  ),
                 ),
              child: ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),

                minLeadingWidth: 30,
                trailing:  Image.asset("assets/google_plus.png",width: 20,height: 20,alignment: Alignment.center,color: ColorConstants.Omnes_font),
                title: Text('Sign in with Google',style:TextStyle(fontSize: 15,color: ColorConstants.Omnes_font,)),
                onTap: () {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => const LeadStats()));
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: BoxDecoration(
                color: Colors.white),
            child: Card(
              shape: RoundedRectangleBorder(
                // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),

                minLeadingWidth: 30,
                trailing:  Image.asset("assets/facebook.png",width: 20,height: 20,alignment: Alignment.center,color: ColorConstants.Omnes_font),
                title: Text('Sign in with Facebook',style:TextStyle(fontSize: 15,color: ColorConstants.Omnes_font,)),
                onTap: () {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => const LeadStats()));
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: BoxDecoration(
                color: Colors.white),
            child: Card(
              shape: RoundedRectangleBorder(
                // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),

                minLeadingWidth: 30,
                trailing:  Image.asset("assets/twitter.png",width: 20,height: 20,alignment: Alignment.center,color: ColorConstants.Omnes_font),
                title: Text('Sign in with Twitter',style:TextStyle(fontSize: 15,color: ColorConstants.Omnes_font,)),
                onTap: () {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => const LeadStats()));
                },
              ),
            ),
          ),
        ],
      ),
    ),),
    );
  }
}

