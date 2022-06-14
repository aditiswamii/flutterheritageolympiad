import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';

import 'package:CultreApp/uinew/alldonepage.dart';
import 'package:CultreApp/uinew/loginpage.dart';
import 'package:CultreApp/uinew/registerpage.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/SharedObjects.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../modal/steponeresponse/GetStepOneResponse.dart';
import '../utils/StringConstants.dart';
class Stepone extends StatefulWidget {
   Stepone({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Stepone> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatpasswordController = TextEditingController();
 var data;
 var snackbar;
  bool value = false;
  void steponeapi( String email, String username, String password) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+'stepone'),
        body: {
  'email':email.toString(),
  'username':username.toString(),
  'password':password.toString()

        });
    if (response.statusCode == 200) {
      data = response.body;
      if(getStepOneResponseFromJson(data!).status==200) {
        print(jsonDecode(data!)['success'].toString());
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String code = jsonEncode(
            getStepOneResponseFromJson(data!).data);
        prefs.setString('verifycode', code);
        prefs.setString('loggedin', "true");


        signup(getStepOneResponseFromJson(data!).data);
      }else{
      snackbar = SnackBar(
          content: Text(
              getStepOneResponseFromJson(data!).message.toString()),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar);
      }
    } else {
      print(response.statusCode);
    }
  }
  signup(int? data){
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>AllDoneScreen(email:emailController.text.toString())));
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    //autoLogIn();
  }
  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    // Do some stuff.
    return true;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/signup_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(color: Colors.white.withAlpha(100),
          margin: EdgeInsets.fromLTRB(20, 100, 20, 10),
          child: ListView(children: [
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const Text("SIGN UP",
                    style: TextStyle(
                        fontSize: 24, color: ColorConstants.txt))),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextFormField(
                controller: emailController,
                obscureText: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Email ID*',
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextFormField(
                controller: usernameController,
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
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                cursorColor: ColorConstants.txt,
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
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextFormField(
                controller: repeatpasswordController,
                obscureText: true,
                cursorColor: ColorConstants.txt,
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
              ),
            ),
            Container(
              color: Colors.white,
              margin:EdgeInsets.fromLTRB(0, 20, 10, 10),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "I agree to the terms and conditions*",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: ColorConstants.txt),
                  ),
                  GestureDetector(
                    onTap: () {
                     setState(() {
                       value=!value;
                       print(value);
                     });
                    },
                    child: value == true
                        ? Container(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "assets/images/check_box_with_tick.png",
                        height: 20,
                        width: 20,
                      ),
                    )
                        : Container(
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

            Container(
              child: Center(
                child: ElevatedButton(
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
                    if (emailController.text.isNotEmpty) {
                      if (usernameController.text.isNotEmpty) {
                        if(passwordController.text.isNotEmpty ){
                        if (passwordController.text.toString() == repeatpasswordController.text.toString()) {
                          if(value==true){
                            steponeapi(emailController.text.toString(),
                                usernameController.text.toString(),
                                repeatpasswordController.text.toString());
                          }else{
                            const snackBar = SnackBar(
                              content: Text('Please agree to term and conditions'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        } else {
                          const snackBar = SnackBar(
                            content: Text('Please check password'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                        else {
                          const snackBar = SnackBar(
                            content: Text('Please fill password'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }else {
                        const snackBar = SnackBar(
                          content: Text('Please fill username'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Please fill email address'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text(
                    "NEXT",
                    style:
                    TextStyle(color: ColorConstants.txt, fontSize: 16),
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
